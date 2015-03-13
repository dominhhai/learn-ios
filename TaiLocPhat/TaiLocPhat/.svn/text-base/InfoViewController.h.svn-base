//
//  InfoViewController.h
//  TaiLocPhat
//
//  Created by Maximus on 9/14/13.
//  Copyright (c) 2013 Hai Do Minh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuActionProtocol.h"
#import "NetworkResponsedProtocol.h"
#import "ThongKeDacBietViewController.h"
#import "HomeViewController.h"
#import "MenuViewController.h"

@interface InfoViewController : UIViewController <MenuActionProtocol, NetworkResponsedProtocol, TKeDacBietProtocol>

- (id)initWithLocation:(NSString *)firstChossenLocation homeViewController:(HomeViewController *)homeView;
-(void)changeInfoSubViewWithMainMenu:(NSString *)mainMenuItem andSubMenu:(NSString*)subMenuItem withDate:(NSString *)date withLocattion:(NSString *)location;
@property (strong, nonatomic)NSString *location;
@property (strong, nonatomic)HomeViewController *homeView;

-(BOOL)handleGlobalResponse:(DataPackage*)response;

@property (unsafe_unretained, nonatomic)IBOutlet id<ViewToMenu> viewToMenuProtocol;

@end
