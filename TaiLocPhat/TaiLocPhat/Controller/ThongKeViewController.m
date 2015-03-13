//
//  ThongKeViewController.m
//  TaiLocPhat
//
//  Created by Hai Do Minh on 8/6/13.
//  Copyright (c) 2013 Hai Do Minh. All rights reserved.
//

#import "ThongKeViewController.h"
#import "SubHomeTableViewController.h"
#import "TkNhanhViewController.h"

@implementation ThongKeViewController {
    NSArray *DBOptions;
    SubHomeTableViewController *tableViewController;
}

@synthesize containView = containView;
@synthesize subHomeSegmentTitle = subHomeSegmentTitle;
@synthesize segConSubHome = segConSubHome;

-(id)initWithSegConSubHome: (UISegmentedControl *)paramSennder {
    self = [self init];
    if (self) {
        self.segConSubHome = paramSennder;
        [self doCustomSubHomeSegment];
        
        DBOptions = [NSArray arrayWithObjects:
                     [NSDictionary dictionaryWithObjectsAndKeys:[UIImage imageNamed:@"facebook.png"],@"img",@"Facebook",@"text", nil],
                     [NSDictionary dictionaryWithObjectsAndKeys:[UIImage imageNamed:@"twitter.png"],@"img",@"Twitter",@"text", nil],
                     [NSDictionary dictionaryWithObjectsAndKeys:[UIImage imageNamed:@"tumblr.png"],@"img",@"Tumblr",@"text", nil],
                     [NSDictionary dictionaryWithObjectsAndKeys:[UIImage imageNamed:@"google-plus.png"],@"img",@"Google+",@"text", nil],
                     nil];
    }
    return self;
}

-(id)initWithSegConSubHome: (UISegmentedControl *)paramSennder containView: (UIView *)pContainView {
    self = [self initWithSegConSubHome:paramSennder];
    if (self) {
        self.containView = pContainView;
        [self onSubHomeSegmentChanged:0];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)doCustomSubHomeSegment {
    self.subHomeSegmentTitle = @[@"T.K Nhanh", @"T.K Đặc Biệt"];
    
    [self.segConSubHome setTitle:self.subHomeSegmentTitle[0] forSegmentAtIndex:0];
    [self.segConSubHome setTitle:self.subHomeSegmentTitle[1] forSegmentAtIndex:1];
    
    [self.segConSubHome setSelectedSegmentIndex:0];
}

-(void)doSetSubLocation: (NSInteger)subLocation{
    // do logic change location here
    NSLog(@"ThongKeViewController: doSetSubLocation: %d", subLocation);
}

-(void)onSubHomeSegmentChanged: (NSInteger)selectedIndex{
    NSLog(@"ThongKeViewController: onSubHomeSegmentChanged: %d", selectedIndex);
    // remove all subview before set new
    for (id view in self.containView.subviews) {
        [view removeFromSuperview];
    }
    
    if (selectedIndex == 0) {
        TkNhanhViewController *tkNhanh = [[TkNhanhViewController alloc] init];
        tkNhanh.view.backgroundColor = nil;
        [self.containView addSubview:tkNhanh.view];
    } else if (selectedIndex == 1) {
        [self showDacBietDialog];
    }
}

-(void)showDacBietDialog {
    LeveyPopListView *lplv = [[LeveyPopListView alloc] initWithTitle:@"Chọn loại ĐB" options:DBOptions];
    lplv.delegate = self;
    [lplv showInView:[[[UIApplication sharedApplication] windows] lastObject] animated:YES];
}

#pragma mark - LeveyPopListView delegates
- (void)leveyPopListView:(LeveyPopListView *)popListView didSelectedIndex:(NSInteger)anIndex {
    [self showDBViewWithDBType:anIndex];
}
- (void)leveyPopListViewDidCancel {
}

-(void) showDBViewWithDBType:(NSInteger)anIndex {
    NSLog(@"showDBViewWithDBType: %d", anIndex);
    if (tableViewController != nil) {
        [tableViewController.view removeFromSuperview];
    }
    tableViewController = [[SubHomeTableViewController alloc] initWithCellType:1];
    [self.containView addSubview:tableViewController.view];
}

@end
