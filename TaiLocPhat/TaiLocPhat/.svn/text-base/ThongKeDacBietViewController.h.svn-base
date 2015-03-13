//
//  ThongKeDacBietViewController.h
//  TaiLocPhat
//
//  Created by Maximus on 9/30/13.
//  Copyright (c) 2013 Hai Do Minh. All rights reserved.
//

#import "TableViewController.h"


@protocol TKeDacBietProtocol <NSObject>

- (void)thongKeDacBietWithType:(NSString *) type;

@end


@interface ThongKeDacBietViewController : TableViewController<UITableViewDataSource, UITableViewDelegate>

@property (unsafe_unretained, nonatomic)IBOutlet id<TKeDacBietProtocol> delegate;
- (id)init;

@end

