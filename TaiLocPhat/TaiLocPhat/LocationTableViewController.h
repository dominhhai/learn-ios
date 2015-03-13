//
//  LocationTableViewController.h
//  TaiLocPhat
//
//  Created by Maximus on 9/20/13.
//  Copyright (c) 2013 Hai Do Minh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LocationTableViewController : UITableViewController

@property (strong, nonatomic)NSString *chossenLocation;
@property NSArray *locationArray;


- (id)initLocationArray: (NSArray *)locArray;

@end
