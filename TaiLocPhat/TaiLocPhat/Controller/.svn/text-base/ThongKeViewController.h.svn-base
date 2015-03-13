//
//  ThongKeViewController.h
//  TaiLocPhat
//
//  Created by Hai Do Minh on 8/6/13.
//  Copyright (c) 2013 Hai Do Minh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SubHomeTabDelegate.h"
#import "LeveyPopListView.h"

@interface ThongKeViewController : UIViewController <SubHomeTabDelegate, LeveyPopListViewDelegate>

@property (nonatomic, retain) UIView *containView;
@property (nonatomic, retain) NSArray *subHomeSegmentTitle;
@property (nonatomic, retain) UISegmentedControl *segConSubHome;

-(id)initWithSegConSubHome: (UISegmentedControl *)paramSennder;

-(id)initWithSegConSubHome: (UISegmentedControl *)paramSennder containView: (UIView*)containView;

-(void)doSetSubLocation: (NSInteger)subLocation;

-(void)onSubHomeSegmentChanged: (NSInteger)selectedIndex;

@end
