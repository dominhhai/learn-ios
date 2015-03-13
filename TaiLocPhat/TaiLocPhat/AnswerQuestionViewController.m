//
//  AnswerQuestionViewController.m
//  TaiLocPhat
//
//  Created by Maximus on 10/5/13.
//  Copyright (c) 2013 Hai Do Minh. All rights reserved.
//

#import "AnswerQuestionViewController.h"
#import "UIBubbleTableView.h"
#import "UIBubbleTableViewDataSource.h"
#import "NSBubbleData.h"
#import "KGModal.h"

@interface AnswerQuestionViewController (){
IBOutlet UIBubbleTableView *bubbleTable;
IBOutlet UIView *textInputView;
IBOutlet UITextField *textField;
//NSMutableArray *bubbleData;
}
- (IBAction)exitTextField:(id)sender;
@property (strong, nonatomic) NSArray *questionData;
@property (unsafe_unretained, nonatomic)NSArray *answerData;
@property(strong, nonatomic ) NSMutableArray *bubbleData;
@end

@implementation AnswerQuestionViewController
UIImage* avatarImg;
NSDateFormatter* dateFormater;
InfoViewController* infoView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}



- (id)initWithQuestionData:(NSArray *)pquestionData andAnswerData:(NSArray *) panswerData infoViewController:(InfoViewController*)pInfoView {
    
//    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
        self = [super initWithNibName:@"AnswerQuestionViewController_ipad" bundle:nil];
    }else{
        self = [super initWithNibName:@"AnswerQuestionViewController_iphone" bundle:nil];
    }
    
    if(self){
        _questionData = pquestionData;
        _answerData = panswerData;
        infoView = pInfoView;
    }
    return self;
}

-(BOOL) isMyMessage:(NSString*)id {
   // NSLog(@"Compare id %@ %@", id, [NetworkController shared].app.clientID);
    return [id isEqualToString:[NetworkController shared].app.clientID];
}

-(NSDate*) stringToNSDate:(NSString*)datestr {
    if (dateFormater == nil) {
        dateFormater = [[NSDateFormatter alloc] init];
        [dateFormater setDateFormat:@"HH:mm  dd-MM-yyyy"];
    }
    return [dateFormater dateFromString:datestr];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    avatarImg = [UIImage imageNamed:@"avatar.png"];
    // Do any additional setup after loading the view from its nib.
    self.bubbleData= [[NSMutableArray alloc]init];
    
    NSBubbleData *questionBubble = [NSBubbleData dataWithText:self.questionData[1] date:[self stringToNSDate:self.questionData[4]] type:([self isMyMessage:self.questionData[2]] ? BubbleTypeMine : BubbleTypeSomeoneElse) username:[NSString stringWithFormat:@"ID:%@",self.questionData[2]]];
    questionBubble.avatar = avatarImg;
    
    [self.bubbleData addObject:questionBubble];
    
    if(self.answerData != nil){
        for(NSArray *data in self.answerData){
            NSBubbleData *answerBubble = [NSBubbleData dataWithText:data[1] date:[self stringToNSDate:data[4]] type:([self isMyMessage:data[2]] ? BubbleTypeMine : BubbleTypeSomeoneElse) username:[NSString stringWithFormat:@"ID:%@",data[2]]];
            answerBubble.avatar = avatarImg;
            [self.bubbleData addObject:answerBubble];
        }
    }
   // bubbleData = [[NSMutableArray alloc] initWithObjects:heyBubble, replyBubble, nil];
    bubbleTable.bubbleDataSource = self;
    
    // The line below sets the snap interval in seconds. This defines how the bubbles will be grouped in time.
    // Interval of 120 means that if the next messages comes in 2 minutes since the last message, it will be added into the same group.
    // Groups are delimited with header which contains date and time for the first message in the group.
    
    bubbleTable.snapInterval = 120;
    
    // The line below enables avatar support. Avatar can be specified for each bubble with .avatar property of NSBubbleData.
    // Avatars are enabled for the whole table at once. If particular NSBubbleData misses the avatar, a default placeholder will be set (missingAvatar.png)
    
    bubbleTable.showAvatars = YES;
    
    // Uncomment the line below to add "Now typing" bubble
    // Possible values are
    //    - NSBubbleTypingTypeSomebody - shows "now typing" bubble on the left
    //    - NSBubbleTypingTypeMe - shows "now typing" bubble on the right
    //    - NSBubbleTypingTypeNone - no "now typing" bubble
    
    bubbleTable.typingBubble = NSBubbleTypingTypeSomebody;
    
    [bubbleTable reloadData];
    
    // Keyboard events
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - UIBubbleTableViewDataSource implementation

- (NSInteger)rowsForBubbleTable:(UIBubbleTableView *)tableView
{
    return [self.bubbleData count];
}

- (NSBubbleData *)bubbleTableView:(UIBubbleTableView *)tableView dataForRow:(NSInteger)row
{
    return [self.bubbleData objectAtIndex:row];
}

#pragma mark - Keyboard events

- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    [[KGModal sharedInstance] changePositionWithKeyboardSize:kbSize];
    [UIView animateWithDuration:0.2f animations:^{
       CGRect frame = textInputView.frame;
        // pading is 18px
        // change textfield origin.y
        frame.origin.y -= ([KGModal sharedInstance].containerView.frame.origin.y +[KGModal sharedInstance].containerView.frame.size.height - ([[UIScreen mainScreen] bounds].size.height - kbSize.height)) - 18;
        
        // table focus point
        CGPoint offset = CGPointMake(0, bubbleTable.contentSize.height -     bubbleTable.frame.size.height  + (textInputView.frame.origin.y -frame.origin.y));
        
        textInputView.frame = frame;
        [bubbleTable setContentOffset:offset animated:YES];
    }];

}

// change positon of
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    // change origin.y = 0
    [[KGModal sharedInstance] changePositionWithKeyboardSize:kbSize];
    
    [UIView animateWithDuration:0.2f animations:^{
        CGRect frame = textInputView.frame;
        // pading is 18px
        frame.origin.y += ([KGModal sharedInstance].containerView.frame.origin.y +[KGModal sharedInstance].containerView.frame.size.height - ([[UIScreen mainScreen] bounds].size.height - kbSize.height)) - 18;
        textInputView.frame = frame;
    }];
    // table focus point
    CGPoint offset = CGPointMake(0, bubbleTable.contentSize.height -     bubbleTable.frame.size.height);
    [bubbleTable setContentOffset:offset animated:YES];
    
}

#pragma mark - Actions

- (IBAction)sayPressed:(id)sender
{
    NSString* answer = textField.text;
    NSLog(@" answer %@",answer);
    answer = [answer stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (answer == nil || answer.length < 4) {
        UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:@"Câu trả lời của bạn quá ngắn!" message:@"Câu trả lời phải ít nhất có 4 chữ" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [warningAlert show];
    } else {
        // send insert answer to server
        [NetworkController shared].caller = self;
        [[NetworkController shared] addAnswerWithQuestion:self.questionData[0] clientID: [NetworkController shared].app.clientID answer:answer];
        
        // update view
        bubbleTable.typingBubble = NSBubbleTypingTypeNobody;
        NSLog(@"Text = %@", textField.text);
        NSBubbleData *sayBubble = [NSBubbleData dataWithText:textField.text date:[NSDate dateWithTimeIntervalSinceNow:+bubbleTable.snapInterval] type:BubbleTypeMine username:[NSString stringWithFormat:@"ID:%@",[NetworkController shared].app.clientID]];
        sayBubble.avatar = avatarImg;
        
        [self.bubbleData addObject:sayBubble];
        [bubbleTable reloadData];
        textField.text = @"";
        [textField resignFirstResponder];

    }
    
}


- (IBAction)exitTextField:(id)sender {
    [textField resignFirstResponder];
    
}

- (void)loadNetworkData:(DataPackage *)response{
    // donnot need to handle this respone
   // NSLog(@" response %@", response.data);
    
    if(!(response.serviceID == 2 && response.appID == 27)){
        //handle global data here
        [infoView handleGlobalResponse:response];
    }
}
@end
