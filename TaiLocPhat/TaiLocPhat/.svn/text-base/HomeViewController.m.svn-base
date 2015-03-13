//
//  HomeViewController.m
//  TaiLocPhat
//
//  Created by Maximus on 9/14/13.
//  Copyright (c) 2013 Hai Do Minh. All rights reserved.
//

#import "HomeViewController.h"

#import "MenuViewController.h"
#import "InfoViewController.h"
#import "LocationTableViewController.h"
#import "NetworkController.h"

@interface HomeViewController ()
@property (strong, atomic) MenuViewController* menuViewController;
@property (strong, atomic) InfoViewController* infoViewController;
@property (retain, atomic) UIPopoverController* popoverController;

// location popover
@property (strong, atomic) LocationTableViewController *locationTableViewController;
@property (strong, atomic) NSArray *locationArray;
@property (strong, atomic) NSString *chossenLocation;
// local iphone
@property (strong, atomic) NSArray *options;


// KEY: locaition name VALUE: gio tuong thuat
@property (retain, nonatomic) NSMutableDictionary *locationData;

// date picker
@property (strong, atomic) UIDatePicker *datePicker;
@property (strong, atomic) UIToolbar *toolbar;
@property (strong, nonatomic) NSDateFormatter *dateFormatter;
@property (strong, nonatomic) NSString *pickedDate;


- (void)showDatePicker;
@end

@implementation HomeViewController
@synthesize popoverController;

-(void) showTickerWithNewAdmod:(NSString*) admod {
    if (self.menuViewController != nil) {
        [self.menuViewController showTickerWithNewAdmod:admod];
    }
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void) updateHasDataLocationData:(NSString*)key value:(NSString*)value {
    [self.locationData setValue:value forKey:key];
    self.menuViewController.locationData = self.locationData;
    // update other dependencies
    self.locationArray = [self.locationData allKeys];    
    self.options = [self setIphoneLocationPicker];
}

- (id)initWithLocation:(NSMutableDictionary *)locationData curLocation:(NSString *) curLocation
{
//    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
        self = [super initWithNibName:@"HomeViewController_ipad" bundle:nil];
    }else{
        self = [super initWithNibName:@"HomeViewController_iphone" bundle:nil];
    }
    
    if(self){
        _locationData = locationData;
        _menuViewController = [[MenuViewController alloc] initWithLocation:curLocation areaData:_locationData];
        _infoViewController = [[InfoViewController alloc] initWithLocation:curLocation homeViewController:self];
        // layout for the infoView
        _infoViewController.view.frame = CGRectMake(0, _menuViewController.view.bounds.size.height,[UIScreen mainScreen].bounds.size.width, self.view.bounds.size.height  - _menuViewController.view.bounds.size.height);

        // setup protocol
        _infoViewController.viewToMenuProtocol = _menuViewController;
        
        // add child
        [self.view addSubview:_menuViewController.view ];
        [self.view addSubview:_infoViewController.view/*inforViewArea*/];
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
    }
    
    return  self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.dateFormatter = [[NSDateFormatter alloc]init];
    self.dateFormatter.dateFormat = @"dd/MM/yy";
    
    // implement protocol
    self.menuViewController.menuActionProtocol = self.infoViewController;
    self.menuViewController.menuToHomeProtocol = self;
    
    self.locationArray = [self.locationData allKeys];
    
    self.options = [self setIphoneLocationPicker];
    
}
- (NSArray *)setIphoneLocationPicker{
    NSMutableArray * locationArr = [[NSMutableArray alloc]init];
    NSInteger length = [self.locationArray count];
    
    //NSDictionary *data
    
    for(NSInteger i = 0; i < length; i++){
        [locationArr addObject:[NSDictionary dictionaryWithObjectsAndKeys:[UIImage imageNamed:@"star.png"],@"img",self.locationArray[i],@"text", nil]];
    }
    
    return locationArr;
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)showIpadLocationPicker{
    UIBarButtonItem *doneButton;
    UIBarButtonItem *cancelButton;
    UIBarButtonItem *flexibleSpace;
    UIToolbar *toolbar;
    UIViewController* popoverContent = [[UIViewController alloc] init];
        
    
    UIView *popoverView = [[UIView alloc] init];
    popoverView.backgroundColor = [UIColor whiteColor];
    popoverView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    
    NSArray *curOptions = nil;
    if (self.menuViewController.curMainMenuItemIndex == 0 || self.menuViewController.curMainMenuItemIndex == 4) {
        curOptions = self.locationArray;
    } else {
        curOptions = [NetworkController shared].app.locationArray_full;
    }

    self.locationTableViewController = [[LocationTableViewController alloc]initLocationArray:curOptions];
    
    self.locationTableViewController.view.frame = CGRectMake(0, 44, 320, 500);
    
    // toolbar
    toolbar = [[UIToolbar alloc] init];
    toolbar.frame=CGRectMake(0,0,320, 44);
    toolbar.barStyle = UIBarStyleBlackTranslucent;
    
    cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel"
                                                    style:UIBarButtonItemStyleDone target:self
                                                   action:@selector(cancelClicked:)];
    
    flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                  target:nil
                                                                  action:nil];
    
    doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                  style:UIBarButtonItemStyleDone target:self
                                                 action:@selector(doneClicked:)];
    
    
    [toolbar setItems:[NSArray arrayWithObjects:cancelButton, flexibleSpace, doneButton, nil]];
    [popoverView addSubview: toolbar];
    [popoverView addSubview:self.locationTableViewController.view];
    
    popoverContent.view = popoverView;
    self.popoverController = [[UIPopoverController alloc] initWithContentViewController:popoverContent];
    //self.popoverController=self;
    
    CGRect frame = [self.menuViewController.subSegmentedView frame];
    frame = CGRectMake(frame.size.width,
                      frame.origin.y, frame.size.width/3, self.menuViewController.subSegmentedView.bounds.size.height);
                      
    [self.popoverController setPopoverContentSize:CGSizeMake(320, 600) animated:NO];
    [self.popoverController presentPopoverFromRect:frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
}




- (void)showIpadDatePicker{
    UIBarButtonItem *doneButton;
    UIBarButtonItem *cancelButton;
    UIBarButtonItem *flexibleSpace;
    UIToolbar *toolbar;
    UIDatePicker *datePicker;
    
    UIViewController* popoverContent = [[UIViewController alloc] init];
    
    UIView *popoverView = [[UIView alloc] init];
    popoverView.backgroundColor = [UIColor blackColor];
    
    datePicker=[[UIDatePicker alloc]init];
    datePicker.frame=CGRectMake(0,44,320, 216);
    datePicker.datePickerMode = UIDatePickerModeDate;
    [datePicker setMinuteInterval:5];
    [datePicker setTag:10];
    [datePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
    //    [datePicker addTarget:self action:@selector(dateChanged) forControlEvents:UIControlEventValueChanged];
    
    // toolbar
    toolbar = [[UIToolbar alloc] init];
    toolbar.frame=CGRectMake(0,0,320, 44);
    toolbar.barStyle = UIBarStyleBlackTranslucent;
    
    cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel"
                                                    style:UIBarButtonItemStyleDone target:self
                                                   action:@selector(cancelClicked:)];
    
    flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                  target:nil
                                                                  action:nil];
    
    doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                  style:UIBarButtonItemStyleDone target:self
                                                 action:@selector(doneClicked:)];
    
    
    [toolbar setItems:[NSArray arrayWithObjects:cancelButton, flexibleSpace, doneButton, nil]];
    [popoverView addSubview: toolbar];
    
    
    [popoverView addSubview:datePicker];
    
    popoverContent.view = popoverView;
    self.popoverController = [[UIPopoverController alloc] initWithContentViewController:popoverContent];
    //self.popoverController=self;
    
    [self.popoverController setPopoverContentSize:CGSizeMake(320, 264) animated:NO];
    [self.popoverController presentPopoverFromRect:self.menuViewController.subSegmentedView.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}



-(void)showDatePicker {
    UIBarButtonItem *doneButton;
    UIBarButtonItem *cancelButton;
    UIBarButtonItem *flexibleSpace;

    
    
    // date picker
    self.datePicker = [[UIDatePicker alloc]init];
    self.datePicker.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.datePicker.datePickerMode = UIDatePickerModeDate;
    [self.datePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
    CGSize pickerSize = [self.datePicker sizeThatFits:CGSizeZero];
    self.datePicker.frame = CGRectMake(0.0,self.view.bounds.size.height - pickerSize.height, pickerSize.width, 460);
    [self.datePicker setMaximumDate:[NSDate date]];
    
    
    // toolbar
    self.toolbar = [[UIToolbar alloc] init];
    self.toolbar.frame=CGRectMake(0,self.view.bounds.size.height - pickerSize.height - 44,
                                  self.view.bounds.size.width, 44);
    self.toolbar.barStyle = UIBarStyleBlackTranslucent;
    
    cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel"
                                                    style:UIBarButtonItemStyleDone target:self
                                                   action:@selector(cancelClicked:)];
    
    flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                  target:nil
                                                                  action:nil];
    
    doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                  style:UIBarButtonItemStyleDone target:self
                                                 action:@selector(doneClicked:)];
    
    
    [self.toolbar setItems:[NSArray arrayWithObjects:cancelButton, flexibleSpace, doneButton, nil]];
    [self.view addSubview:self.toolbar];
    

    [self.view addSubview:self.datePicker];
}

-(void) dateChanged:(UIDatePicker *)sender {
    self.pickedDate = [self.dateFormatter stringFromDate:[sender date]];
     // NSLog(@"Date Change: %@", self.pickedDate);
}

-(void)doneClicked:(id)sender
{
    // NSLog(@"Done picker");
//    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
        
        if(self.locationTableViewController != nil && self.locationTableViewController.chossenLocation != nil){
            self.chossenLocation = self.locationTableViewController.chossenLocation;
             // NSLog(@"choose %@",self.chossenLocation);
            self.menuViewController.location = self.chossenLocation;
            [self.menuViewController updateLocation:self.chossenLocation];
            
            [self.menuViewController.subSegmentedView setTitle:self.chossenLocation forSegmentAtIndex:2];
            // only Mien Bac can view T.K Dac Biet
            if (self.menuViewController.curMainMenuItemIndex == 2) {
                if ([self.menuViewController.location isEqualToString:@"Miền Bắc"]) {
                    [self.menuViewController.subSegmentedView setTitle:@"T.K đặc biệt" forSegmentAtIndex:1];
                } else {
                    [self.menuViewController.subSegmentedView setTitle:@"" forSegmentAtIndex:1];
                    self.menuViewController.subMenuItem = @"T.K nhanh";
                }
            } else if (self.menuViewController.curMainMenuItemIndex == 0) {
                // notify picker
                [self.menuViewController showTickerWithArea:self.chossenLocation];
            }
            
            if (![self.menuViewController.subMenuItem isEqualToString:@""]) {
                
                [self.infoViewController changeInfoSubViewWithMainMenu:self.menuViewController.mainMenuItem
                                                            andSubMenu:self.menuViewController.subMenuItem
                                                              withDate:self.menuViewController.date
                                                         withLocattion:self.chossenLocation];
            }
        }
        
    }
    
    self.menuViewController.date = [self.menuViewController.subSegmentedView titleForSegmentAtIndex:1];
    if((self.pickedDate != nil)  && (![self.pickedDate isEqualToString:self.menuViewController.date])){
        self.menuViewController.date = self.pickedDate;
        [self.menuViewController.subSegmentedView setTitle:self.pickedDate forSegmentAtIndex:1];
        [self.menuViewController.menuActionProtocol changeInfoSubViewWithMainMenu:self.menuViewController.mainMenuItem
                                                                       andSubMenu:self.menuViewController.subMenuItem
                                                                         withDate:self.pickedDate
                                                                    withLocattion:self.menuViewController.location];
    }
    
//    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
        [self.popoverController dismissPopoverAnimated:YES];
    }else{
        [self.datePicker removeFromSuperview];
        [self.toolbar removeFromSuperview];
    }
    
}


-(void)cancelClicked:(id)sender
{
    // NSLog(@"cancel picker");
//    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
        [self.popoverController dismissPopoverAnimated:YES];
    }else{
        [self.datePicker removeFromSuperview];
        [self.toolbar removeFromSuperview];
    }
}



- (void)clearPicker{
    
//    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
        if(self.popoverController){
            //// NSLog(@"popover is not nil");
            [self.popoverController dismissPopoverAnimated:YES];
        }
    }else{
        if(self.datePicker){
            //// NSLog(@"picker is not nil");
            [self.datePicker removeFromSuperview];
            [self.toolbar removeFromSuperview];
        }
    }
    
}

-(NSArray*)getCurLocationOptions {
    NSArray *curOptions = nil;
    if (self.menuViewController.curMainMenuItemIndex == 0 || self.menuViewController.curMainMenuItemIndex == 4) {
        curOptions = self.options;
    } else {
        curOptions = [NetworkController shared].app.options_full;
    }
    return curOptions;
}

- (void)showListView {
//    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
        [self showIpadLocationPicker];
    }else{
        LeveyPopListView *lplv = [[LeveyPopListView alloc] initWithTitle:@"Chọn địa điểm" options:[self getCurLocationOptions]];
        lplv.delegate = self;
        
        [lplv showInView:[[[UIApplication sharedApplication] windows] lastObject] animated:YES];
    }
}

#pragma mark - LeveyPopListView delegates
- (void)leveyPopListView:(LeveyPopListView *)popListView didSelectedIndex:(NSInteger)anIndex {    
    self.chossenLocation = [self getCurLocationOptions][anIndex][@"text"];
    self.menuViewController.location = self.chossenLocation;
    [self.menuViewController updateLocation:self.chossenLocation];
    
    [self.menuViewController.subSegmentedView setTitle:self.chossenLocation forSegmentAtIndex:2];
    // only Mien Bac can view T.K Dac Biet
    //isEqualToString:@"ThongKe"]
    if (self.menuViewController.curMainMenuItemIndex == 2) {
        if ([self.menuViewController.location isEqualToString:@"Miền Bắc"]) {
            [self.menuViewController.subSegmentedView setTitle:@"T.K đặc biệt" forSegmentAtIndex:1];
        } else {
            [self.menuViewController.subSegmentedView setTitle:@"" forSegmentAtIndex:1];
            self.menuViewController.subMenuItem = @"T.K nhanh";
        }
    } else if (self.menuViewController.curMainMenuItemIndex == 0) {
        // notify picker
        [self.menuViewController showTickerWithArea:self.chossenLocation];
    }
    
    if (![self.menuViewController.subMenuItem isEqualToString:@""]) {
        
        [self.infoViewController changeInfoSubViewWithMainMenu:self.menuViewController.mainMenuItem
                                                    andSubMenu:self.menuViewController.subMenuItem
                                                      withDate:self.menuViewController.date
                                                 withLocattion:self.chossenLocation];
    }
    
}
- (void)leveyPopListViewDidCancel {
}

@end
