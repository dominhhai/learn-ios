//
//  InfoViewController.m
//  TaiLocPhat
//
//  Created by Maximus on 9/14/13.
//  Copyright (c) 2013 Hai Do Minh. All rights reserved.
//

#import "InfoViewController.h"
#import "TableViewController.h"
#import "DoSoViewController.h"
#import "ThongKeViewController.h"
#import "NetworkController.h"
#import "ThongKeDacBietViewController.h"
#import "QandAViewController.h"
#include "KGModal.h"
#include "TipPopupViewController.h"
#import "TableHeader.h"


@interface InfoViewController ()
@property (strong, atomic) TableViewController *tableViewController;
@property (strong, atomic) DoSoViewController *doSoViewController;
@property (strong, atomic) ThongKeDacBietViewController *thongKeDacBietViewController;
@property (strong, atomic) QandAViewController *qAndAViewController;

@property (strong, atomic) NSDateFormatter *dateFormatter;

@property (retain, nonatomic) NSString *mainMenuItem;
@property (retain, nonatomic) NSString *subMenuItem;
@property (retain, nonatomic) NSString *date;

// paramater tranfer when initTable
// result view
@property (retain, nonatomic) NSMutableArray *tableTitlesArray;
@property (retain, nonatomic) NSMutableArray *tableItemsArray;

// paramater for Q&A  view
@property (strong, atomic)NSMutableArray *qAndAData;

// use for tipView
@property (strong, nonatomic) TipPopupViewController *tipView;

- (void)removeAllSubView;


@end

@implementation InfoViewController

//NSInteger encodedThongKeDB = 0;
NSString* NO_DATA = @" ";
TableHeader* tableHeaderViewController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithLocation:(NSString *)firstChossenLocation homeViewController:(HomeViewController *)homeView{
//    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
        self = [super initWithNibName:@"InfoViewController_ipad" bundle:nil];
    }else{
        self = [super initWithNibName:@"InfoViewController_iphone" bundle:nil];

    }
    if(self){
        _location = firstChossenLocation;
        _homeView = homeView;
    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = @"dd/MM/yy";
    
    self.tableItemsArray = [[NSMutableArray alloc]init];
    self.tableTitlesArray = [[NSMutableArray alloc]init];
    self.qAndAData = [[NSMutableArray alloc]init];
    
    
    
    [self changeInfoSubViewWithMainMenu:@"TuongThuat"
                             andSubMenu:@"Xổ số"
                               withDate:[dateFormatter stringFromDate:[NSDate date]]
                          withLocattion:self.location];
    
    // self.tableViewController = [[TableViewController alloc]initWithCellType:2];
    //[self.view addSubview:self.tableViewController.view];
    //// NSLog(@"LoadInforView");
    // load all location
    if ([NetworkController shared].app.options_full == nil || [[NetworkController shared].app.options_full count] == 0) {
        if ([NetworkController shared].app.locationArray_full != nil) {
            [[NetworkController shared].app.locationArray_full removeAllObjects];
        }
        [[NetworkController shared] loadAllLocationsRegion];
    }
    
    
UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipedRight:)];
[swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft ];
[self.view addGestureRecognizer:swipeLeft];

UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipedLeft:)];
[swipeRight setDirection:UISwipeGestureRecognizerDirectionRight ];
[self.view addGestureRecognizer:swipeRight];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)removeAllSubView{
    
    NSArray *viewsToRemove = [self.view subviews];
    
    for (UIView *v in viewsToRemove) {
        [v removeFromSuperview];
    }
}



// update data
-(void)changeInfoSubViewWithMainMenu:(NSString *)mainMenuItem
                          andSubMenu:(NSString*)subMenuItem
                            withDate:(NSString *)date
                       withLocattion:(NSString*)location{
    
    // NSLog(@"Change InfoView date main %@ sub %@ %@ location %@",mainMenuItem, subMenuItem, date, location);
    
    NSString* preMainMenuItem = self.mainMenuItem;
    NSString* preSubMenuItem = self.subMenuItem;
    NSString* preLocation = self.location;
    NSString* preDate = self.date;
    
    self.mainMenuItem = mainMenuItem;
    self.subMenuItem = subMenuItem;
    self.location = location;
    self.date = date;
    
    [self removeAllSubView];
    
    
    // TuongThuat Request
    if([mainMenuItem isEqualToString:@"TuongThuat"]){
        
        if([subMenuItem isEqualToString:@"Xổ số"]){
            if ([preMainMenuItem isEqualToString:self.mainMenuItem] && [preLocation isEqualToString:self.location]) {
                self.tableViewController = [[TableViewController alloc]initWithCellType:0 titleArray:self.tableTitlesArray priceArray:self.tableItemsArray];
                
                [self setSubViewRect:self.tableViewController.view];
                [self.view addSubview:self.tableViewController.view];
            } else {
                [NetworkController shared].caller = self;
                [[NetworkController shared] tuongThuatXoSoWithArea:location];
            }
            return;
        }else if([subMenuItem isEqualToString:@"Soi lô"]){
            if ([preLocation isEqualToString:self.location]) {
                [self decodeSoketQuaSoiLo];
            } else {
                [NetworkController shared].caller = self;
                [[NetworkController shared] tuongThuatXoSoWithArea:location];
            }
            return;
        }
        
    }
    
    else if([mainMenuItem isEqualToString:@"SoKetQua"]){
        if([subMenuItem isEqualToString:@"Xổ số"]){
            if ([preMainMenuItem isEqualToString:self.mainMenuItem] && ([preSubMenuItem isEqualToString:@"Soi lô"])) {
                self.tableViewController = [[TableViewController alloc]initWithCellType:0 titleArray:self.tableTitlesArray priceArray:self.tableItemsArray];
                
                [self setSubViewRect:self.tableViewController.view];
                [self.view addSubview:self.tableViewController.view];
            } else {
//            } else if ([preSubMenuItem isEqualToString:subMenuItem] && (![preLocation isEqualToString:self.location] || ![preDate isEqualToString:self.date])) {
                [NetworkController shared].caller = self;
                [[NetworkController shared] traCuuXoSoWithArea:location andDate:date];
            }
            return;
        }else if([subMenuItem isEqualToString:@"Soi lô"]){
            if ([preLocation isEqualToString:self.location] && [preDate isEqualToString:self.date]) {
                [self decodeSoketQuaSoiLo];
            } else {
                [NetworkController shared].caller = self;
                [[NetworkController shared] traCuuXoSoWithArea:location andDate:date];
            }
            
            return;
        }
    }
    
    else if([mainMenuItem isEqualToString:@"ThongKe"]){
        
        if([subMenuItem isEqualToString:@"T.K nhanh"]){
            [NetworkController shared].caller = self;
            [[NetworkController shared] thongKeNhanh:location];
            return;
        }else if([subMenuItem isEqualToString:@"T.K đặc biệt"]){
            [NetworkController shared].caller = self;
            self.thongKeDacBietViewController = [[ThongKeDacBietViewController alloc]init];
            self.thongKeDacBietViewController.delegate = self;
            [self setSubViewRect:self.thongKeDacBietViewController.view];
            [self.view addSubview:self.thongKeDacBietViewController.view];
            return;
        }
    }
    
    else if([mainMenuItem isEqualToString:@"DoSo"]){
        if (self.doSoViewController == nil) {
            self.doSoViewController = [[DoSoViewController alloc]initWithLocation:self.location];
        }
        [self.doSoViewController updateLocation:location];
        [self.view addSubview:self.doSoViewController.view];
        return;
    }
    
    else if([mainMenuItem isEqualToString:@"TuVan"]){
        // NSLog(@"tuvan: %@", subMenuItem);
        if([subMenuItem isEqualToString:@"Soi cầu"]){
            //self.tableViewController = [[TableViewController alloc]initWithCellType:2];
            //self.tableViewController.view.backgroundColor = [UIColor clearColor];
//            [self.view addSubview:self.tableViewController.view];
            [NetworkController shared].caller = self;
            [[NetworkController shared] getListTipWithLocation:location];
            return;
        }
        
        else if([subMenuItem isEqualToString:@"Hỏi Chuyên Gia"]){
            // NSLog(@"thao luan tab");
            /*UIButton *btnQuestion = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            btnQuestion.frame = CGRectMake(20, 0, 139, 27);
            UIImage *image = [UIImage imageNamed:@"button_cauhoi.png"];
            [btnQuestion setBackgroundImage:image forState:UIControlStateNormal];
            [btnQuestion setBackgroundImage:image forState:UIControlStateHighlighted];
            [btnQuestion addTarget:self action:@selector(btnQuestionEvent:) forControlEvents:UIControlEventTouchDown];
            
            [self.view addSubview:btnQuestion];
            */

//            self.tableViewController.view.frame = CGRectMake(20, 35, 280, 300);
//            [self.view addSubview:self.tableViewController.view];
            [NetworkController shared].caller = self;
            [[NetworkController shared] getListQuestionWithRegion:[NetworkController shared].app.curRegion];
            return;
        }
    }
    
}

-(IBAction)btnQuestionEvent:(id) sender {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Hoi dap" message:@"noi dung hoi" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alertView show];
}

- (void) showNoResultView{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Thông báo"
                                                        message:[[NSString alloc]initWithFormat:@"Chưa có kết quả cho ngày %@.",self.date] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertView show];
}

- (void)loadNetworkData:(DataPackage *)response{
    // GLOBAL data
    if ([self handleGlobalResponse:response]) {
        return;
    }
    // end GLOBAL data
    
    // use date and location data for update view (send request to the network)
    if([self.mainMenuItem isEqualToString:@"TuongThuat"]){
         if (response.serviceID == 2 && response.appID == 5) {
             if([self.subMenuItem isEqualToString:@"Xổ số"]){
                 [self removeAllSubView];
                 
                // handle the reponsed data from network
                [self decodeTuongThuatResponse:response.data];
                                 

                 if([response.data isEqualToString:@"null"]){
                    
                     
                     [self showNoResultView];
                 }else{
                     // // NSLog(@"Table Item %@", self.tableItemsArray[0]);
                     self.tableViewController = [[TableViewController alloc]initWithCellType:0 titleArray:self.tableTitlesArray priceArray:self.tableItemsArray];
                     [self setSubViewRect:self.tableViewController.view];
                     [self.view addSubview:self.tableViewController.view];
                 }
            } else if ([self.subMenuItem isEqualToString:@"Soi lô"]) {
                [self removeAllSubView];
                
                [self decodeTuongThuatResponse:response.data];
                [self decodeSoketQuaSoiLo];
            }
        }
        else {
             NSLog(@"bad response");
        }
        return;
        
    }
    
    // use date and location data for update view (send request to the network)
    else if([self.mainMenuItem isEqualToString:@"SoKetQua"]){
        if (response.serviceID == 2 && response.appID == 4) {
            if([self.subMenuItem isEqualToString:@"Xổ số"]){
                [self removeAllSubView];
                
                // handle the reponsed data from network
                [self decodeSoketQuaXoSoResponse:response.data];
                                

                if([response.data isEqualToString:@"null"]){
            
                    [self showNoResultView];
                }else{
                    //// NSLog(@"Table Item %@", self.tableItemsArray[0]);
                    self.tableViewController = [[TableViewController alloc]initWithCellType:0 titleArray:self.tableTitlesArray priceArray:self.tableItemsArray];
                    [self setSubViewRect:self.tableViewController.view];
                    [self.view addSubview:self.tableViewController.view];
                }
            } else if ([self.subMenuItem isEqualToString:@"Soi lô"]) {
                [self removeAllSubView];
                
                [self decodeSoketQuaXoSoResponse:response.data];
                [self decodeSoketQuaSoiLo];
            }
            else {
                  NSLog(@"bad response");
            }
        }
        return;      
    }
    
    
    
    else if([self.mainMenuItem isEqualToString:@"ThongKe"]){
        
        if([self.subMenuItem isEqualToString:@"T.K nhanh"]){
            if (response.serviceID == 2 && response.appID == 6) {
                [self removeAllSubView];
                
                // handle reponse
                [self decodeThongKeNhanhResponse:response.data];
                
                self.tableViewController = [[TableViewController alloc]initWithCellType:4 titleArray:self.tableTitlesArray priceArray:self.tableItemsArray];
                [self setSubViewRect:self.tableViewController.view];
                [self.view addSubview:self.tableViewController.view];
            } else {
                 NSLog(@"bad response");
            }
            return;
            
        }
        
        else if([self.subMenuItem isEqualToString:@"T.K đặc biệt"]){
            if (response.serviceID == 2 && response.appID == 7) {
                [self removeAllSubView];
                
                // handle reponse
                [self decodeThongKeDacBietResponse:response.data];
                
                self.tableViewController = [[TableViewController alloc]initWithCellType:1 titleArray:self.tableTitlesArray priceArray:self.tableItemsArray];
                [self.view addSubview:tableHeaderViewController.view];
                self.tableViewController.view.frame = CGRectMake(0, tableHeaderViewController.view.bounds.size.height, self.view.bounds.size.width,self.view.bounds.size.height - tableHeaderViewController.view.bounds.size.height);
                
               // [self setSubViewRect:self.tableViewController.view];
                [self.view addSubview:self.tableViewController.view];
            } else {
                NSLog(@"bad response");
            }

            return;
            
        }
        // NSLog(@"Choose thongke");
        
        
    }
    
    else if([self.mainMenuItem isEqualToString:@"TuVan"]){
        
        if([self.subMenuItem isEqualToString:@"Soi cầu"]){
            if (response.serviceID == 2) {
                if (response.appID == 8) {
                    [self removeAllSubView];
                    
                    [self decodeListTipsResponse:response.data];
                    
                    self.tableViewController = [[TableViewController alloc]initWithCellType:2 titleArray:self.tableTitlesArray priceArray:self.tableItemsArray];
                    [self setSubViewRect:self.tableViewController.view];
                    [self.view addSubview:self.tableViewController.view];
                } else if (response.appID == 9) {
                    if ([response.data isEqualToString:@"null"]) {
                        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Thông báo"
                                                                            message:@"Thông tin đang được cập nhập.\nVui lòng gọi 1900.561.219 để được hỗ trợ." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                        [alertView show];
                    } else {
                        self.tipView = [[TipPopupViewController alloc] initWithContent:response.data];
                        //NSLog(@"data %@ %@",self.tipView.textView.text);
//                        self.tipView.textView.text = [[NSString alloc]initWithString: response.data];
//                        NSLog(@"data %@ %@",self.tipView.textView.text, response.data);
                        [[KGModal sharedInstance]showWithContentView:self.tipView.view andAnimated:YES];
                    }
                } else {
                      NSLog(@"bad response");
                }
                
            } else {
                 NSLog(@"bad response");
            }
            
            return;
        }
        
        
        else if([self.subMenuItem isEqualToString:@"Hỏi Chuyên Gia"]){
            if (response.serviceID == 2 && response.appID == 26) {
                [self removeAllSubView];
                if([response.data isEqualToString:@"null"] ){
                    UIAlertView *errorConnectAlert = [[UIAlertView alloc] initWithTitle: @"Chưa có thảo luận nào!" message: [[NSString alloc]initWithFormat :@"Đăng thảo luận mới cho %@!", [NetworkController shared].app.curRegion] delegate: nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [errorConnectAlert show];
                    [self.qAndAData removeAllObjects];
                }else{
                    [self decodeQandAResponse:response.data];
                }
                self.qAndAViewController = [[QandAViewController alloc]initWithArea:[NetworkController shared].app.curRegion clientID:[NetworkController shared].app.clientID andQuestionData:self.qAndAData infoViewController:self];
                [self setSubViewRect:self.qAndAViewController.view];
                
                // be cause the QandA handle its subview event, it should handle network data
                [NetworkController shared].caller = self.qAndAViewController;
                
                [self.view addSubview:self.qAndAViewController.view];
                
            } else {
                NSLog(@"bad response");
            }
            return;
        }
    }
    
}

-(BOOL)handleGlobalResponse:(DataPackage*)response {
    BOOL isGlobalData = NO;
    NSString* admodMessage = nil;
    // data for all locations
    if (response.serviceID == 2 && response.appID == 11) {
        NSArray* areaArray = [response.data componentsSeparatedByString:@"#"];
        [[NetworkController shared].app updateFullLocations:areaArray];
        [[NetworkController shared] updateAreaDict:areaArray];
        isGlobalData = YES;
    }
    else if (response.serviceID == 2 && response.appID == 23) {
        // new result: id_new_result + data : data = idArea/nameArea
        NSArray* dataArray = [response.data componentsSeparatedByString:@"/"];
        admodMessage = [NSString stringWithFormat:@"HOT: tỉnh %@ đang quay", dataArray[2]];
        // handle real-time here
        // && [self.subMenuItem isEqualToString:@"Xổ số"]
        if([self.mainMenuItem isEqualToString:@"TuongThuat"] && [dataArray[2] isEqualToString:self.location]){
            [NetworkController shared].caller = self;
            [[NetworkController shared] tuongThuatXoSoWithArea:self.location];
        } else {
            [self.homeView updateHasDataLocationData:dataArray[2] value:@"00:00:00"];
        }
        
        // 
        isGlobalData = YES;
    }
    else if (response.serviceID == 2 && response.appID == 25) {
        // new service: id_new_service + data : data = region_id##area_code##service_id##service_name
        NSArray* dataArray = [response.data componentsSeparatedByString:@"##"];
        NSString* locationName = [[NetworkController shared] getAreaNameById:dataArray[1]];
        if (locationName != nil) {
            admodMessage = [NSString stringWithFormat:@"Tỉnh %@ vừa cập nhập dịch vụ %@, vào mục Soi cầu để xem chi tiết", locationName,dataArray[3]];
        }
        
        isGlobalData = YES;
    }
    else if (response.serviceID == 2 && response.appID == 30) {
        // admod: id_rq_web_notify + data : data = type#region_id#area_code#service_code#text#link(optional)
        NSArray* dataArray = [response.data componentsSeparatedByString:@"##"];
        NSString* locationName = [[NetworkController shared] getAreaNameById:dataArray[1]];
        if (locationName != nil) {
            if ([dataArray count] > 5) {
                admodMessage = [NSString stringWithFormat:@"Có dịch vụ %@ cho tỉnh %@, xem chi tiết tại http://%@", dataArray[4], locationName, dataArray[5]];
            } else {
                admodMessage = [NSString stringWithFormat:@"Có dịch vụ %@ cho tỉnh %@", dataArray[4], locationName];
            }
        }
        
        isGlobalData = YES;
    }
    
    if (isGlobalData && admodMessage != nil) {
        // show notify by append new admod
        [self.homeView showTickerWithNewAdmod:admodMessage];
    }
    
    return isGlobalData;
}


- (NSString*) numberToTextGiai:(NSInteger)number {
    switch (number) {
        case 0:
            return @"Đặc biệt";
        case 1:
            return @"Giải nhất";
        case 2:
            return @"Giải nhì";
        case 3:
            return @"Giải ba";
        case 4:
            return @"Giải tư";
        case 5:
            return @"Giải năm";
        case 6:
            return @"Giải sáu";
        case 7:
            return @"Giải bảy";
        case 8:
            return @"Giải tám";
        case 9:
            return @"Giải chín";
        case 10:
            return @"Giải mười";
        default:
            return @"No Exit!";
    }
}

/***************** Tuong thuat ***********************************************/

/* data =SUCCESS/yyyy-mm-dd#ID1  / GIAI 1/GIAI2/GIAI3... # ID2/GIAI2/GIAI3/.....
 * tu ID se suy ra ten giai tu client
 * data =FAIL/yyyy-mm-dd#ID1  / GIAI 1/GIAI2/GIAI3... # ID2/GIAI2/GIAI3/.....
 * tu ID se suy ra ten giai tu client
 * success : GIAI da ve trong ngay
 * fail : giai chua ve, lay ket qua cua lan quay gan nhat
 * output: date, ID and result array
 */
- (void)decodeTuongThuatResponse:(NSString *)response{
//    TEST data
//    response = @"2/2013-10-10#0/null#1/null#2/null#3/37647/59117#4/65821/26268/10223/63320/11259/10438/99626#5/1553#6/1875/7324/4135#7/003#8/28";
    NSInteger i1, i2;
    NSArray *priceArray;
    NSInteger priceArrayCount;
    NSMutableString *resultItem = [[NSMutableString alloc]init];
    BOOL haveData = false;
    
    [self.tableItemsArray removeAllObjects];
    [self.tableTitlesArray removeAllObjects];
    
    NSArray *dataArray = [response componentsSeparatedByString:@"#"];
    self.date = [dataArray[0] componentsSeparatedByString:@"/"][1];
    
    NSInteger dataArrayCount = [dataArray count];
    for(i1 = 1; i1 < dataArrayCount; i1++){
        priceArray = [dataArray[i1] componentsSeparatedByString:@"/"];
        priceArrayCount = [priceArray count];
        for(i2 = 1; i2 < priceArrayCount; i2++){
            if(![priceArray[i2] isEqualToString:@"null"]){
                haveData = true;
                [resultItem appendString:priceArray[i2]];
                if(i2 != priceArrayCount - 1)
                {
                    [resultItem appendString:@" - "];
                }
            }
            else {
                [resultItem appendString:NO_DATA];
            }
        }
        [self.tableItemsArray addObject:[NSString stringWithString:resultItem]];
        [resultItem setString:@""];
    }
    
    if (haveData) {
//        [self.tableTitlesArray addObject:@"Giải đặc biệt"];
        NSInteger numOfItems = [self.tableItemsArray count];
        for(i1 = 0; i1 < numOfItems; i1++){
            [self.tableTitlesArray addObject:[self numberToTextGiai:i1]];
        }
        haveData = false;
    } else {
        [self.tableTitlesArray addObject:@"Không có kết quả"];
    }
}


/* data = ID1  / GIAI 1/GIAI2/GIAI3... # ID2/GIAI2/GIAI3/.....
 tu ID se suy ra ten giai tu client
 * output: date, ID and result array
 */
- (void)decodeSoketQuaXoSoResponse:(NSString *)response{
    NSInteger i1, i2;
    NSArray *priceArray;
    NSInteger priceArrayCount;
    NSMutableString *resultItem = [[NSMutableString alloc]init];
    BOOL haveData = false;
    
    [self.tableItemsArray removeAllObjects];
    [self.tableTitlesArray removeAllObjects];
   
    if ([response isEqualToString:@"null"]) {
        // NSLog(@"resp is null");
    }
    
    NSArray *dataArray = [response componentsSeparatedByString:@"#"];
    
    NSInteger dataArrayCount = [dataArray count];
    for(i1 = 0; i1 < dataArrayCount; i1++){       
        priceArray = [dataArray[i1] componentsSeparatedByString:@"/"];
        priceArrayCount = [priceArray count];
        for(i2 = 1; i2 < priceArrayCount; i2++){
            if(![priceArray[i2] isEqualToString:@"null"] && [priceArray[i2] length] > 0){
                haveData = true;
                [resultItem appendString:priceArray[i2]];
                if(i2 != priceArrayCount - 1)
                {
                    [resultItem appendString:@" - "];
                }
            }
            else {
                [resultItem appendString:NO_DATA];
            }
        }
        // NSLog(@"SoKetQua %@",resultItem);
        [self.tableItemsArray addObject:[NSString stringWithString:resultItem]];
        [resultItem setString:@""];
    }
    
    if (haveData) {
        // NSLog(@"co data: %d", [self.tableItemsArray count]);
//        [self.tableTitlesArray addObject:@"Giải đặc biệt"];
        NSInteger numOfItems = [self.tableItemsArray count];
        for(i1 = 0; i1 < numOfItems; i1++){
            [self.tableTitlesArray addObject:[self numberToTextGiai:i1]];
        }
        haveData = false;
    } else {
        [self.tableTitlesArray addObject:@"Không có kết quả"];
    }
    
}

// tableTitleArray[0] = Dau 0
// tableItemArray[0] = 03, 05, 09
// tableItemArray[1] = 13, 25
- (void)decodeSoketQuaSoiLo{
    NSMutableArray* soiLoTitlesArray = [[NSMutableArray alloc] init];
    NSMutableArray* soiLoItemsArray = [[NSMutableArray alloc] init];
    BOOL haveData = false;

    if (self.tableItemsArray == nil || [self.tableItemsArray count] < 1) {
        haveData = false;
    } else {
         NSInteger index;
         for (index = 0; index < 10; index++) {
             [soiLoTitlesArray addObject:[[NSString alloc]initWithFormat:@"Đầu %i", index]];
             [soiLoItemsArray addObject:[[NSMutableString alloc] init]];
        }
        for (NSString* curItem in self.tableItemsArray) {
            if ([curItem isEqualToString:@""] || [curItem isEqualToString:NO_DATA]) {
                continue;
            }
            NSArray* curItems = [curItem componentsSeparatedByString:@" - "];
            for (NSString* item in curItems) {
                NSInteger itemLeng = [item length];
                if (itemLeng < 1) {
                    continue;
                }
                haveData = true;
                NSString* data = [item substringFromIndex:(itemLeng - 2)];
                index = [item characterAtIndex:(itemLeng - 2)] - '0';
                NSMutableString* indexStr = [soiLoItemsArray objectAtIndex:index];
                if ([indexStr length] < 1) {
                    [indexStr appendString:data];
                } else {
                    [indexStr appendFormat:@" - %@", data];
                }
                [soiLoItemsArray replaceObjectAtIndex:index withObject:indexStr];
            }
        }
    }
    
    if (!haveData) {
        [soiLoTitlesArray removeAllObjects];
        [soiLoItemsArray removeAllObjects];

        [self showNoResultView];
    }else{
    
    self.tableViewController = [[TableViewController alloc]initWithCellType:0 titleArray:soiLoTitlesArray priceArray:soiLoItemsArray];
    
    [self setSubViewRect:self.tableViewController.view];
    [self.view addSubview:self.tableViewController.view];
    }
}

/*
 * data =  data1 & data2 & data3
 * data1  =  con so ra nhieu trong 10 ngay gan day =
 * con so / so lan ve / do tang ( giam ) #  ...
 * data2 = con so ra lien tiep =
 * con so / so ngay lien tiep # ...
 * data3 = cac so chua ve tren 10 ngay va duoi 30 ngay =
 * con so / so ngay chua ve
 * save as array of self.tenDaysNumberArray, self.constiveNumberArray, self.promisedNumberArray
 */
- (void)decodeThongKeNhanhResponse:(NSString *)response{
    
    [self.tableTitlesArray removeAllObjects];
    [self.tableItemsArray removeAllObjects];
    
    [self.tableItemsArray addObject:[[NSMutableArray alloc]init]];
    [self.tableItemsArray addObject:[[NSMutableArray alloc]init]];
    [self.tableItemsArray addObject:[[NSMutableArray alloc]init]];
    
    [self.tableTitlesArray addObject:[[NSMutableArray alloc]init]];
    [self.tableTitlesArray addObject:[[NSMutableArray alloc]init]];
    [self.tableTitlesArray addObject:[[NSMutableArray alloc]init]];
    
    
    NSInteger i, length;
    NSArray *typeArray = [response componentsSeparatedByString:@"&"];
    NSArray *tenDaysNumberArray = [typeArray[0] componentsSeparatedByString:@"#"];
    NSArray *consitiveNumberArray = [typeArray[1] componentsSeparatedByString:@"#"];
    NSArray *promisedNumberArray = [typeArray[2] componentsSeparatedByString:@"#"];
    
    // NSLog(@"OK");
    length = [tenDaysNumberArray count];
    for(i = 0; i < length; i++){
        NSArray * detaiArray = [tenDaysNumberArray[i] componentsSeparatedByString:@"/"];
        [self.tableTitlesArray[0] addObject:detaiArray[0]];
        
        NSMutableString *des = [[NSMutableString alloc]init];
        [des appendFormat:@"(%@ lần) ",detaiArray[1]];
        if([detaiArray[2] isEqualToString:@"0"]){
           [des appendString:@" không tăng"];
        }else if([detaiArray[2] hasPrefix:@" - "]){
           [des appendFormat:@" giảm %@",detaiArray[2]];
        }else{
            [des appendFormat:@" tăng %@", detaiArray[2]];
        }
        
        [self.tableItemsArray[0] addObject:des];
        
    }
    
    
    length = [consitiveNumberArray count];
    for(i = 0; i < length; i++){
        NSArray * detaiArray = [consitiveNumberArray[i] componentsSeparatedByString:@"/"];
        [self.tableTitlesArray[1] addObject:detaiArray[0]];
        [self.tableItemsArray[1] addObject:[[NSString alloc]initWithFormat:@" %@ ngày", detaiArray[1]]];
    }
    
    length = [promisedNumberArray count];
    for(i = 0; i < length; i++){
        
        NSArray * detaiArray = [promisedNumberArray[i] componentsSeparatedByString:@"/"];
        [self.tableTitlesArray[2] addObject:detaiArray[0]];
        [self.tableItemsArray[2] addObject:[[NSString alloc]initWithFormat:@" %@ ngày", detaiArray[1]]];
        
    }    
}

/*
 * data = ngay ve / chua ra / cuc dai  # ....
 * Cac thong ke dac biet : dau, duoi, tong, bo duoc liet ke truoc o client
*/
- (void)decodeThongKeDacBietResponse:(NSString *)response{
    
    [self.tableTitlesArray removeAllObjects];
    [self.tableItemsArray removeAllObjects];
    
    NSArray *dayDataArray = [response componentsSeparatedByString:@"#"];
    NSArray *data;
    NSInteger length = [dayDataArray count];
    
    for( NSInteger i = 0 ; i < length; i++){
        data = [dayDataArray[i] componentsSeparatedByString:@"/"];
        // need update this line follow dau, duoi, tong, bo duoc liet ke truoc o client  
        [self.tableTitlesArray addObject:[[NSString alloc]initWithFormat:@"%i",i]];
        
        [self.tableItemsArray addObject:data];
    }
}

/*
* data = ID1  / TEN1  # ID2/TEN2 #...
*/
- (void)decodeListTipsResponse:(NSString *)response{
    [self.tableTitlesArray removeAllObjects];
    [self.tableItemsArray removeAllObjects];
    
    NSArray* dataArray = [response componentsSeparatedByString:@"#"];
    for (NSString* dataEle in dataArray) {
        NSArray* subDataArray = [dataEle componentsSeparatedByString:@"/"];
        [self.tableTitlesArray addObject:subDataArray[0]];
        [self.tableItemsArray addObject:subDataArray[1]];
    }
}

//data = Question_id/data/client_id/privilege#
-(void)decodeQandAResponse:(NSString *)response{
    [self.qAndAData removeAllObjects];
    NSArray *dataArray = [response componentsSeparatedByString:@"#"];
    
    for(NSString *str in dataArray){
        NSArray *data = [str componentsSeparatedByString:@"/"];
        [self.qAndAData addObject:data];
    }
}

// adap to multiple screen size
- (void)setSubViewRect:(UIView *)view{
    NSInteger padding;
//    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
        padding= 50;
    }else{
        padding = 0;
    }
    view.frame = CGRectMake(padding, 0, self.view.bounds.size.width - padding * 2, self.view.bounds.size.height);
}

// InforView handle view of thonke dacbiet
- (void)thongKeDacBietWithType:(NSString *)type{
    if (!tableHeaderViewController) {
        tableHeaderViewController = [[TableHeader alloc] initWithTitle:type];
    } else {
        tableHeaderViewController.lblTitle.text = type;
    }
    
    [NetworkController shared].caller = self;
    [[NetworkController shared] thongKeDacBiet:type];

}


- (IBAction)swipedRight:(UISwipeGestureRecognizer *)recognizer
{
    //NSLog(@"swiped right");
    [self.viewToMenuProtocol swipeChangeSoKetQuaDate:@"next"];
}

- (IBAction)swipedLeft:(UISwipeGestureRecognizer *)recognizer
{
   // NSLog(@"swiped left");
    [self.viewToMenuProtocol swipeChangeSoKetQuaDate:@"previous"];
}


- (void)viewDidUnload {
    [super viewDidUnload];
}
@end
