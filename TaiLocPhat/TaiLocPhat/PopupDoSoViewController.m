//
//  PopupViewController.m
//  TaiLocPhat
//
//  Created by Maximus on 10/5/13.
//  Copyright (c) 2013 Hai Do Minh. All rights reserved.
//

#import "PopupDoSoViewController.h"

@interface PopupDoSoViewController ()

@end

@implementation PopupDoSoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)init{
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
        self = [super initWithNibName:@"PopupDoSoViewController_ipad" bundle:nil];
    } else {
        self = [super initWithNibName:@"PopupDoSoViewController_iphone" bundle:nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    /*// Do any additional setup after loading the view from its nib.
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
        self.view.frame = CGRectMake(0, 0, 600, 942);
        [self.view sizeToFit];
    }
     */
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setSv:nil];
    [super viewDidUnload];
}
@end
