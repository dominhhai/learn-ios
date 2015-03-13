//
//  DataPackage.h
//  TaiLocPhat
//
//  Created by Hai Do Minh on 9/26/13.
//  Copyright (c) 2013 Hai Do Minh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataPackage : NSObject {
    char type;
    short appID;
    char itemID;
    char groupID;
    char serviceID;
    short segment;
    NSString *data;
}

@property(nonatomic, assign) char type;
@property(nonatomic, assign) short appID;
@property(nonatomic, assign) char itemID;
@property(nonatomic, assign) char groupID;
@property(nonatomic, assign) char serviceID;
@property(nonatomic, assign) short segment;
@property(nonatomic, retain) NSMutableString *data;

-(id)initWithType:(char)ptype appid:(short)pappid itemid:(char)pitemid groupid:(char)pgroupid serviceid:(char)pserviceid segment:(short)psegment data:(NSString*)pdata;

-(id)initWithDataPackage:(DataPackage*)dataPackage;

- (void)printAllResponse;

-(BOOL)isSamePackageWithPackage:(DataPackage *)other;

+(NSString *) encodeRequest: (NSArray *) request;

+(NSArray *) decodeResponse: (NSString *) response;

+(NSArray *) decodeDataLevel1: (NSString *) data;

+(NSArray *) decodeDataLevel2: (NSString *) data;

+(NSArray *) decodeDataLevel3: (NSString *) data;

@end
