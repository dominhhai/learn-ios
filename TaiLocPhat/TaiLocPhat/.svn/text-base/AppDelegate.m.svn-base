//
//  AppDelegate.m
//  TaiLocPhat
//
//  Created by Hai Do Minh on 7/25/13.
//  Copyright (c) 2013 Hai Do Minh. All rights reserved.
//

#import "AppDelegate.h"

#import "FirstViewController.h"
#import "AsyncSocket.h"
#import <arpa/inet.h>
#import <net/if.h>
#import <ifaddrs.h>
#import "NetworkController.h"
#import "DataPackage.h"

@implementation AppDelegate
// Hai

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;
@synthesize navController, timer, queue_read, view_wait_repondse, aActivityIndicator, alert_app;
@synthesize wait_reponse_cont;
@synthesize locationArray_full, options_full;
@synthesize version, clientID, active_data;
@synthesize curRegion;

bool error_connect;
bool isPing = NO;
bool isExitApp;
DataPackage* savedDataPackage;

- (void)dealloc
{
    [asyncSocket release];
    [queue_read release];
    [_window release];
    [navController release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // init networkController singleton
    [NetworkController shared].app = self;
    
    // Override point for customization after application launch.
    FirstViewController *firstViewController;
//    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
        //// NSLog(@"Load Ipad app");
        firstViewController = [[FirstViewController alloc] initWithNibName:@"FirstViewController_ipad" bundle:nil];
    }else{
        firstViewController = [[FirstViewController alloc] initWithNibName:@"FirstViewController_iphone" bundle:nil];
    }
    navController = [[UINavigationController alloc] initWithRootViewController:firstViewController];
    navController.navigationItem.hidesBackButton = YES;
    navController.navigationBar.hidden = YES;
    [self.window setRootViewController:navController];
    self.window.backgroundColor = [UIColor whiteColor];
    
    version = @"1.0.7";
    NSUserDefaults *dbDefaults = [NSUserDefaults standardUserDefaults];
//    [dbDefaults removeObjectForKey:@"clientID"];
    NSString *myID = [dbDefaults stringForKey:@"clientID"];
    clientID = (myID != nil) ? myID : @"0";
    
    asyncSocket = [[AsyncSocket alloc] initWithDelegate:self];
    wait_connect_to_host=0;
    
    [self.window makeKeyAndVisible];
    
    // connect to host
    [self connect_to_hosts];
    
    return YES;
}

-(void)reconnect_to_hosts {
    asyncSocket = [[AsyncSocket alloc] initWithDelegate:self];
    wait_connect_to_host=0;
    
    [self connect_to_hosts];
}

-(void)connect_to_hosts {
    wait_connect=-1;
    if ([asyncSocket isConnected]) {
         NSLog(@"Warming: still connected!......");
    } else {
        [asyncSocket disconnect];
        NSError **err=nil;
        [asyncSocket connectToHost:@"118.69.205.226" onPort:6666 withTimeout:1000 error:err];
//        [asyncSocket connectToHost:@"118.69.205.227" onPort:8888 withTimeout:1000 error:err];
        if (err) {
            // NSLog(@"Error server connect!......");
            if (timer!=nil) {
                [timer invalidate];
                timer=nil;
            }
            error_connect=YES;
            [self stop_wait];
            isExitApp = true;
            UIAlertView *errorConnectAlert = [[UIAlertView alloc] initWithTitle:@"Kết nối thất bại" message:@"Kết nối lại bằng cách chọn OK. Kết nối lại?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
            [errorConnectAlert show];
            [errorConnectAlert release];
            
        } else {
            NSLog(@"connected");
            [self wait_reponse:[self.navController visibleViewController].view];
            
            self.queue_read = [[NSMutableArray alloc] init];
            timer=[NSTimer  scheduledTimerWithTimeInterval:0.25
                                                    target:self
                                                  selector:@selector(readData)
                                                  userInfo:nil repeats:YES];
            // keep socket connection
            // handle response at dataReader function
            self.readtimer=[NSTimer  scheduledTimerWithTimeInterval:0.25
                                                             target:self
                                                           selector:@selector(dataReader)
                                                           userInfo:nil
                                                            repeats:YES];
            [timer isValid];
            error_connect=NO;
        }
    }
}

-(void) disconnect {
    if ([asyncSocket isConnected]) {
        [asyncSocket disconnect];
    }
    [self.timer invalidate];
    self.timer=nil;
    // release queue
    [asyncSocket release];
    asyncSocket = nil;
}

-(void)wait_reponse:(UIView*)add_sub_view {
    if (wait_reponse) {
        return;
    }
    view_wait_repondse=[[UIView alloc]initWithFrame:CGRectMake(50, 0, 400, 240)];
    view_wait_repondse.alpha=0.1;
    [add_sub_view addSubview:view_wait_repondse];
    alert_app=[[UIAlertView alloc]initWithTitle:@"Đang kết nối,\n vui lòng đợi..." message:nil delegate:self cancelButtonTitle:nil otherButtonTitles: nil];
    [alert_app show];
    [alert_app release];
    aActivityIndicator =  [[[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(120.0f, 30.0f, 50.0f, 50.0f)]autorelease];
    [aActivityIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [alert_app addSubview:aActivityIndicator];
    [aActivityIndicator startAnimating];
     wait_reponse=YES;
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
//    if (wait_reponse) {
//        [aActivityIndicator stopAnimating];
//        [view_wait_repondse removeFromSuperview];
//        wait_reponse=NO;
//    } else
    if (isExitApp) {
        NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
        if ([title isEqualToString:@"OK"]) {
            [self wait_reponse:[self.navController visibleViewController].view];
            [self reconnect_to_hosts];
        }
    } else {
        if ([alertView.title isEqualToString:@"Kích hoạt ứng dụng"]) {
            if ([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:@"Kích hoạt"]) {
                // send sms
                [self sendSMS];
            }
        } else if([alertView.title isEqualToString:@"Cập nhập ứng dụng"]) {
            if ([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:@"Cập nhập"]) {
                NSString *link = [NSString stringWithFormat:@"http://%@", self.active_data[2]];
                NSURL *url = [NSURL URLWithString:link];
                [[UIApplication sharedApplication] openURL:url];
            }
        }
    }
}

-(void)stop_wait{
    if (wait_reponse) {
        wait_reponse=NO;
        [aActivityIndicator stopAnimating];
        [view_wait_repondse removeFromSuperview];
        [alert_app dismissWithClickedButtonIndex:-1 animated:YES];
    }
}

-(void)sendRequest:(NSString*)request {
    if (!isPing) {
        [self wait_reponse:self.navController.visibleViewController.view];
    }

    if([asyncSocket isConnected]) {
        isPing = NO;
        NSString *loginString=request;
        NSData *checkData = [loginString dataUsingEncoding:NSUTF8StringEncoding];
        
        NSMutableData *requestData = [[NSMutableData alloc] initWithLength:0];
        [requestData appendData:checkData];
        char bytesToAppend[1] = {3};
        [requestData appendBytes:bytesToAppend length:sizeof(bytesToAppend)];
        
		[asyncSocket writeData:requestData withTimeout:60 tag:0];

        [requestData release];
         NSLog(@"sent request: %@ ... OK",request);
    }
    else {
        NSLog(@"send request: %@ ...  FAILSE",request);
        wait_connect=0;
    }
}

-(void)readData {
    if (wait_connect_to_host >= 0) {
        wait_connect_to_host ++;
        if (wait_connect_to_host == 6) {
            wait_connect_to_host = -1;
            // start-up app
            [self sendRequest:[NSString stringWithFormat:@"1##0xff00000e##%@##%@", version, clientID]];
        }
        return;
    }
//    NSLog(@"data joint time: %d",joinTimeout);
    if([asyncSocket isConnected]) {
        [asyncSocket readDataWithTimeout:-1 tag:0];
//        if (joinTimeout > 0) {
//            joinTimeout ++;
//        }
    } else {
        if (wait_connect >= 0) {
            wait_connect++;
            if (wait_connect == 10) {
                wait_connect = -1;
                error_connect=YES;
                [self disconnect];
                // show alert pop-up
                // cancel: exit
                // ok: reconnect
                isExitApp = true;
                [self stop_wait];
                UIAlertView *errorConnectAlert = [[UIAlertView alloc] initWithTitle:@"Mất kết nối" message:@"Kết nối lại bằng cách chọn OK. Kết nối lại?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
                [errorConnectAlert show];
                [errorConnectAlert release];
                // NSLog(@"error connect to server!");
            }
        } else {
            wait_connect = 0;
        }
    }
}


-(void)updateFullLocations:(NSArray *)locations {
    if (self.locationArray_full == nil) {
        self.locationArray_full = [[NSMutableArray alloc] init];
    }
    if (self.options_full == nil) {
        self.options_full = [[NSMutableArray alloc] init];
    }
    for (NSString* location in locations) {
        NSArray *data = [location componentsSeparatedByString:@"/"];
        [self.options_full addObject:[NSDictionary dictionaryWithObjectsAndKeys:[UIImage imageNamed:@"star.png"], @"img", data[1], @"text", nil]];
        [self.locationArray_full addObject:data[1]];
    }
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
             // Replace this implementation with code to handle the error appropriately.
             // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
            // NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"TaiLocPhat" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"TaiLocPhat.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        // NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

-(void)dataReader {
    if (error_connect) {
        [self stop_wait];
        [self.navController popToRootViewControllerAnimated:YES];
        [self.readtimer invalidate];
        self.readtimer = nil;
        [queue_read removeAllObjects];
        [queue_read release];
        queue_read = nil;
    }
    else {
        if ([self.queue_read count] > 0) {
            // get data from queue_read
            DataPackage* dataPackage = [self.queue_read objectAtIndex:0];
            [self.queue_read removeObjectAtIndex:0];
            if (dataPackage.segment == -1) {          
                // join data
                if (savedDataPackage != nil && [dataPackage isSamePackageWithPackage:savedDataPackage]) {
                    [dataPackage.data insertString:savedDataPackage.data atIndex:0];
                    [savedDataPackage release];
                    savedDataPackage = nil;
                }
            } else {
                // save package
                if (savedDataPackage == nil) {
                    savedDataPackage = [[DataPackage alloc] initWithDataPackage:dataPackage];
                    [dataPackage release];
                    dataPackage = nil;
                } else if ([dataPackage isSamePackageWithPackage:savedDataPackage]) {
                    [savedDataPackage.data appendString:dataPackage.data];
                    [dataPackage release];
                    dataPackage = nil;
                } else {
                    // enqueue this package
                    [self.queue_read addObject:dataPackage];
                }
                return;
            }
            
            [dataPackage printAllResponse];
 
            switch (dataPackage.type) {
                case (char)0x02: // CONTENT_DATA
                case (char)0x04: // GROUP_DATA
                {
                    // if PING
                    // isPing = YES
                    if (dataPackage.serviceID == 4 && dataPackage.appID == 1) {
                        isPing = YES;
                        [self sendRequest:@"4##0xff000001"];
                    } else if(dataPackage.serviceID == 1 && dataPackage.appID == 14) {
                        // start-up app
                        [self  handleStartUpResponse:dataPackage.data];
                    } else if (dataPackage.serviceID == 1 && dataPackage.appID == 16) {
                        // active app
                        [self handleActiveResponse:dataPackage.data];
                    }
                    else {
                        [[NetworkController shared] dataReceived:dataPackage];
                    }
                    
                    break;
                }
                default:
                    break;
            }
            if (!isPing && !wait_reponse_cont) {
                [self stop_wait];
            }
        }
    }
}

/*
 appID  //service_version  //service_link  // maxTips//usedTips// active_code//active_cmd// sms_status
 sms_status = 0: tin nhan dang cho xu ly
 sms_status = 1: tin nhan da gui thanh cong
 sms_status = 2: tin nhan da gui that bai
 sms_status = 3: khong co tin nhan duoc  gui  len  tu client

 example: 721#1.0.1#tailocphat.net#20#2599979773#8052#APPLOTTERY#3
 */

-(void)handleStartUpResponse:(NSString*)response {
    NSArray* dataArray = [response componentsSeparatedByString:@"#"];
    NSString* curClientID = dataArray[0];
    NSString* curVersion = dataArray[1];
    self.active_data = dataArray;
    
    if (![self.clientID isEqualToString:curClientID]) {
        self.clientID = curClientID;
        
        NSUserDefaults *dbDefaults = [NSUserDefaults standardUserDefaults];
        [dbDefaults setObject:self.clientID forKey:@"clientID"];
        [dbDefaults synchronize];
    }
    
    // show update alert
    if ([self compareToVesrion:curVersion] < 0) {
        UIAlertView *updateAlert = [[UIAlertView alloc] initWithTitle:@"Cập nhập ứng dụng" message:[NSString stringWithFormat:@"Cập nhập ứng lên phiên bản mới nhất để có những trải nghiệm mới thú vị.\nTải phiên bản mới tại: %@", self.active_data[2]] delegate:self cancelButtonTitle:@"Thoát" otherButtonTitles:@"Cập nhập", nil];
        [updateAlert show];
        [updateAlert release];
    }
}

/*
 *  0: equal
 *  1: greater
 * -1: lower
 */
-(NSInteger)compareToVesrion:(NSString*)pVersion {
    NSInteger state = 0;
    NSInteger mVerLen = [self.version length];
    NSInteger pVerLen = [pVersion length];
    if (mVerLen > pVerLen) {
        state = 1;
    } else if(mVerLen < pVerLen) {
        state = -1;
    } if ([self.version isEqualToString:pVersion]) {
        state = 0;
    }
    else {
        NSArray* mVersionArray = [self.version componentsSeparatedByString:@"."];
        NSArray* pVersionArray = [pVersion componentsSeparatedByString:@"."];
        mVerLen = [mVersionArray count];
        for (pVerLen = 0; pVerLen < mVerLen; pVerLen ++) {
            NSInteger mNum = [mVersionArray[pVerLen] integerValue];
            NSInteger pNum = [pVersionArray[pVerLen] integerValue];
            if (mNum > pNum) {
                state = 1;
                break;
            } else if (mNum < pNum) {
                state = -1;
                break;
            } else {
                continue;
            }
        }
    }
    
    return state;
}


-(void)handleActiveResponse:(NSString*)response {
    [self handleStartUpResponse:response];
    NSString *message = nil;
    if ([self.active_data[7] isEqualToString:@"0"]) {
        message = @"Tin nhắn của bạn đang được hệ thống xử lý. Hãy tiếp tục sử dụng ứng dụng";
    } else if ([self.active_data[7] isEqualToString:@"1"]) {
        message = @"Gửi SMS thành công. Hãy tiếp tục sử dụng ứng dụng";
    } else if ([self.active_data[7] isEqualToString:@"2"]) {
        message = @"Gửi SMS lỗi!";
    } else if ([self.active_data[7] isEqualToString:@"3"]) {
        message = @"Hệ thống không tìm thấy tin nhắn của bạn!";
    }
    
    UIAlertView *smsAlert = [[UIAlertView alloc] initWithTitle:message message:nil delegate:nil cancelButtonTitle:@"Thoát"otherButtonTitles:nil, nil];
    [smsAlert show];
    [smsAlert release];
}

-(BOOL)checkActive {
    if ([self.active_data[7] isEqualToString:@"3"] && [self.active_data[4] isEqualToString:@"0"]) {
        UIAlertView *activeAlert = [[UIAlertView alloc] initWithTitle:@"Kích hoạt ứng dụng" message:@"Kích hoạt bằng cách gửi tin nhắn, mỗi tin 15K." delegate:self cancelButtonTitle:@"Thoát" otherButtonTitles:@"Kích hoạt", nil];
        [activeAlert show];
        [activeAlert release];
        return NO;
    } else {
        return YES;
    }
}

- (void)sendSMS {
    if(![MFMessageComposeViewController canSendText]) {
        UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Your device doesn't support SMS!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [warningAlert show];
        [warningAlert release];
        return;
    }
    
    NSArray *recipents = @[self.active_data[5]];
    NSString *message = self.active_data[6];
    
    MFMessageComposeViewController *messageController = [[MFMessageComposeViewController alloc] init];
    messageController.messageComposeDelegate = self;
    [messageController setRecipients:recipents];
    [messageController setBody:message];
    // Present message view controller on screen
    [self.navController.visibleViewController presentViewController:messageController animated:YES completion:nil];
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult) result
{
    switch (result) {
        case MessageComposeResultCancelled:
            break;
            
        case MessageComposeResultFailed:
        {
            UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Failed to send SMS!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [warningAlert show];
            [warningAlert release];
            break;
        }
            
        case MessageComposeResultSent:
            // send request
            [self sendRequest:[NSString stringWithFormat:@"1##0xff000010##%@", self.active_data[6]]];
            break;
            
        default:
            break;
    }
    
    [self.navController.visibleViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
