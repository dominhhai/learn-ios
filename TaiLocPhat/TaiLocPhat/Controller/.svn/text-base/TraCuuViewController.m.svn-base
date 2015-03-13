//
//  TraCuuViewController.m
//  TaiLocPhat
//
//  Created by Maximus on 8/4/13.
//  Copyright (c) 2013 Hai Do Minh. All rights reserved.
//

#import "TraCuuViewController.h"
#import "SubHomeTableViewController.h"

@interface TraCuuViewController ()

@end

@implementation TraCuuViewController {
    NSString *setDate;
    SubHomeTableViewController *tableViewController;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


// default T.
- (void)viewDidLoad
{
    [super viewDidLoad];  
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(id)initWithSegConSubHome: (UISegmentedControl *)paramSennder {
    self = [self init];
    if (self) {
        self.segConSubHome = paramSennder;
    }
    return self;
}

-(id)initWithSegConSubHome: (UISegmentedControl *)paramSennder containView: (UIView*)pContainView {
    self = [self initWithSegConSubHome:paramSennder];
    if (self) {
        self.containView = pContainView;
    }
    return self;
}

-(id)initWithSegConSubHome: (UISegmentedControl *)paramSennder containView: (UIView*)pContainView forDate:(BOOL)forDate {
    self = [self initWithSegConSubHome:paramSennder containView:pContainView];
    if (self) {
        self.forAllDate = forDate;
    }
    [self doCustomSubHomeSegment];
//    [self onSubHomeSegmentChanged:0];
    [self updateData];
    return self;
}

-(void)doSetSubLocation: (NSInteger)subLocation {
    NSLog(@"TraCuViewController: doSetSubLocation: %d", subLocation);
}

-(void)onSubHomeSegmentChanged: (NSInteger)selectedIndex {
     NSLog(@"TraCuViewController: onSubHomeSegmentChanged: %d", selectedIndex);
//    for (id view in self.containView.subviews) {
//        [view removeFromSuperview];
//    }
    if (selectedIndex == 0) { // soi lo <-> de
        if([[self.segConSubHome titleForSegmentAtIndex:0] isEqualToString: @"Soi lô"]){
            [self.segConSubHome setTitle:@"Xổ số" forSegmentAtIndex:0];
        }else{
            [self.segConSubHome setTitle:@"Soi lô" forSegmentAtIndex:0];
        }
        
        // up date data ,and setting
        [self updateData];
    } else { // date
        if (self.forAllDate) { // check if enable date picker
            [self showDatePicker];
        }
    }
}

-(void)showDatePicker {
    UIBarButtonItem *doneButton;
    UIBarButtonItem *cancelButton;
    UIBarButtonItem *flexibleSpace;
    
    // toolbar
    self.toolbar = [[UIToolbar alloc] init];
    self.toolbar.frame=CGRectMake(0,self.segConSubHome.bounds.size.height,
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
    [self.containView addSubview: self.toolbar];
    
    
    // date picker
    self.datePicker = [[UIDatePicker alloc]init];
    self.datePicker.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.datePicker.datePickerMode = UIDatePickerModeDate;
    [self.datePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
    CGSize pickerSize = [self.datePicker sizeThatFits:CGSizeZero];
    self.datePicker.frame = CGRectMake(0.0, self.segConSubHome.bounds.size.height + self.toolbar.bounds.size.height, pickerSize.width, 460);
    [self.datePicker setMaximumDate:[NSDate date]];
    [self.containView addSubview:self.datePicker];
}

-(void) dateChanged:(UIDatePicker *)sender {
    self.pickedDate = [self.dateFormatter stringFromDate:[sender date]];
//    NSLog(@"Date Change: %@", self.pickedDate);
}

-(void)doneClicked:(id)sender
{
    BOOL change = FALSE;
    [self.toolbar removeFromSuperview];
    [self.datePicker removeFromSuperview];

    if((self.pickedDate != nil)  && ([self.pickedDate isEqualToString:setDate] == 0)){
        setDate = self.pickedDate;
        [self.segConSubHome setTitle:setDate forSegmentAtIndex:1];
        change = TRUE;
    }

    // should fetch data here
    if(change){
        [self updateData];
    }
    
}

-(void)cancelClicked:(id)sender
{
    NSLog(@"cancel picker");
    [self.toolbar removeFromSuperview];
    [self.datePicker removeFromSuperview];
}

-(void)updateData{
    NSLog(@"***Fetch data***");
    if (tableViewController != nil) {
        [tableViewController.view removeFromSuperview];
    }
    tableViewController = [[SubHomeTableViewController alloc] initWithCellType:0];
    [self.containView addSubview:tableViewController.view];
    // update setting
//    [self.giaiViewControler removeFromParentViewController];
//    self.giaiViewControler = [[GiaiViewController alloc] initWithMode:self.mode on:self.date in:self.location];
//    [self.resultView addSubview:self.giaiViewControler.view];
}


-(void)doCustomSubHomeSegment {
    if (self.forAllDate) {
        self.dateFormatter = [[NSDateFormatter alloc]init];
        self.dateFormatter.dateFormat = @"dd/MM/yy";
        
        setDate = [self.dateFormatter stringFromDate: [NSDate date]];
    } else {
        setDate = @"";
    }
    
    self.subHomeSegmentTitle = @[@"Soi lô", setDate];
    
    [self.segConSubHome setTitle:self.subHomeSegmentTitle[0] forSegmentAtIndex:0];
    [self.segConSubHome setTitle:self.subHomeSegmentTitle[1] forSegmentAtIndex:1];
    
//    [self.segConSubHome setSelectedSegmentIndex:0];
}

@end
