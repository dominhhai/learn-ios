//
//  QandACell.m
//  TaiLocPhat
//
//  Created by Maximus on 10/3/13.
//  Copyright (c) 2013 Hai Do Minh. All rights reserved.
//

#import "QandACell.h"

@implementation QandACell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}
-(id)init{
//    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
        self = [super initWithStyle:nil reuseIdentifier:@"ipad_cell"];
    }else{
        self = [super initWithStyle:nil reuseIdentifier:@"iphone_cell"];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
