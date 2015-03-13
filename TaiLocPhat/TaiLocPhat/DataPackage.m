//
//  DataPackage.m
//  TaiLocPhat
//
//  Created by Hai Do Minh on 9/26/13.
//  Copyright (c) 2013 Hai Do Minh. All rights reserved.
//

#import "DataPackage.h"

@implementation DataPackage

@synthesize type, appID, itemID, groupID, serviceID, segment;
@synthesize data = _data;

-(id)initWithType:(char)ptype appid:(short)pappid itemid:(char)pitemid groupid:(char)pgroupid serviceid:(char)pserviceid segment:(short)psegment data:(NSString*)pdata {
    self.type = ptype;
    self.appID = pappid;
    self.itemID = pitemid;
    self.groupID = pgroupid;
    self.serviceID = pserviceid;
    self.segment = psegment;
    self.data = [[NSMutableString alloc] initWithString:pdata];
    
    return self;
}

-(id)initWithDataPackage:(DataPackage*)dataPackage {
    self.type = dataPackage.type;
    self.appID = dataPackage.appID;
    self.itemID = dataPackage.itemID;
    self.groupID = dataPackage.groupID;
    self.serviceID = dataPackage.serviceID;
    self.segment = dataPackage.segment;
    self.data = [[NSMutableString alloc] initWithString:dataPackage.data];
    
    return self;
}

- (void)printAllResponse{
     NSLog(@"Response data: type: %hhd;\n appID: %hd;\n itemID: %hhd;\n groupID: %hhd;\n serviceID: %hhd;\n segment: %hd;\n data: %@;\n",self.type, self.appID, self.itemID, self.groupID, self.serviceID, self.segment, self.data);
}

-(BOOL)isSamePackageWithPackage:(DataPackage *)other {
    return (other.type == self.type && other.appID == self.appID && other.itemID == self.itemID && other.groupID == self.groupID && other.serviceID == self.serviceID);
}

+(NSString *) encodeRequest: (NSArray *) request {
    NSMutableString *buffer = [[NSMutableString alloc] init];
    NSInteger length = [request count];
    for (NSInteger index = 0; index < length; index ++) {
        [buffer appendString:[request objectAtIndex:index]];
        if (index < length - 1) {
            [buffer appendString:@"##"];
        }
    }
    return buffer;
}

+(NSArray *) decodeResponse: (NSString *) response {
    return [response componentsSeparatedByString:@"#"];
}

+(NSArray *) decodeDataLevel1: (NSString *) data {
    return [data componentsSeparatedByString:@"/"];
}

+(NSArray *) decodeDataLevel2: (NSString *) data {
    return [data componentsSeparatedByString:@"&"];
}

+(NSArray *) decodeDataLevel3: (NSString *) data {
    return [data componentsSeparatedByString:@";"];   
}

@end
