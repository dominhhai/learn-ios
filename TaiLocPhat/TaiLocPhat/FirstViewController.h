//
//  MenuViewController.h
//  TaiLocPhat
//
//  Created by Hai Do Minh on 8/1/13.
//  Copyright (c) 2013 Hai Do Minh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "NetworkResponsedProtocol.h"

@interface FirstViewController : UIViewController <NetworkResponsedProtocol>

@property (nonatomic, retain) IBOutlet UIButton *btnMienBac;
@property (nonatomic, retain) IBOutlet UIButton *btnMienTrung;
@property (nonatomic, retain) IBOutlet UIButton *btnMienNam;

-(IBAction)choseLocation:(id)sender;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil;

@end
