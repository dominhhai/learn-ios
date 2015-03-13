//
//  QandAViewController.h
//  TaiLocPhat
//
//  Created by Maximus on 10/3/13.
//  Copyright (c) 2013 Hai Do Minh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetworkController.h"
#import "InfoViewController.h"

@interface QandAViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, NetworkResponsedProtocol>
- (id)initWithArea:(NSString*)area clientID:(NSString*)clientID andQuestionData:(NSArray *)questionArray infoViewController:(InfoViewController*)pInfoView;
- (void)sendQuestion:(NSString*)question;
@end
