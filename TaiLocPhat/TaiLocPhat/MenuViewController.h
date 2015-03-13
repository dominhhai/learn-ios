//
//  MainViewController.h
//  TaiLocPhat
//
//  Created by Maximus on 9/14/13.
//  Copyright (c) 2013 Hai Do Minh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuActionProtocol.h"
#import "MenuToHome.h"
#import "LeveyPopListView.h"
#import "CLTickerView.h"

@protocol ViewToMenu <NSObject>
- (void)swipeChangeSoKetQuaDate:(NSString*)date;
@end

@interface MenuViewController : UIViewController <ViewToMenu>


- (id)initWithLocation:(NSString *)firstChossenLocation areaData:(NSDictionary *)areaData;

@property (strong, atomic) NSString *date;
@property (strong, atomic) NSString *location;

@property (atomic) NSInteger curMainMenuItemIndex;

@property (strong, atomic) NSString *mainMenuItem;
@property (strong, atomic) NSString *subMenuItem;

@property (strong, retain) NSMutableArray *savedLocation;

@property (nonatomic, retain) IBOutlet UIButton *backButton;
@property (nonatomic, retain) IBOutlet UILabel *clientIDLabel;

@property (nonatomic, retain) NSDictionary *locationData;


@property (strong, nonatomic) IBOutlet UISegmentedControl *subSegmentedView;
// change style of view and the event handle
@property (unsafe_unretained, nonatomic)IBOutlet id<MenuActionProtocol> menuActionProtocol;
@property (strong, nonatomic)IBOutlet id<MenuToHome> menuToHomeProtocol;

- (IBAction)backEventHandler:(id)sender;
- (void) updateLocation:(NSString *)location;
- (void)changeSubMenuLabelWithKey: (NSString *)key atIndex: (NSInteger)mainIndex;
-(void) showTickerWithArea:(NSString*) area;

-(void) showTickerWithNewAdmod:(NSString*) admod;

@end
