//
//  MenuToHome.h
//  TaiLocPhat
//
//  Created by Maximus on 9/17/13.
//  Copyright (c) 2013 Hai Do Minh. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MenuToHome <NSObject>
- (void)showDatePicker;
- (void)showIpadDatePicker;
- (void)showIpadLocationPicker;
- (void)clearPicker;
- (void)showListView;
@end
