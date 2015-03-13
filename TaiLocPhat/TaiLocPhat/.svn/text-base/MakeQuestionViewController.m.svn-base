//
//  MakeQuestionViewController.m
//  TaiLocPhat
//
//  Created by Maximus on 10/5/13.
//  Copyright (c) 2013 Hai Do Minh. All rights reserved.
//

#import "MakeQuestionViewController.h"
#import "NetworkController.h"
#import "KGModal.h"

@interface MakeQuestionViewController ()

@property (strong, nonatomic) IBOutlet UITextField *questionTextField;
- (IBAction)sendQuestion:(id)sender;
- (IBAction)exitTextField:(id)sender;
@property(unsafe_unretained, nonatomic)QandAViewController *parrent;

@end

@implementation MakeQuestionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(id)initWithParrent:(QandAViewController*)parrent{
    
//    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
        self = [super initWithNibName:@"MakeQuestionViewController_ipad" bundle:nil];
    }else{
        self = [super initWithNibName:@"MakeQuestionViewController_iphone" bundle:nil];
        
    }
    
    if (self) {
        _parrent = parrent;
        // Custom initialization
    }
    return self;

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setQuestionTextField:nil];
    [super viewDidUnload];
}
- (IBAction)sendQuestion:(id)sender {
    NSString* question = self.questionTextField.text;
    question = [question stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (question == nil || question.length < 4) {
        UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:@"Câu hỏi của bạn quá ngắn!" message:@"Câu hỏi phải ít nhất có 4 chữ" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [warningAlert show];
    } else {
        [self.parrent sendQuestion:question];
        [[KGModal sharedInstance]hideAnimated:YES];
    }
}

- (IBAction)exitTextField:(id)sender {
    [sender resignFirstResponder];
}




@end
