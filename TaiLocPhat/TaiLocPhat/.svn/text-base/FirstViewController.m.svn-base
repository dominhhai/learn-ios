//
//  MenuViewController.m
//  TaiLocPhat
//
//  Created by Hai Do Minh on 8/1/13.
//  Copyright (c) 2013 Hai Do Minh. All rights reserved.
//


#import "FirstViewController.h"
#import "HomeViewController.h"

#import "NetworkController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

@synthesize btnMienBac = btnMienBac;
@synthesize btnMienTrung = btnMienTrung;
@synthesize btnMienNam = btnMienNam;

NSInteger areaLoader = 0;
NSInteger curArea = 0;
NSMutableDictionary *areaData;
NSString* curLocation;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBar.hidden = YES;
    [[NetworkController shared] loadAllExternalData];
    //self.btnMienBac.backg = [UIColor clearColor];
}

- (IBAction)choseLocation:(id)sender{
    if (![[NetworkController shared].app checkActive]) {
        return;
    }
    
    NSString *location;
    if (sender == btnMienBac) {
        // NSLog(@"Click on Mien Bac");
        location = @"Miền Bắc";
        curArea = 1;
    } else if (sender == btnMienTrung) {
        // NSLog(@"Click on Mien Trung");
        location = @"Miền Trung";
        curArea = 2;
    } else {
        // NSLog(@"Click on Mien Nam");
        curArea = 3;
        location = @"Miền Nam";
    }
    
    // setup protocol before use network
    
    // transfer to HomeView
    areaLoader = 0;
    if (areaData != nil) {
        [areaData removeAllObjects];
        areaData = nil;
    }
    
    [NetworkController shared].app.curRegion = location;
    
    [NetworkController shared].app.wait_reponse_cont = YES;
    [NetworkController shared].caller = self;
    [[NetworkController shared] loadHasDataRegion:location];
}


// implement NetworkResponsedProtocol
- (void)loadNetworkData:(DataPackage *)response{
    if (response.serviceID == 2 && response.appID == 3) {
        areaLoader ++;
        [self decodeResponse:response.data];
        
        if (areaLoader == 3) {
            HomeViewController *homeViewController = [[HomeViewController alloc]initWithLocation:areaData curLocation:curLocation];
            [self.navigationController pushViewController:homeViewController animated:YES];
        } else if(areaLoader == 1) { // continue load data
            curLocation = [areaData allKeys][0];
            [NetworkController shared].caller = self;
            if (curArea == 1) {
                [[NetworkController shared] loadHasDataWithEncodeRegion:@"2"];
                [[NetworkController shared] loadHasDataWithEncodeRegion:@"3"];
            } else if (curArea == 2) {
                [[NetworkController shared] loadHasDataWithEncodeRegion:@"1"];
                [[NetworkController shared] loadHasDataWithEncodeRegion:@"3"];
            } else {
                [[NetworkController shared] loadHasDataWithEncodeRegion:@"1"];
                [[NetworkController shared] loadHasDataWithEncodeRegion:@"2"];
            }
        } else if (areaLoader == 2) {            
            [NetworkController shared].app.wait_reponse_cont = NO;
        }

    } else {
         NSLog(@"bad response here");
    }
}

// Response format: data = ID1/TEN1/gio_tuong_thuat  # ID2/TEN2/gio_tuong_thuat  #....
// gio_tuong_thuat = hh:mm:ss
// get 2 information: TEN and gio_tuong_thuat
- (void)decodeResponse:(NSString *)response{
    if (areaData == nil) {
        areaData = [[NSMutableDictionary alloc]init];
    }
    
    NSArray *areaArray = [response componentsSeparatedByString:@"#"];
    for (NSString *areaArrayEle in areaArray) {
        NSArray *data = [areaArrayEle componentsSeparatedByString:@"/"];
        [areaData setValue:data[2] forKey:data[1]];
    }
    if ([NetworkController shared].app.options_full == nil || [[NetworkController shared].app.options_full count] == 0) {
        [[NetworkController shared] updateAreaDict:areaArray];
    }
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
