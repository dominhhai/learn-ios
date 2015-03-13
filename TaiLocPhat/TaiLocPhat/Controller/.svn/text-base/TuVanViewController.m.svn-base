//
//  TuVanViewController.m
//  TaiLocPhat
//
//  Created by Hai Do Minh on 8/7/13.
//  Copyright (c) 2013 Hai Do Minh. All rights reserved.
//

#import "TuVanViewController.h"
#import "SubHomeTableViewController.h"

@interface TuVanViewController ()

@end

@implementation TuVanViewController {
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

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
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
        [self doCustomSubHomeSegment];
    }
    return self;
}

-(id)initWithSegConSubHome: (UISegmentedControl *)paramSennder containView: (UIView*)pContainView {
    self = [self initWithSegConSubHome:paramSennder];
    if (self) {
        self.containView = pContainView;
        [self onSubHomeSegmentChanged:0];
    }
    return self;
}

-(void)doSetSubLocation: (NSInteger)subLocation {
    
}

-(void)onSubHomeSegmentChanged: (NSInteger)selectedIndex {
    for (id view in self.containView.subviews) {
        [view removeFromSuperview];
    }
    if (selectedIndex == 0) { // Tips
        if (tableViewController != nil) {
            [tableViewController.view removeFromSuperview];
        }
        tableViewController = [[SubHomeTableViewController alloc] initWithCellType:2];
        [self.containView addSubview:tableViewController.view];
        
    } else { // hoi dap
        // button hoi dap
        UIButton *btnQuestion = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        btnQuestion.frame = CGRectMake(20, 0, 139, 27);
        UIImage *image = [UIImage imageNamed:@"button_cauhoi.png"];
        [btnQuestion setBackgroundImage:image forState:UIControlStateNormal];
        [btnQuestion setBackgroundImage:image forState:UIControlStateHighlighted];
        [btnQuestion addTarget:self action:@selector(btnQuestionEvent:) forControlEvents:UIControlEventTouchDown];
        [self.containView addSubview:btnQuestion];
        // list cau hoi
        if (tableViewController != nil) {
            [tableViewController.view removeFromSuperview];
        }
        tableViewController = [[SubHomeTableViewController alloc] initWithCellType:3];
        tableViewController.view.frame = CGRectMake(20, 35, 280, 300);
        [self.containView addSubview:tableViewController.view];
    }
}

-(void)doCustomSubHomeSegment {
    self.subHomeSegmentTitle = @[@"Tips", @"Thảo luận"];
    
    [self.segConSubHome setTitle:self.subHomeSegmentTitle[0] forSegmentAtIndex:0];
    [self.segConSubHome setTitle:self.subHomeSegmentTitle[1] forSegmentAtIndex:1];
    
    [self.segConSubHome setSelectedSegmentIndex:0];
}

-(IBAction)btnQuestionEvent:(id) sender {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Hoi dap" message:@"noi dung hoi" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alertView show];
}

@end
