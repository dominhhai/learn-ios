//
//  CommentViewController.m
//  TaiLocPhat
//
//  Created by Maximus on 10/5/13.
//  Copyright (c) 2013 Hai Do Minh. All rights reserved.
//

#import "CommentViewController.h"

static UIImage* lefthandImage = nil;
static UIImage* righthandImage = nil;

@interface CommentViewController ()

@end

@implementation CommentViewController

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
    lefthandImage = [[UIImage imageNamed:@"BubbleLefthand"]
                     stretchableImageWithLeftCapWidth:20 topCapHeight:19];
    
    righthandImage = [[UIImage imageNamed:@"BubbleRighthand"]
                      stretchableImageWithLeftCapWidth:20 topCapHeight:19];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
