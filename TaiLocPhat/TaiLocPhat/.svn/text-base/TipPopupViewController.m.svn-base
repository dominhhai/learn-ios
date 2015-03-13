//
//  TipPopupViewController.m
//  TaiLocPhat
//
//  Created by Maximus on 10/6/13.
//  Copyright (c) 2013 Hai Do Minh. All rights reserved.
//

#import "TipPopupViewController.h"

@interface TipPopupViewController ()

@end

@implementation TipPopupViewController

@synthesize textView;
@synthesize label;

NSString* content;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)initWithContent:(NSString*)pcontent {
    self = [super initWithNibName:@"TipPopupViewController" bundle:nil];
    if (self) {
        content = pcontent;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
        self.view.frame = CGRectMake(0, 0, 600, 600);
        self.label.font = [UIFont systemFontOfSize:24];
        self.textView.font = [UIFont systemFontOfSize:22];
    }
    
    self.textView.text = content;    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setTextView:nil];
    [super viewDidUnload];
}
@end
