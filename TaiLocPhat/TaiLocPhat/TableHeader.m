//
//  TableHeader.m
//  TaiLocPhat
//
//  Created by Hai Do Minh on 10/6/13.
//  Copyright (c) 2013 Hai Do Minh. All rights reserved.
//

#import "TableHeader.h"

@interface TableHeader ()

@end

@implementation TableHeader

@synthesize lblTitle = _lblTitle;

NSString* title;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)initWithTitle:(NSString*)ptitle {
    NSString* tableheaderbundle = ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) ? @"TableHeader_ipad" : @"TableHeader_iphone";
    self = [super initWithNibName:tableheaderbundle bundle:nil];
    if (self) {
        title = ptitle;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.lblTitle.text = title;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
