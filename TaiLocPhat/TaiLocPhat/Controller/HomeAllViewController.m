//
//  HomeAllViewController.m
//  TaiLocPhat
//
//  Created by Hai Do Minh on 8/6/13.
//  Copyright (c) 2013 Hai Do Minh. All rights reserved.
//

#import "HomeAllViewController.h"

@interface HomeAllViewController ()


@end

@implementation HomeAllViewController {
    NSArray *homeSegConTitle;
    NSArray *homeSegConTitle_back;
    NSArray *options;
}

- (id)initWithLocation: (NSInteger) location
{
    self = [self initWithNibName:@"HomeAllViewController" bundle:nil];
    if (self) {
        // Custom initialization
        self.curLocation = location;
        NSLog(@"HomeAllViewController: init with location = %d", self.curLocation);
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        homeSegConTitle_back = [NSArray arrayWithObjects:
                                [UIImage imageNamed:@"img_report_tab_back.png"],
                                [UIImage imageNamed:@"search_result_back.png"],
                                [UIImage imageNamed:@"img_statistic_tap_back.png"],
                                [UIImage imageNamed:@"img_picknum_back.png"],
                                [UIImage imageNamed:@"img_tips_back.png"], nil
                                ];
        homeSegConTitle = [NSArray arrayWithObjects:
                           [UIImage imageNamed:@"img_report_tab.png"],
                           [UIImage imageNamed:@"search_result.png"],
                           [UIImage imageNamed:@"img_statistic_tap.png"],
                           [UIImage imageNamed:@"img_picknum.png"],
                           [UIImage imageNamed:@"img_tips.png"], nil
                           ];
        
        
        options = [NSArray arrayWithObjects:
                   [NSDictionary dictionaryWithObjectsAndKeys:[UIImage imageNamed:@"facebook.png"],@"img",@"Facebook",@"text", nil],
                   [NSDictionary dictionaryWithObjectsAndKeys:[UIImage imageNamed:@"twitter.png"],@"img",@"Twitter",@"text", nil],
                   [NSDictionary dictionaryWithObjectsAndKeys:[UIImage imageNamed:@"tumblr.png"],@"img",@"Tumblr",@"text", nil],
                   [NSDictionary dictionaryWithObjectsAndKeys:[UIImage imageNamed:@"google-plus.png"],@"img",@"Google+",@"text", nil],
                   [NSDictionary dictionaryWithObjectsAndKeys:[UIImage imageNamed:@"linkedin.png"],@"img",@"LinkedIn",@"text", nil],
                   [NSDictionary dictionaryWithObjectsAndKeys:[UIImage imageNamed:@"pinterest.png"],@"img",@"Pinterest",@"text", nil],
                   [NSDictionary dictionaryWithObjectsAndKeys:[UIImage imageNamed:@"dribbble.png"],@"img",@"Dribbble",@"text", nil],
                   [NSDictionary dictionaryWithObjectsAndKeys:[UIImage imageNamed:@"deviant-art.png"],@"img",@"deviantArt",@"text", nil],
                   nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    [self.segConHome addTarget:self action:@selector(onHomeSegmentChanged:) forControlEvents:UIControlEventValueChanged];
    [self.segConSubHome addTarget:self action:@selector(onSubHomeSegmentChanged:) forControlEvents:UIControlEventValueChanged];
    
    // first lauch
    self.preSegConHomeIndex = -1;
    [self.segConHome setSelectedSegmentIndex:0];
    [self onHomeSegmentChanged:self.segConHome];
    [self onLocationSegmentChanged:0];
    
    // custom segment control
    self.segConHome.momentary = NO;
    [self.segConHome setBackgroundImage:[UIImage imageNamed:@"img_report_center.png"]
                               forState:UIControlStateNormal
                             barMetrics:UIBarMetricsDefault];
    
    [self.segConHome setBackgroundImage:[UIImage imageNamed:@"img_report_center.png"]
                               forState:UIControlStateSelected
                             barMetrics:UIBarMetricsDefault];
    
    self.segConSubHome.momentary = TRUE;
    
    // Custom the text and set background
    [self.segConSubHome setBackgroundImage:[UIImage imageNamed:@"img_report_center.png"]
                                  forState:UIControlStateNormal
                                barMetrics:UIBarMetricsDefault];
    
    [self.segConSubHome setBackgroundImage:[UIImage imageNamed:@"img_report_center.png"]
                                  forState:UIControlStateSelected
                                barMetrics:UIBarMetricsDefault];
    
    /* Make sure in the normal state of the control that the text is light
     gray color and there is no shadow for the font */
    [self.segConSubHome
     setTitleTextAttributes:@{UITextAttributeTextColor:[UIColor whiteColor],UITextAttributeTextShadowColor:[UIColor clearColor],}
     forState:UIControlStateNormal];
    
    /* In the selected state of the segmented control, make sure the text
     is rendered in white */
//    [self.segConSubHome setTitleTextAttributes:@{UITextAttributeTextColor:[UIColor whiteColor]}
//                                      forState:UIControlStateSelected];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//
// Logic add here
//
-(void)onHomeSegmentChanged: (UISegmentedControl *)paramSennder{
    NSLog(@"onHomeSegmentChanged: %d", [paramSennder selectedSegmentIndex]);
    
    // remove all subview before set new
    for (id view in self.containUIView.subviews) {
        [view removeFromSuperview];
    }
    self.containUIView.backgroundColor = nil;
    
    if (self.preSegConHomeIndex > -1 && self.preSegConHomeIndex < 5) {
        [paramSennder setImage:homeSegConTitle_back[self.preSegConHomeIndex] forSegmentAtIndex:self.preSegConHomeIndex];
    }
    
    self.curSegConHomeIndex = [paramSennder selectedSegmentIndex];
    BOOL isSetDate;
    switch (self.curSegConHomeIndex) {
        case 0: // Tuong Thuat : khong co ngay
        case 1: // So KQ :  co ngay
            isSetDate = self.curSegConHomeIndex == 1;
            self.traCuuViewController = [[TraCuuViewController alloc] initWithSegConSubHome:self.segConSubHome containView:self.containUIView forDate:isSetDate];
            break;
            
        case 2: // Thong Ke
            self.thongKeViewController = [[ThongKeViewController alloc] initWithSegConSubHome:self.segConSubHome containView:self.containUIView];
            break;
            
        case 3: // Do So
            self.doSoView = [[DoSoView alloc] initWithSegConSubHome:self.segConSubHome];
            [self.containUIView addSubview:self.doSoView];
            break;
            
        case 4: // Tu Van
            self.tuVanViewController = [[TuVanViewController alloc] initWithSegConSubHome:self.segConSubHome containView:self.containUIView];
            break;
            
        default:
            break;
    }
    if (self.curSegConHomeIndex > -1 && self.curSegConHomeIndex < 5) {
        [paramSennder setImage:homeSegConTitle[self.curSegConHomeIndex] forSegmentAtIndex:self.curSegConHomeIndex];
    }
    self.preSegConHomeIndex = self.curSegConHomeIndex;
}

-(void)onLocationSegmentChanged:(NSInteger)selectedLocationIndex {
    [self.segConSubHome setTitle:options[selectedLocationIndex][@"text"] forSegmentAtIndex:2];
    // set Current Tab
    switch (self.curSegConHomeIndex) {
        case 0:
        case 1:
            [self.traCuuViewController doSetSubLocation:selectedLocationIndex];
            break;
        case 2:
            [self.thongKeViewController doSetSubLocation:selectedLocationIndex];
            break;
            
        case 3:
            [self.doSoView doSetSubLocation:selectedLocationIndex];
            break;
            
         case 4:
            [self.tuVanViewController doSetSubLocation:selectedLocationIndex];
            break;
            
        default:
            break;
    }
}

-(void)onSubHomeSegmentChanged: (UISegmentedControl *)paramSennder{
    NSLog(@"onSubHomeSegmentChanged: %d", [paramSennder selectedSegmentIndex]);
    if (paramSennder.selectedSegmentIndex == 2) { // Sub Location Tab
        // do select sub location
        [self showListView];
    } else {
        switch (self.curSegConHomeIndex) {
            case 0:         
            case 1:
                [self.traCuuViewController onSubHomeSegmentChanged:paramSennder.selectedSegmentIndex];
                break;
                
            case 2:
                [self.thongKeViewController onSubHomeSegmentChanged:paramSennder.selectedSegmentIndex];
                break;
                
            case 4:
                [self.tuVanViewController onSubHomeSegmentChanged:paramSennder.selectedSegmentIndex];
                break;
                
            default:
                break;
        }
    }
}

- (void)showListView {
    LeveyPopListView *lplv = [[LeveyPopListView alloc] initWithTitle:@"Chọn địa điểm" options:options];
    lplv.delegate = self;
    [lplv showInView:[[[UIApplication sharedApplication] windows] lastObject] animated:YES];
}

#pragma mark - LeveyPopListView delegates
- (void)leveyPopListView:(LeveyPopListView *)popListView didSelectedIndex:(NSInteger)anIndex {
    //    NSLog(@"did List View: %d", anIndex);
    [self onLocationSegmentChanged:anIndex];
}
- (void)leveyPopListViewDidCancel {
}

@end
