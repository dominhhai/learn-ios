//
//  NetworkController.h
//  TaiLocPhat
//
//  Created by Maximus on 9/27/13.
//  Copyright (c) 2013 Hai Do Minh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import "NetworkResponsedProtocol.h"
#import "DataPackage.h"

@interface NetworkController : NSObject 
@property (nonatomic, retain) AppDelegate *app;
@property (strong, nonatomic)IBOutlet id<NetworkResponsedProtocol> caller;

+(NetworkController *)shared;

- (void) loadAllExternalData;
// init before tranfer to Home View (update location list depend on sellected area)
- (void)loadHasDataRegion:(NSString *)region;
- (void)loadHasDataWithEncodeRegion:(NSString *)region;

- (void)dataReceived:(DataPackage *)data;
- (void)updateAreaDict:(NSArray *)locations;
- (NSString*)getAreaNameById:(NSString*)id;
- (void)loadLocationsWithRegion:(NSString *)region;
- (void)loadLocationsWithEncodedRegion:(NSString *)region;
- (void)loadAllLocationsRegion;
- (void)tuongThuatXoSoWithArea:(NSString *)location;
- (void)tuongThuatXoSoWithEncodedArea:(NSString *)locationID;
- (void)traCuuXoSoWithArea:(NSString *)location andDate:(NSString *)date;
- (void)thongKeNhanh:(NSString *)location;
// only for Mienbac
- (void)thongKeDacBiet:(NSString *)type;
- (void)thongKeDacBietWithEncodedType:(NSString *)type;
-(void)getListTipWithLocation:(NSString *)location;
-(void)getListQuestionWithRegion:(NSString *)area;
-(void)addQuestionWithRegion:(NSString *)area clientID:(NSString *)clientID question:(NSString *)question;
-(void)updateQuestionWithRegion:(NSString *)area clientID:(NSString *)clientID question:(NSString *)question;
-(void)getAnswerWithQuestion:(NSString *)questionID lastAnswerID: (NSString *)lastanswerID;
-(void)addAnswerWithQuestion:(NSString *)questionID clientID:(NSString *)clientID answer:(NSString *)answer;
-(void)addAnswerVoteWithQuestion:(NSString *)questionID answerID:(NSString *)answerID;
-(void)getTipsContentWithID:(NSString *)tipsID;

// do so
- (void)doSo:(NSString *)number inLocation:(NSString *)location;

@end
