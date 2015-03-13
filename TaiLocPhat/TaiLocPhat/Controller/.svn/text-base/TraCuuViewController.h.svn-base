//
//  TraCuuViewController.h
//  TaiLocPhat
//
//  Created by Maximus on 8/4/13.
//  Copyright (c) 2013 Hai Do Minh. All rights reserved.
//
/*
 * Manges a segment control(Mode,date,location) and a table view (data)
 */

#import <UIKit/UIKit.h>
#import "SubHomeTabDelegate.h"
#import "SubHomeTableViewController.h"

@interface TraCuuViewController : UIViewController <SubHomeTabDelegate>

// Data for all date or only today
@property BOOL forAllDate;

// The menu [Chon lo] [Date] [Location]
@property (nonatomic, retain) UIView *containView;
@property (nonatomic, retain) NSArray *subHomeSegmentTitle;
@property (nonatomic, retain) UISegmentedControl *segConSubHome;
//@property (nonatomic, retain) SubHomeTableViewController *tableViewController;


// date picker
@property UIDatePicker *datePicker;
@property UIToolbar *toolbar ;
@property NSDateFormatter *dateFormatter;
@property NSString *pickedDate;

-(id)initWithSegConSubHome: (UISegmentedControl *)paramSennder;

-(id)initWithSegConSubHome: (UISegmentedControl *)paramSennder containView: (UIView*)containView;

-(id)initWithSegConSubHome: (UISegmentedControl *)paramSennder containView: (UIView*)pContainView forDate:(BOOL)forDate;

-(void)doSetSubLocation: (NSInteger)subLocation;

-(void)onSubHomeSegmentChanged: (NSInteger)selectedIndex;

@end