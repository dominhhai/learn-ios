//
//  MenuViewController.m
//  TaiLocPhat
//
//  Created by Hai Do Minh on 8/1/13.
//  Copyright (c) 2013 Hai Do Minh. All rights reserved.
//

#import "MenuViewController.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

@synthesize btnMienBac = btnMienBac;
@synthesize btnMienTrung = btnMienTrung;
@synthesize btnMienNam = btnMienNam;

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
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBar.hidden = YES;
}
- (IBAction)choseLocation:(id)sender{
    NSInteger location = -1;
    if (sender == btnMienBac) {
        NSLog(@"Click on Mien Bac");
        location = 0;
    } else if (sender == btnMienTrung) {
        NSLog(@"Click on Mien Trung");
        location = 1;
    } else {
        NSLog(@"Click on Mien Nam");
        location = 2;
    }

    HomeAllViewController *homeViewController = [[HomeAllViewController alloc] initWithLocation:location];
    [self.navigationController pushViewController:homeViewController animated:YES];    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
