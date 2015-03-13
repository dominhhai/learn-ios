//
//  NetworkController.m
//  TaiLocPhat
//
//  Created by Maximus on 9/27/13.
//  Copyright (c) 2013 Hai Do Minh. All rights reserved.
//

#import "NetworkController.h"

@interface NetworkController()

// load form 
@property (strong, nonatomic) NSDictionary *QRTypeDict;
@property (strong, nonatomic) NSDictionary *ServiceTypeDict;
@property (strong, nonatomic) NSDictionary *RegionDict;
// depend on region
@property (strong, nonatomic) NSDictionary *AreaDict;
// only available for MienBac
@property (strong, nonatomic) NSDictionary *StatisticKind;

@end

@implementation NetworkController
@synthesize app;

+(NetworkController *)shared {
    // structure used to test whether the block has completed or not
    static dispatch_once_t p = 0;
    
    // initialize sharedObject as nil (first call only)
    __strong static id _sharedObject = nil;
    
    // executes a block object once and only once for the lifetime of an application
    dispatch_once(&p, ^{
        _sharedObject = [[self alloc] init];
    });
    
    // returns the same object each time
    return _sharedObject;
    
}

- (void) loadAllExternalData {
    //load the Dict for endecode request, response
    
    
    // load Service dict
    self.ServiceTypeDict = [NSPropertyListSerialization  propertyListFromData:
                            [NSData dataWithContentsOfFile:[[NSBundle mainBundle]
                                                            pathForResource:@"Services"
                                                            ofType:@"plist"]]
                                                             mutabilityOption:NSPropertyListImmutable
                                                                       format:nil
                                                             errorDescription:nil];
    
    
    // load QR dict
    self.QRTypeDict = [NSPropertyListSerialization  propertyListFromData:
                       [NSData dataWithContentsOfFile:[[NSBundle mainBundle]
                                                       pathForResource:@"Requests"
                                                       ofType:@"plist"]]
                                                        mutabilityOption:NSPropertyListImmutable
                                                                  format:nil
                                                        errorDescription:nil];
    
    // load RegionDict
    self.RegionDict = [NSPropertyListSerialization  propertyListFromData:
                       [NSData dataWithContentsOfFile:[[NSBundle mainBundle]
                                                       pathForResource:@"Regions"
                                                       ofType:@"plist"]]
                                                        mutabilityOption:NSPropertyListImmutable
                                                                  format:nil
                                                        errorDescription:nil];
}

// only current viewcontroller calls network service know how to handdle received data
// the view controller will use the NetWorkControler to lookup ID (decode data)
// all view use network have to adapt to this protocol
// setup protocol before call networl [NetworkController shared].caller = self;
- (void)dataReceived:(DataPackage *)data{
    [self.caller loadNetworkData:data];
}




// init before tranfer to Home View (update location list depend on sellected area)
- (void)loadHasDataRegion:(NSString *)region{
    NSString *paramater = [self encodeRegion:region];
    [self loadHasDataWithEncodeRegion:paramater];
}

- (void)loadHasDataWithEncodeRegion:(NSString *)region{
    // send request to get area list cordinated with the sellected region
    NSString *cmd = [self constructCmdWitthService:@"SERVICE_LOTTERY" andRQ:@"RQ_REPORT_AREA"];
    [app sendRequest:[NSString stringWithFormat:@"%@%@", cmd, region]];
}



- (void)loadLocationsWithRegion:(NSString *)region {
    NSString *paramater = [self encodeRegion:region];
    [self loadLocationsWithEncodedRegion:paramater];
}

- (void)loadLocationsWithEncodedRegion:(NSString *)region {
    // NSLog(@"loadlocations: %@", region);
    NSString *cmd = [self constructCmdWitthService:@"SERVICE_LOTTERY" andRQ:@"RQ_LIST_AREA"];
    [app sendRequest:[NSString stringWithFormat:@"%@%@", cmd, region]];
}

- (void)loadAllLocationsRegion {
    [self loadLocationsWithEncodedRegion:@"1"];
    [self loadLocationsWithEncodedRegion:@"2"];
    [self loadLocationsWithEncodedRegion:@"3"];
}


// tuongThuatXoSo
- (void)tuongThuatXoSoWithArea:(NSString *)location{
    NSString *paramater = [self encodeArea:location];
    [self tuongThuatXoSoWithEncodedArea:paramater];
}

- (void)tuongThuatXoSoWithEncodedArea:(NSString *)locationID {
    NSString *cmd = [self constructCmdWitthService:@"SERVICE_LOTTERY" andRQ:@"RQ_RESULT_DAILY"];
    [app sendRequest:[NSString stringWithFormat:@"%@%@", cmd, locationID]];
}

// tracuuXoSo
- (void)traCuuXoSoWithArea:(NSString *)location andDate:(NSString *)date{

    NSString *cmd = [self constructCmdWitthService:@"SERVICE_LOTTERY" andRQ:@"RQ_RESULT"];
    NSString *paramater = [self encodeArea:location];
    
    [app sendRequest:[NSString stringWithFormat:@"%@%@##%@", cmd, paramater, [self convertDate:date]]];
    // NSLog(@"Send request: STuong thuat XoSo %@%@##%@",cmd, paramater, [self convertDate:date] );

}

- (void)thongKeNhanh:(NSString *)location{
    NSString *cmd = [self constructCmdWitthService:@"SERVICE_LOTTERY" andRQ:@"RQ_STATISTIC"];
    NSString *paramater = [self encodeArea:location];
    
    [app sendRequest:[NSString stringWithFormat:@"%@%@", cmd, paramater]];
    // NSLog(@"Send request: STuong thuat XoSo %@%@",cmd, paramater);
    
}

// only for Mienbac
- (void)thongKeDacBiet:(NSString *)type{
    NSString *paramater = [self encodeThongkeDacBietType:type];
    [self thongKeDacBietWithEncodedType:paramater];
//    NSString *cmd = [self constructCmdWitthService:@"SERVICE_LOTTERY" andRQ:@"RQ_SPECIAL_STATISTIC"];
//    NSString *paramater = [self encodeThongkeDacBietType:type];
//    
//    [app sendRequest:[NSString stringWithFormat:@"%@%@", cmd, paramater]];
//    // NSLog(@"Send request: STuong thuat XoSo %@%@",cmd, paramater);
}

- (void)thongKeDacBietWithEncodedType:(NSString *)type{
    NSString *cmd = [self constructCmdWitthService:@"SERVICE_LOTTERY" andRQ:@"RQ_SPECIAL_STATISTIC"];
    
    [app sendRequest:[NSString stringWithFormat:@"%@%@", cmd, type]];
    // NSLog(@"Send request: STuong thuat XoSo %@%@",cmd, type);
}


// do so
- (void)doSo:(NSString *)number inLocation:(NSString *)location{
    NSString *cmd = [self constructCmdWitthService:@"SERVICE_LOTTERY" andRQ:@"RQ_PICK_NUMBER"];
    NSString *paramater = [self encodeArea:location];
    
    [app sendRequest:[NSString stringWithFormat:@"%@%@##%@", cmd, paramater, number]];
    // NSLog(@"Send request: SDoSo %@%@##%@",cmd, paramater, number);
}

-(void)getListTipWithLocation:(NSString *)location {
    NSString *cmd = [self constructCmdWitthService:@"SERVICE_LOTTERY" andRQ:@"RQ_SERVICE_TIPS"];
    NSString *paramater = [self encodeArea:location];
    
    [app sendRequest:[NSString stringWithFormat:@"%@%@", cmd, paramater]];
    // NSLog(@"Send request: SList Tips %@%@",cmd, paramater);
}

// RQ_QUESTION+ GET_QUESTION + REGION_ID
-(void)getListQuestionWithRegion:(NSString *)area {
    NSString *cmd = [self constructCmdWitthService:@"SERVICE_LOTTERY" andRQ:@"RQ_QUESTION"];
    NSString *paramater = [self encodeRegion:area];

    [app sendRequest:[NSString stringWithFormat:@"%@0##%@", cmd, paramater]];
}

//RQ_QUESTION+ INSERT_QUESTION + DATA + CLIENT_ID + REGION_ID
-(void)addQuestionWithRegion:(NSString *)area clientID:(NSString *)clientID question:(NSString *)question {
    NSString *cmd = [self constructCmdWitthService:@"SERVICE_LOTTERY" andRQ:@"RQ_QUESTION"];
    NSString *paramater = [self encodeRegion:area];
    
    [app sendRequest:[NSString stringWithFormat:@"%@1##%@##%@##%@", cmd, question, clientID, paramater]];
}

//RQ_QUESTION+ UPDATE_QUESTION+ DATA + CLIENT_ID + REGION_ID
-(void)updateQuestionWithRegion:(NSString *)area clientID:(NSString *)clientID question:(NSString *)question {
    NSString *cmd = [self constructCmdWitthService:@"SERVICE_LOTTERY" andRQ:@"RQ_QUESTION"];
    NSString *paramater = [self encodeRegion:area];
    
    [app sendRequest:[NSString stringWithFormat:@"%@2##%@##%@##%@", cmd, question, clientID, paramater]];
}

//RQ_ANSWER+ GET_ANSWER + QUESTION_ID + LAST_ANSWER_ID
-(void)getAnswerWithQuestion:(NSString *)questionID lastAnswerID: (NSString *)lastanswerID {
    NSString *cmd = [self constructCmdWitthService:@"SERVICE_LOTTERY" andRQ:@"RQ_ANSWER"];
    
    [app sendRequest:[NSString stringWithFormat:@"%@0##%@##%@", cmd, questionID, lastanswerID]];
}

//RQ_ANSWER + INSERT_ANSWER + DATA + QUESTION_ID  + CLIENT_ID
-(void)addAnswerWithQuestion:(NSString *)questionID clientID:(NSString *)clientID answer:(NSString *)answer{
    NSString *cmd = [self constructCmdWitthService:@"SERVICE_LOTTERY" andRQ:@"RQ_ANSWER"];
    
    [app sendRequest:[NSString stringWithFormat:@"%@1##%@##%@##%@", cmd, answer, questionID, clientID]];
}

//RQ_ANSWER+ UPDATE_ANSWER_VOTE+ ANSWER_ID+QUESTION_ID
-(void)addAnswerVoteWithQuestion:(NSString *)questionID answerID:(NSString *)answerID {
    NSString *cmd = [self constructCmdWitthService:@"SERVICE_LOTTERY" andRQ:@"RQ_ANSWER"];
    
    [app sendRequest:[NSString stringWithFormat:@"%@2##%@##%@", cmd, answerID, questionID]];
}

-(void)getTipsContentWithID:(NSString *)tipsID {
    NSString *cmd = [self constructCmdWitthService:@"SERVICE_LOTTERY" andRQ:@"RQ_TIPS"];
    
    [app sendRequest:[NSString stringWithFormat:@"%@%@##%@##%@", cmd, tipsID, @"0", @"APPLOTTERY"]];
}


// get dacbiet type id
- (NSString*)encodeThongkeDacBietType:(NSString *)type{
    
    if([type isEqualToString:@"Đầu"]){
        return @"0";
    }
    if([type isEqualToString:@"Đuôi"]){
        return @"1";
    }
    if([type isEqualToString:@"Tổng"]){
        return @"2";
    }
    if([type isEqualToString:@"Bộ"]){
        return @"3";
    }
    return @"0";
}

// convert from dd/MM/yy to yyyy-MM-dd
-(NSString *)convertDate:(NSString *)date{
    NSDateFormatter *dateFormatterClient = [[NSDateFormatter alloc] init];
    [dateFormatterClient setDateFormat:@"dd/MM/yy"];
    
    NSDateFormatter *dateFormatterServer = [[NSDateFormatter alloc] init];
    [dateFormatterServer setDateFormat:@"yyyy-MM-dd"];
    
    return [dateFormatterServer stringFromDate:[dateFormatterClient dateFromString:date]];
}



// construct the request header
- (NSString *)constructCmdWitthService:(NSString *)service andRQ:(NSString *)request_type{
    
    NSMutableString *cmd = [[NSMutableString alloc] init];
    [cmd appendString:[self.ServiceTypeDict objectForKey:service]];
    [cmd appendString:@"##"];
    [cmd appendString:[self.QRTypeDict objectForKey:request_type]];
    [cmd appendString:@"##"];
    return cmd;
}




// getID of input paramater
// date
- (NSString *)encodeDate:(NSString *)date{
    return date;
}

// region
- (NSString *)encodeRegion:(NSString *)region{
    return [self.RegionDict objectForKey:region];
}

// area
- (NSString *)encodeArea:(NSString *)area{
    // NSLog(@"encodeArea %@ %@", area, [self.AreaDict allKeys][0]);
    return [self.AreaDict objectForKey:area];
}

// statistic kind
- (NSString *)encodeStatisticKind:(NSString *)kind{
    return [self.StatisticKind objectForKey:kind];
}


// Response format: data = ID1/TEN1/gio_tuong_thuat  # ID2/TEN2/gio_tuong_thuat  #....
// gio_tuong_thuat = hh:mm:ss
// get 2 information: TEN and ID
- (void)updateAreaDict:(NSArray *)locations {
    if (self.AreaDict == nil) {
        self.AreaDict = [[NSMutableDictionary alloc]init];;
    }
    
    for (NSString *areaEle in locations) {
        NSArray *data = [areaEle componentsSeparatedByString:@"/"];
        [self.AreaDict setValue:data[0] forKey:data[1]];
    }
}

- (NSString*)getAreaNameById:(NSString*)id {
    NSArray* listAreaNames = [self.AreaDict allKeysForObject:id];
    if ([listAreaNames count] > 0) {
        return listAreaNames[0];
    } else {
        return nil;
    }
}

@end
