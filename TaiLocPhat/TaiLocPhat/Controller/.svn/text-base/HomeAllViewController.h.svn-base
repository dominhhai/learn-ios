//
//  HomeAllViewController.h
//  TaiLocPhat
//
//  Created by Hai Do Minh on 8/6/13.
//  Copyright (c) 2013 Hai Do Minh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TraCuuViewController.h"
#import "ThongKeViewController.h"
#import "DoSoView.h"
#import "TuVanViewController.h"

#import "LeveyPopListView.h"

@interface HomeAllViewController : UIViewController <LeveyPopListViewDelegate>

//
// UI properties
//
@property (nonatomic, retain) IBOutlet UILabel *lblThanhVien;
@property (nonatomic, retain) IBOutlet UISegmentedControl *segConHome;
@property (nonatomic, retain) IBOutlet UISegmentedControl *segConSubHome;
@property (nonatomic, retain) IBOutlet UIView *containUIView;
// list subview
@property (nonatomic, retain) TraCuuViewController *traCuuViewController;
@property (nonatomic, retain) ThongKeViewController *thongKeViewController;
@property (nonatomic, retain) DoSoView *doSoView;
@property (nonatomic, retain) TuVanViewController *tuVanViewController;

//
// Other properties
//
@property NSInteger preSegConHomeIndex;
@property NSInteger curSegConHomeIndex;

// Location which is selected from menu view
@property (nonatomic) NSInteger curLocation;
@property (nonatomic) NSInteger curSubLocation;

//
// Messages
//
- (id)initWithLocation: (NSInteger) location;

@end
