//
//  AppDelegate.h
//  TaiLocPhat
//
//  Created by Hai Do Minh on 7/25/13.
//  Copyright (c) 2013 Hai Do Minh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@class AsyncSocket;

@interface AppDelegate : UIResponder <UIApplicationDelegate, UIAlertViewDelegate, MFMessageComposeViewControllerDelegate> {
    UINavigationController *navController;
    CFHostRef host;
	AsyncSocket *asyncSocket;
    NSMutableArray *queue_read;
    NSTimer *timer;
    UIView *view_wait_repondse;
    UIActivityIndicatorView *aActivityIndicator;
    UIAlertView *alert_app;
    int wait_connect_to_host;
    int wait_connect;
    BOOL wait_reponse;
    BOOL wait_reponse_cont;
    // account management
    NSString* version;
    NSString* clientID;
    NSArray* active_data;
}

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,retain) UINavigationController *navController;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (nonatomic,assign) UIActivityIndicatorView *aActivityIndicator;
@property (nonatomic,retain) NSMutableArray *queue_read;
@property (nonatomic,assign) NSTimer *timer;
@property (nonatomic,assign) UIView *view_wait_repondse;
@property (nonatomic,assign) UIAlertView *alert_app;
@property (nonatomic, retain) NSTimer *readtimer;
@property (nonatomic, assign) BOOL wait_reponse_cont;

@property (nonatomic, assign) NSString* curRegion;

@property (nonatomic, retain) NSString* version;
@property (nonatomic, retain) NSString* clientID;
@property (nonatomic, retain) NSArray* active_data;

-(BOOL)checkActive;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

-(void)reconnect_to_hosts;
-(void)connect_to_hosts;
-(void)disconnect;
-(void)sendRequest:(NSString*)request;
-(void)readData;
-(void)wait_reponse:(UIView*)add_sub_view;
-(void)stop_wait;

@property (nonatomic,retain) NSMutableArray *locationArray_full;
@property (nonatomic,retain) NSMutableArray *options_full;
-(void)updateFullLocations:(NSArray *)locations;

extern bool error_connect;

@end
