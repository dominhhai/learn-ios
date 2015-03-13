//
//  SubHomeTabDelegate.h
//  TaiLocPhat
//
//  Created by Hai Do Minh on 8/7/13.
//  Copyright (c) 2013 Hai Do Minh. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SubHomeTabDelegate <NSObject>

@required

@property (nonatomic, retain) UISegmentedControl *segConSubHome;

-(id)initWithSegConSubHome: (UISegmentedControl *)paramSennder;

-(void)doSetSubLocation: (NSInteger)subLocation;

-(void)onSubHomeSegmentChanged: (NSInteger)selectedIndex;

@optional

-(id)initWithSegConSubHome: (UISegmentedControl *)paramSennder containView: (UIView*)containView;

@end
