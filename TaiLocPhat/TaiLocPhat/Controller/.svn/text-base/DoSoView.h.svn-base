//
//  DoSoView.h
//  TaiLocPhat
//
//  Created by Maximus on 8/4/13.
//  Copyright (c) 2013 Hai Do Minh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SubHomeTabDelegate.h"
#import "LeveyPopListView.h"

@interface DoSoView : UIView <SubHomeTabDelegate>

-(IBAction)textReturn:(id)sender;
-(IBAction)textFieldSetting:(id)sender;
-(IBAction)btnDoSoTouchDownEvent:(id)sender;

@property (nonatomic, retain) UISegmentedControl *segConSubHome;

-(id)initWithSegConSubHome: (UISegmentedControl *)paramSennder;

-(void)doSetSubLocation: (NSInteger)subLocation;

-(void)onSubHomeSegmentChanged: (NSInteger)selectedIndex;

@end
