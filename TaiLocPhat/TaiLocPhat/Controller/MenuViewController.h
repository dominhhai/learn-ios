//
//  MenuViewController.h
//  TaiLocPhat
//
//  Created by Hai Do Minh on 8/1/13.
//  Copyright (c) 2013 Hai Do Minh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeAllViewController.h"

@interface MenuViewController : UIViewController

// donot manage the view transition (memory managerment problem)
// I just target to get the ap laucher.

@property (nonatomic, retain) IBOutlet UIButton *btnMienBac;
@property (nonatomic, retain) IBOutlet UIButton *btnMienTrung;
@property (nonatomic, retain) IBOutlet UIButton *btnMienNam;

-(IBAction)choseLocation:(id)sender;

@end
