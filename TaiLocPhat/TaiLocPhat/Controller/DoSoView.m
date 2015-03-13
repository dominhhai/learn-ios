//
//  DoSoView.m
//  TaiLocPhat
//
//  Created by Maximus on 8/4/13.
//  Copyright (c) 2013 Hai Do Minh. All rights reserved.
//

#import "DoSoView.h"

@implementation DoSoView

- (id)init
{
    //self = [super initWithFrame:frame];
    if (self) {
        NSArray *nib = [[NSBundle mainBundle]
						loadNibNamed:@"DoSoViewController"
						owner:self
						options:nil];
        
		self = [nib objectAtIndex:0];
    }
    return self;
}

-(IBAction)textReturn:(id)sender{
    [sender resignFirstResponder];
}

-(IBAction)textFieldSetting:(id)sender{
    [sender setKeyboardType:UIKeyboardTypeNumbersAndPunctuation ];
}

-(IBAction)btnDoSoTouchDownEvent:(id)sender {
    [self showDoSoResult];
}

-(void)showDoSoResult {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Kết quả dò số"
                                                        message:@"Message From Server" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
    [alertView show];
}

-(id)initWithSegConSubHome: (UISegmentedControl *)paramSennder {
    self = [self init];
    self.backgroundColor = nil;
    if (self) {
        self.segConSubHome = paramSennder;
        [self.segConSubHome setTitle:@"" forSegmentAtIndex:0];
        [self.segConSubHome setTitle:@"" forSegmentAtIndex:1];
    }
    return self;
}

-(void)doSetSubLocation: (NSInteger)subLocation {
    NSLog(@"DoSoView: doSetSubLocation: %d", subLocation);
}

-(void)onSubHomeSegmentChanged: (NSInteger)selectedIndex {
    
}

@end
