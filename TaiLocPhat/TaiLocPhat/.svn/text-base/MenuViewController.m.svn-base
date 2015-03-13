//
//  MainViewController.m
//  TaiLocPhat
//
//  Created by Maximus on 9/14/13.
//  Copyright (c) 2013 Hai Do Minh. All rights reserved.
//

#import "MenuViewController.h"
#import "InfoViewController.h"
#import "NetworkController.h"


@interface MenuViewController (){
    NSDictionary *submenuLabels;
    InfoViewController *infoViewController;
}

@property NSString *today;

@property (atomic) NSInteger preMainMenuItemIndex;

@property (strong, atomic) NSArray *mainSegmentIcon_back;
@property (strong, atomic) NSArray *mainSegmentIcon;



@property (unsafe_unretained, nonatomic) IBOutlet UISegmentedControl *mainSegmentedView;

- (void)initSubMenuLabel;
@end

@implementation MenuViewController

@synthesize savedLocation, curMainMenuItemIndex = _curMainMenuItemIndex;
@synthesize locationData;

CLTickerView *notifyTicker;
NSInteger todayTime;

- (IBAction)backEventHandler:(id)sender {
    [[NetworkController shared].app.navController popToRootViewControllerAnimated:YES];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithLocation:(NSString *)firstChossenLocation areaData:(NSDictionary *)areaData {
    
//    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
        self = [super initWithNibName:@"MenuViewController_ipad" bundle:nil];
    }else{
        self = [super initWithNibName:@"MenuViewController_iphone" bundle:nil];
    }
    
    if(self){
        locationData = areaData;
        _location = firstChossenLocation;
        self.view.backgroundColor = nil;
        // save location for each tab
        self.savedLocation = [[NSMutableArray alloc] initWithCapacity:5];
        NSInteger index = 0;
        for (index = 0; index < 5; index ++) {
            [self.savedLocation addObject:firstChossenLocation];
            // NSLog(@"install location: %d, %@", index, [self.savedLocation objectAtIndex:index]);
        }
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // get submenu label form SubMenuLabel.plist
    [self initSubMenuLabel];    
    
    // get string format of today
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = @"dd/MM/yy";
    self.today = [dateFormatter stringFromDate:[NSDate date]];
    
    NSDateFormatter *dateFormatter_time = [[NSDateFormatter alloc]init];
    dateFormatter_time.dateFormat = @"HH:mm:ss";
    NSString* todayTimeStr = [dateFormatter_time stringFromDate:[NSDate date]];
    todayTime = [self stringToTimeMili:todayTimeStr];
    
    
    // menu icon path
    self.mainSegmentIcon_back = [NSArray arrayWithObjects:
                            [UIImage imageNamed:@"img_report_tab_back.png"],
                            [UIImage imageNamed:@"search_result_back.png"],
                            [UIImage imageNamed:@"img_statistic_tap_back.png"],
                            [UIImage imageNamed:@"img_picknum_back.png"],
                            [UIImage imageNamed:@"img_tips_back.png"], nil
                            ];
    self.mainSegmentIcon = [NSArray arrayWithObjects:
                       [UIImage imageNamed:@"img_report_tab.png"],
                       [UIImage imageNamed:@"search_result.png"],
                       [UIImage imageNamed:@"img_statistic_tap.png"],
                       [UIImage imageNamed:@"img_picknum.png"],
                       [UIImage imageNamed:@"img_tips.png"], nil
                       ];
    
    

    
    
    
    // menu view callback listen
    [self.mainSegmentedView addTarget:self action:@selector(didChangeMainSegmentControl:) forControlEvents:UIControlEventValueChanged];
    [self.subSegmentedView addTarget:self action:@selector(didChangeSubSegmentControl:) forControlEvents:
        UIControlEventValueChanged];
    
    
    
    
    // custom segment control
   self.mainSegmentedView.momentary = NO;
   [self.mainSegmentedView setBackgroundImage:[UIImage imageNamed:@"img_report_center.png"]
                               forState:UIControlStateNormal
                             barMetrics:UIBarMetricsDefault];
    [self.mainSegmentedView setBackgroundImage:[UIImage imageNamed:@"img_report_back.png"]
                               forState:UIControlStateSelected
                                barMetrics:UIBarMetricsDefault];
    [self.mainSegmentedView setDividerImage:[UIImage imageNamed:@"segment-divider.png"] forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
     [self.mainSegmentedView setDividerImage:[UIImage imageNamed:@"segment-divider.png"] forLeftSegmentState:UIControlStateSelected rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [self.mainSegmentedView setSelectedSegmentIndex:0];
    
    
    self.subSegmentedView.momentary = YES;
    [self.subSegmentedView setBackgroundImage:[UIImage imageNamed:@"img_report_center.png"]
                                  forState:UIControlStateNormal
                                barMetrics:UIBarMetricsDefault];
//    [self.subSegmentedView setBackgroundImage:[UIImage imageNamed:@"img_select_area_red.png"]
//                                  forState:UIControlStateSelected
//                                barMetrics:UIBarMetricsDefault];
    [self.subSegmentedView setDividerImage:[UIImage imageNamed:@"segment-divider.png"] forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [self.subSegmentedView setDividerImage:[UIImage imageNamed:@"segment-divider.png"] forLeftSegmentState:UIControlStateSelected rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    /* Make sure in the normal state of the control that the text is light
     gray color and there is no shadow for the font */
    [self.subSegmentedView
     setTitleTextAttributes:@{UITextAttributeTextColor:[UIColor whiteColor],UITextAttributeTextShadowColor:[UIColor clearColor],}
     forState:UIControlStateNormal];
    
    // default action at first launch
    self.curMainMenuItemIndex = 0;
    [self changeMainMenuIcon];
    [self changeSubMenuLabelWithKey:@"TuongThuat" atIndex: self.curMainMenuItemIndex];
    
    // inforView at first launch
    self.mainMenuItem = @"TuongThuat";
    self.subMenuItem = @"Xổ số";
    // location is initiated in construction
    self.date = self.today;

    [self.subSegmentedView setTitle:self.date forSegmentAtIndex:1];
    
    [self showTickerWithArea:self.location];
    
    self.clientIDLabel.text = [NSString stringWithFormat:@"T.viên: %@", [NetworkController shared].app.clientID];
}

-(NSInteger) stringToTimeMili:(NSString*) time {
    NSInteger timeMil = 0;
    NSArray* timeArray = [time componentsSeparatedByString:@":"];
    NSInteger hh = [timeArray[0] integerValue];
    NSInteger mm = [timeArray[1] integerValue];
    NSInteger ss = [timeArray[2] integerValue];
    timeMil = hh * 60 * 60 + mm * 60 + ss;
    return timeMil;
}

-(void) showTickerWithNewAdmod:(NSString*) admod {
    NSMutableString* newMessage = [[NSMutableString alloc] initWithString:admod];
    if (notifyTicker != nil) {
        [newMessage appendFormat:@"   -    %@", notifyTicker.marqueeStr];
        [self hideNotifyTicker];
    }
    [self showNotifyTicker:newMessage];
}

-(void) showTickerWithArea:(NSString*) area {
    // get time area
    NSString* areaTimeStr = [locationData valueForKey:area];
    NSInteger areaTime = [self stringToTimeMili:areaTimeStr];
    NSString* message;
    if (areaTime > todayTime) {
        message = [NSString stringWithFormat:@"Chưa tới giờ tường thuật của %@ (%@)", area, areaTimeStr];
    } else {
        message = [NSString stringWithFormat:@"Kết quả tường thuật của %@", area];
    }
    [self hideNotifyTicker];
    [self showNotifyTicker:message];
}

-(void) showNotifyTicker: (NSString*) notifyMessage {
    // Do any additional setup after loading the view, typically from a nib.
    CGRect notifyFrame;
//    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
        notifyFrame = CGRectMake(232, 80, 368, 60);
    } else {
        notifyFrame = CGRectMake(90, 20, 172
                                 , 30);
    }
    notifyTicker = [[CLTickerView alloc] initWithFrame:notifyFrame];
    notifyTicker.marqueeFont = [UIFont boldSystemFontOfSize:(([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) ? 22: 16)];
    
    notifyTicker.marqueeStr = notifyMessage;
    [self.view addSubview:notifyTicker];
    [notifyTicker startScrolling];
}

-(void) hideNotifyTicker {
    if (notifyTicker != nil) {
        [notifyTicker stopScrolling];
        [notifyTicker removeFromSuperview];
        notifyTicker = nil;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setSubSegmentedView:nil];
    [self setMainSegmentedView:nil];
    [self setSubSegmentedView:nil];
    [self setMainSegmentedView:nil];
    [self setSubSegmentedView:nil];
    [super viewDidUnload];
}



- (void)initSubMenuLabel
{
    submenuLabels = [NSPropertyListSerialization propertyListFromData: [NSData dataWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"SubMenuLable" ofType:@"plist"]] mutabilityOption:NSPropertyListImmutable format:nil errorDescription:nil];
}

- (void) updateLocation:(NSString *)location {
    [self.savedLocation replaceObjectAtIndex:self.curMainMenuItemIndex withObject:location];
}

- (void)changeSubMenuLabelWithKey: (NSString *)key atIndex: (NSInteger)mainIndex
{
    NSArray *labels = [submenuLabels objectForKey:key];
    for( int i = 0; i < 3; i++){
        if((i == 1) && ([self.mainMenuItem isEqualToString:@"TuongThuat"] || [self.mainMenuItem isEqualToString:@"SoKetQua"])){
            [self.subSegmentedView setTitle:self.today forSegmentAtIndex:1];
        }
        else if(i == 2){
//            NSString* tabLocation = [self.savedLocation objectAtIndex:mainIndex];
//            if (tabLocation == nil) {
//                tabLocation = self.location;
//            }
//            [self.subSegmentedView setTitle:tabLocation forSegmentAtIndex:2];
            [self.subSegmentedView setTitle:self.location forSegmentAtIndex:2];
//            // NSLog(@"changeSubMenuLabelWithKey: %@ atIndex: %d, and: %@", key, mainIndex, tabLocation);
        }
        else{
        // NSLog(@"%@", labels[i] );
            if (i == 1 && [self.mainMenuItem isEqualToString:@"ThongKe"]) {
                if ([self.location isEqualToString:@"Miền Bắc"]) {
                    [self.subSegmentedView setTitle:labels[i] forSegmentAtIndex:i];
                } else {
                    [self.subSegmentedView setTitle:@"" forSegmentAtIndex:i];
                    self.subMenuItem = @"T.K nhanh"; 
                }
            } else {
                [self.subSegmentedView setTitle:labels[i] forSegmentAtIndex:i];
            }
        }
    }
    // update location
    
}

- (void)didChangeSubSegmentControl:(UISegmentedControl *)control
{
    NSString *title;
    
    // clear the unuse view (picker)
    //[self.menuToHomeProtocol clearPicker];
    
    switch (control.selectedSegmentIndex) {
        case 0:
            if([self.mainMenuItem isEqualToString:@"TuongThuat"] || [self.mainMenuItem isEqualToString:@"SoKetQua"]){
                if( [[control titleForSegmentAtIndex:control.selectedSegmentIndex] isEqualToString:@"Xổ số"]){
                    title = @"Soi lô";
                }else{
                    title = @"Xổ số";
                }
            // update subsegment view
                // NSLog(@"sellect submain number 1 %@", self.mainMenuItem);
            [control setTitle:title forSegmentAtIndex:control.selectedSegmentIndex];
            
            }else{
                title = [control titleForSegmentAtIndex:control.selectedSegmentIndex];
            }
            
            if (title != nil && ![title isEqualToString:@""]) {
                self.subMenuItem = title;
                if ([self.mainMenuItem isEqualToString:@"TuVan"]) {
                    NSString* tabLocation = [self.savedLocation objectAtIndex:4];
                    if (tabLocation == nil) {
                        tabLocation = self.location;
                    }
                    [control setTitle:tabLocation forSegmentAtIndex:2];
                }
                
                [self.menuActionProtocol changeInfoSubViewWithMainMenu:self.mainMenuItem
                                                            andSubMenu:self.subMenuItem
                                                              withDate:self.date
                                                         withLocattion:self.location];
            }
            break;
            
        case 1:
            // NSLog(@"sellect submain number 2");
            // only mien bac have special statistic
            if(![self.mainMenuItem isEqualToString:@"ThongKe"]  || [self.location isEqualToString:@"Miền Bắc"]){
            // date picker call
            if([self.mainMenuItem isEqualToString:@"SoKetQua"]){
//                if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
                if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
                    [self.menuToHomeProtocol showIpadDatePicker];
                }else{
                    [self.menuToHomeProtocol showDatePicker];
                }

            }else if(![self.mainMenuItem isEqualToString:@"TuongThuat"]){
                title = [control titleForSegmentAtIndex:control.selectedSegmentIndex];
                if (title != nil && ![title isEqualToString:@""]) {
                    self.subMenuItem = title;
                    if ([self.mainMenuItem isEqualToString:@"TuVan"]) {
                        [control setTitle:@"" forSegmentAtIndex:2];
                    }                    
                    [self.menuActionProtocol changeInfoSubViewWithMainMenu:self.mainMenuItem
                                                                andSubMenu:self.subMenuItem
                                                                  withDate:self.date
                                                             withLocattion:self.location];
                }
            }
            
            }
            break;
            
        case 2:
            // NSLog(@"sellect submain number 3");
            title = [control titleForSegmentAtIndex:control.selectedSegmentIndex];
            if (title != nil && ![title isEqualToString:@""]) {
                [self.menuToHomeProtocol showListView];
            }
            break;
            
        default:
            return;
    }
    
}


- (void)didChangeMainSegmentControl:(UISegmentedControl *)control
{
    // clear the unuse view (picker)
    [self.menuToHomeProtocol clearPicker];
    
    self.preMainMenuItemIndex = self.curMainMenuItemIndex;
    self.curMainMenuItemIndex = control.selectedSegmentIndex;
    
    NSString* curTabLocation = [self.savedLocation objectAtIndex:self.curMainMenuItemIndex];
    if (curTabLocation != nil) {
        self.location = curTabLocation;
    }
    if (control.selectedSegmentIndex == 0) {
        // show notify
        [self showTickerWithArea:curTabLocation];
    } else {
        [self hideNotifyTicker];
    }
    
    switch (control.selectedSegmentIndex) {
        case 0:
            self.mainMenuItem = @"TuongThuat";
            self.subMenuItem = @"Xổ số";
            self.date = self.today;
            // keep the location
            
            [self changeSubMenuLabelWithKey:@"TuongThuat" atIndex: self.curMainMenuItemIndex];
            break;
        case 1:
            self.mainMenuItem = @"SoKetQua";
            self.subMenuItem = @"Xổ số";
            self.date = self.today;
            // keep the location
            
            [self changeSubMenuLabelWithKey:@"SoKetQua" atIndex: self.curMainMenuItemIndex];
            break;
            
        case 2:
            self.mainMenuItem = @"ThongKe";
            self.subMenuItem = @"T.K nhanh";
            // keep the location
            
            [self changeSubMenuLabelWithKey:@"ThongKe" atIndex: self.curMainMenuItemIndex];
            // only Mienbac have special statis
//            if(![self.location isEqualToString:@"Miền Bắc"]){
//                [self.subSegmentedView setTitle:@"" forSegmentAtIndex:1];
//            }
            break;
            
        case 3:
            self.mainMenuItem = @"DoSo";
            // keep the location
            
            [self changeSubMenuLabelWithKey:@"DoSo" atIndex: self.curMainMenuItemIndex];
            break;
            
        case 4:
            self.mainMenuItem = @"TuVan";
            self.subMenuItem = @"Soi cầu";
            // keep the location
            
            [self changeSubMenuLabelWithKey:@"TuVan" atIndex: self.curMainMenuItemIndex];
            break;
            
        default:
            break;
    }
    

    // change InfoView's subview
    //[self.menuActionProtocol changeInfoSubViewWithMainMenu:selelctTabName];
    [self.menuActionProtocol changeInfoSubViewWithMainMenu:self.mainMenuItem
                             andSubMenu:self.subMenuItem
                               withDate:self.date
                          withLocattion:self.location];
    [self changeMainMenuIcon];
                                                                   
}
- (void)changeMainMenuIcon{
    [self.mainSegmentedView setImage:self.mainSegmentIcon_back[self.preMainMenuItemIndex] forSegmentAtIndex:self.preMainMenuItemIndex];
    [self.mainSegmentedView setImage:self.mainSegmentIcon[self.curMainMenuItemIndex] forSegmentAtIndex:self.curMainMenuItemIndex];
}

//- (void)changeSubMenuColor: (NSInteger) index {
//    NSLog(@"begin change");
//    UIView *view = [[[[self.subSegmentedView subviews] objectAtIndex:0] subviews] objectAtIndex:index];
//    
////    for (UIView *v in [[[self.subSegmentedView subviews] objectAtIndex:0] subviews]) {
////        NSLog(@"begin change .");
//        if ([view isKindOfClass:[UILabel class]]) {
//            UILabel *label=(UILabel *) view;
//            label.textColor=[UIColor blackColor];
//            NSLog(@"begin changed..");
//        }
////    }
//}

// direction next day  or previous day used dor soketqua
- (void)swipeChangeSoKetQuaDate:(NSString *)direction{
    if([self.mainMenuItem isEqualToString:@"SoKetQua"]){
        NSInteger day;
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        dateFormatter.dateFormat = @"dd/MM/yy";
        NSDate *date = [dateFormatter dateFromString:self.date];
        
        NSDateComponents *components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit |NSHourCalendarUnit | NSMinuteCalendarUnit |NSSecondCalendarUnit fromDate:date];
        
        
        if([direction isEqualToString:@"next"]){
            day = [components day]+1; // U can add as per your requirement
        }else{
            day = [components day]-1; // U can add as per your requirement
        }
        
        [components setDay:day];
        NSDate *newDate = [[NSCalendar currentCalendar] dateFromComponents:components];
        
        // not later than today
        if(!([newDate compare:[NSDate date]] == NSOrderedDescending)){
        self.date = [dateFormatter stringFromDate:newDate];
        [self.subSegmentedView setTitle:self.date forSegmentAtIndex:1];
        [self.menuActionProtocol changeInfoSubViewWithMainMenu:self.mainMenuItem
                                                    andSubMenu:self.subMenuItem
                                                      withDate:self.date
                                                 withLocattion:self.location];
        }
        
    }
}


@end
