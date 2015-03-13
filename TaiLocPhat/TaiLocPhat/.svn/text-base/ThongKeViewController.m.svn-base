//
//  ThongKeViewController.m
//  TaiLocPhat
//
//  Created by Maximus on 9/15/13.
//  Copyright (c) 2013 Hai Do Minh. All rights reserved.
//

#import "ThongKeViewController.h"

@interface ThongKeViewController ()

@end

@implementation ThongKeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (id)init{
//    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
        self = [super initWithNibName:@"ThongKeViewController_ipad" bundle:nil];
    }else{
        self = [super initWithNibName:@"ThongKeViewController_iphone" bundle:nil];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
