//
//  DoSoViewController.m
//  TaiLocPhat
//
//  Created by Maximus on 9/15/13.
//  Copyright (c) 2013 Hai Do Minh. All rights reserved.
//

#import "DoSoViewController.h"
#include "NetworkController.h"
#include "KGModal.h"
#include "PopupDoSoViewController.h"

@interface DoSoViewController ()
@property (unsafe_unretained, nonatomic) IBOutlet UITextField *inputNumber;
@property (strong, nonatomic) NSString* location;
@property (strong, atomic) NSArray *popupData;
@property (strong, atomic) PopupDoSoViewController*popupViewController;

-(IBAction)btnDoSoTouchDownEvent:(id)sender;


@end

@implementation DoSoViewController
@synthesize popupViewController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithLocation:(NSString *)location{
    
//    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
        self = [super initWithNibName:@"DoSoViewController_ipad" bundle:nil];
    }else{
        self = [super initWithNibName:@"DoSoViewController_iphone" bundle:nil];
    }
    if(self){
        self.view.backgroundColor = nil;
        _location = location;
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.inputNumber.keyboardType = UIKeyboardTypeNumberPad;
    self.inputNumber.returnKeyType = UIReturnKeyDone;

    // add observer for the respective notifications (depending on the os version)
	if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 3.2) {
		[[NSNotificationCenter defaultCenter] addObserver:self
												 selector:@selector(keyboardDidShow:)
													 name:UIKeyboardDidShowNotification
												   object:nil];
	} else {
		[[NSNotificationCenter defaultCenter] addObserver:self
												 selector:@selector(keyboardWillShow:)
													 name:UIKeyboardWillShowNotification
												   object:nil];
	}
}

-(void)updateLocation:(NSString *)location {
    self.location = location;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// custom keyboard
- (void)addButtonToKeyboard {
	// create custom button
	UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
	doneButton.frame = CGRectMake(0, 163, 106, 53);
	doneButton.adjustsImageWhenHighlighted = NO;
	if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 3.0) {
		[doneButton setImage:[UIImage imageNamed:@"DoneUp3.png"] forState:UIControlStateNormal];
		[doneButton setImage:[UIImage imageNamed:@"DoneDown3.png"] forState:UIControlStateHighlighted];
	} else {
		[doneButton setImage:[UIImage imageNamed:@"DoneUp.png"] forState:UIControlStateNormal];
		[doneButton setImage:[UIImage imageNamed:@"DoneDown.png"] forState:UIControlStateHighlighted];
	}
	[doneButton addTarget:self action:@selector(doneButton:) forControlEvents:UIControlEventTouchUpInside];
	// locate keyboard view
	UIWindow* tempWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:1];
	UIView* keyboard;
	for(int i=0; i<[tempWindow.subviews count]; i++) {
		keyboard = [tempWindow.subviews objectAtIndex:i];
		// keyboard found, add the button
		if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 3.2) {
			if([[keyboard description] hasPrefix:@"<UIPeripheralHost"] == YES)
				[keyboard addSubview:doneButton];
		} else {
			if([[keyboard description] hasPrefix:@"<UIKeyboard"] == YES)
				[keyboard addSubview:doneButton];
		}
	}
}

- (void)keyboardWillShow:(NSNotification *)note {
    // only for iphone
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone ){
	// if clause is just an additional precaution, you could also dismiss it
	if ([[[UIDevice currentDevice] systemVersion] floatValue] < 3.2) {
		[self addButtonToKeyboard];
    }
	}
}

- (void)keyboardDidShow:(NSNotification *)note {
    // only for iphone
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone ){
	// if clause is just an additional precaution, you could also dismiss it
	if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 3.2) {
		[self addButtonToKeyboard];
    }
    }
}


- (void)doneButton:(id)sender {
    [self.inputNumber resignFirstResponder];
}




-(IBAction)btnDoSoTouchDownEvent:(id)sender {
    NSString* inputted = self.inputNumber.text;
    if (inputted.length > 0 && inputted.length < 3 && [self isNumeric:inputted]) {
        [self.inputNumber resignFirstResponder];
        [NetworkController shared].caller = self;
        [[NetworkController shared]doSo:inputted inLocation:self.location];
    } else {
        UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:@"Số không hợp lệ!" message:@"Nhập vào một số hợp lệ để dò số (2 chữ số)!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [warningAlert show];
    }
    
}

-(BOOL)isNumeric:(NSString*)inputString {
    BOOL isValid = NO;
    NSCharacterSet *alphaNumberSet = [NSCharacterSet decimalDigitCharacterSet];
    NSCharacterSet *stringSet = [NSCharacterSet characterSetWithCharactersInString:inputString];
    isValid = [alphaNumberSet isSupersetOfSet:stringSet];
    return isValid;
}

//
//data  = ngay truy van #solanxuathien#ngayvegannhat# nhip#Tongso Dau/ngayhomqua/loto#TongsoDit/ngayhomqua/loto#TongsoTong/ngayhomqua/loto#solanve(trong30lanquay)#cac so hay ve (neu khong co thay =  x)
//
//Rieng MienBac: Them phan thong ke dac biet
//data =  noi dung  so da chon =  ngay truy van #solanxuathien#ngayvegannhat# nhip#Tongso Dau/ngayhomqua/loto#TongsoDit/ngayhomqua/loto#TongsoTong/ngayhomqua/loto#solanve(trong30lanquay)#cac so hay ve (neu khong co thay =  x)#ngayvegannhat cua dau/so ngay chua ra#ngayvegannhatdit/so ngay chua ra#ngayvegannhatcuatong/so ngay chua ra
//2013-09-30#5#13/11#1xxxxxx1xxxx1xxxxxxx1xxxxx1xxx#119/2013-09-29/02/02#66/2013-09-29/85/55/25/55/25#77/2013-09-29/69/78/23/50/69#0#0#2013-02-25/217#2012-11-08/326#2012-11-07/327
//2013-09-30#5#08/10#xxxx11xxxxxxxxxxx1xxxxxx1xxxxx#64/2013-09-29/13/11#60/2013-09-29/x#56/2013-09-29/82#5#76
- (void)loadNetworkData:(DataPackage *)response{

    
   if (response.serviceID == 2 && response.appID == 10) {
       
       // = [[PopupDoSoViewController alloc] initWithNibName:@"PopupDoSoViewController_iphone" bundle:nil];
       //popupViewController.view.frame = CGRectMake(0, 0, 280, 200);
       // show popup
       CGRect size;
       /*if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
           size = CGRectMake(0, 0, 600, 800);
           popupViewController = [[PopupDoSoViewController alloc] initWithNibName:@"PopupDoSoViewController_ipad" bundle:nil];
       } else {
           size = CGRectMake(0, 0, 294, 400);
           popupViewController = [[PopupDoSoViewController alloc] initWithNibName:@"PopupDoSoViewController_iphone" bundle:nil];
       }*/
       popupViewController = [[PopupDoSoViewController alloc]init];
       UIScrollView *sv = [[UIScrollView alloc] initWithFrame:size];
       
       [sv addSubview:popupViewController.view];
       
//        NSMutableString* result = [[NSMutableString alloc] initWithString:@"THỐNG KÊ LOTO - TRONG VÒNG 30 LẦN QUAY\n"];
       NSArray* dataArray = [response.data componentsSeparatedByString:@"#"];
       NSArray* subDataArray = nil;
       NSInteger index = 0;
       popupViewController.soLanXuatHien.text = dataArray[1];
       popupViewController.ngayVeGanNhat.text = dataArray[2];
       popupViewController.nhip.text = dataArray[3];

        
        for (index = 4; index < 7; index ++) {
            subDataArray = [dataArray[index] componentsSeparatedByString:@"/"];
            if (index == 4) {
                
                NSInteger subIndex = 2;
                NSMutableString *ngayHomQua = [[NSMutableString alloc]init];
                while (subIndex < [subDataArray count]) {
                    [ngayHomQua appendFormat:@"%@", subDataArray[subIndex]];
                    if (subIndex < [subDataArray count] - 1) {
                        [ngayHomQua appendString:@", "];
                    }
                    subIndex ++;
                }
                
                popupViewController.dauHaiTongLo.text = subDataArray[0];
                popupViewController.dauHaiNgayHomQua.text = ngayHomQua;
            } else if (index == 5) {
                
                NSInteger subIndex = 2;
                NSMutableString *ngayHomQua = [[NSMutableString alloc]init];
                while (subIndex < [subDataArray count]) {
                    [ngayHomQua appendFormat:@"%@", subDataArray[subIndex]];
                    if (subIndex < [subDataArray count] - 1) {
                        [ngayHomQua appendString:@", "];
                    }
                    subIndex ++;
                }
                
                popupViewController.ditHaiTongLo.text = subDataArray[0];
                popupViewController.ditHaiNgayHomQua.text = ngayHomQua;
                
            } else {
                NSInteger subIndex = 2;
                NSMutableString *ngayHomQua = [[NSMutableString alloc]init];
                while (subIndex < [subDataArray count]) {
                    [ngayHomQua appendFormat:@"%@", subDataArray[subIndex]];
                    if (subIndex < [subDataArray count] - 1) {
                        [ngayHomQua appendString:@", "];
                    }
                    subIndex ++;
                }
                NSLog(@"tong %@",ngayHomQua);
                popupViewController.tongBonTongLo.text = subDataArray[0];
                popupViewController.tongBonNgayHomQua.text = ngayHomQua;
            }
        }
       NSMutableString *soLanVe = [[NSMutableString alloc]init];
       subDataArray = [dataArray[8] componentsSeparatedByString:@"/"];
       index = 0;
       while (index < [subDataArray count]) {
           [soLanVe appendFormat:@"%@", subDataArray[index]];
           if (index < [subDataArray count] - 1) {
               [soLanVe appendString:@", "];
           }
           index ++;
       }
       
       popupViewController.tongBonCacSoHayVe.text = soLanVe;
       popupViewController.tongBonSoLanVe.text = dataArray[7];
        
        if ([dataArray count] > 9) {
            //[result appendString:@"\nTHỐNG KÊ ĐẶC BIỆT\n"];
            for (index = 9; index < [dataArray count]; index ++) {
                subDataArray = [dataArray[index] componentsSeparatedByString:@"/"];
                if (index == 9) {
                    popupViewController.dbDauNgayChuaRa.text = subDataArray[1];
                    popupViewController.dbDauNgayVeGanNhat.text = subDataArray[0];
                } else if (index == 10) {
                    popupViewController.dbDitNgayChuaRa.text = subDataArray[1];
                    popupViewController.dbDitNgayVeGanNhat.text = subDataArray[0];
                } else {
                    popupViewController.dbTongSoNgayChuaRa.text = subDataArray[1];
                    popupViewController.dbTongNgayVeGanNhat.text = subDataArray[0];
                }
                
                // set content scoll view
                if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
                    sv.contentSize= CGSizeMake(600, 1200);
                } else {
                    sv.contentSize= CGSizeMake(294, 992);
                }

                
            }
        }else{
//            NSLog(@"haha");
            [popupViewController.dacBietView removeFromSuperview];
            //[popupViewController.view r]
            // set content scoll view
            // set content scoll view
            if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
                sv.contentSize= CGSizeMake(600, 1200);
            } else {
                sv.contentSize= CGSizeMake(294, 628);
            }
        }
       
//       NSLog(@"PopupData %@",result);
       [[KGModal sharedInstance]showWithContentView:popupViewController.view andAnimated:YES];
    } else {
        // NSLog(@"bad response");
    }

}
@end
