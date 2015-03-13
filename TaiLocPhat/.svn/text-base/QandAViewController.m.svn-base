//
//  QandAViewController.m
//  TaiLocPhat
//
//  Created by Maximus on 10/3/13.
//  Copyright (c) 2013 Hai Do Minh. All rights reserved.
//

#import "QandAViewController.h"
#import "QandACell.h"
#import "MakeQuestionViewController.h"
#import "KGModal.h"
#import "AnswerQuestionViewController.h"

@interface QandAViewController ()
@property (unsafe_unretained,atomic) NSMutableArray *questionData;
@property (strong,nonatomic)MakeQuestionViewController *makeQuestionViewController;
@property (unsafe_unretained, nonatomic)NSString* clientID;
@property (unsafe_unretained, nonatomic)NSString* location;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) AnswerQuestionViewController *answerQuestionController;

// use for insert answer
@property (strong, nonatomic) NSMutableArray *curQuestionData;
@property (strong, nonatomic) NSMutableArray *insertAnswerData;
- (IBAction)makeQuestion:(id)sender;
@end

@implementation QandAViewController

InfoViewController* infoView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (id)initWithArea:(NSString*)area clientID:(NSString*)clientID andQuestionData:(NSMutableArray *)questionArray infoViewController:(InfoViewController*)pInfoView{
    
//    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
        self = [super initWithNibName:@"QandAViewController_ipad" bundle:nil];
    }else{
        self = [super initWithNibName:@"QandAViewController_iphone" bundle:nil];
        
    }
    if(self){
        _clientID = clientID;
        _location = area;
        _questionData = questionArray;
        infoView = pInfoView;
    }
    return self;
}




- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [self.questionData count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    QandACell *cell = (QandACell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        NSArray *nib;
          
//        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
            nib = [[NSBundle mainBundle] loadNibNamed:@"QandACell_ipad" owner:self options:nil];
        }else{
            nib = [[NSBundle mainBundle] loadNibNamed:@"QandACell_iphone" owner:self options:nil];
            
        }
            
        
        cell = [nib objectAtIndex:0];
        cell.showsReorderControl = YES;
    }
        cell.clientIDLabel.text = self.questionData[indexPath.row][2];
        cell.dateLabel.text = self.questionData[indexPath.row][4];
        cell.questionLabel.text = self.questionData[indexPath.row][1];
    
    return  cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.questionData count] > indexPath.row && [self.questionData[indexPath.row] count] == 5) {
         // NSLog(@"sellect cell %i",indexPath.row);
         self.curQuestionData = self.questionData[indexPath.row];
         [NetworkController shared].caller = self;
         [[NetworkController shared] getAnswerWithQuestion:self.curQuestionData[0] lastAnswerID:@"-1"];
    }
}


// heigh of custom cell get from lib file
- (CGFloat)tableView:(UITableView *)aTableView
heightForRowAtIndexPath:(NSIndexPath *)anIndexPath
{
//    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
        return 120;
    }else{

        return 64;
    }
    
}


// handle network reponse
- (void)loadNetworkData:(DataPackage *)response{
    NSLog(@"Received data %@",response.data);
    if (response.serviceID == 2 && response.appID == 26) {
        [self decodeQandAResponse:response.data];
        // refresh
        
        [self.tableView reloadData];//[self setSubViewRect:self.qAndAViewController.view];
    }
    else if(response.serviceID == 2 && response.appID == 27){
//        NSLog(@"Show Insert answer");
        if([response.data isEqualToString:@"null"]){
            [self.insertAnswerData removeAllObjects];
        }else{
            [self decodeInsertAnswerResponse:response.data];
        }
        self.answerQuestionController = [[AnswerQuestionViewController alloc]initWithQuestionData:self.curQuestionData andAnswerData:self.insertAnswerData infoViewController:infoView];
        
        [[KGModal sharedInstance]showWithContentView:self.answerQuestionController.view andAnimated:YES];
    } else {
        //handle global data here
        [infoView handleGlobalResponse:response];
    }
}

- (IBAction)makeQuestion:(id)sender {
    self.makeQuestionViewController = [[MakeQuestionViewController alloc]initWithParrent:self];
   // makeQuestionViewController.view.frasme = CGRectMake(0, 0, 280, 200);
    [[KGModal sharedInstance]showWithContentView:self.makeQuestionViewController.view andAnimated:YES];
}

// sendQuestiion button click handle
- (void)sendQuestion:(NSString*)question{
   // NSLog(@"sendQuestiion button click handle");
    [NetworkController shared].caller = self;
    [[NetworkController shared]addQuestionWithRegion:self.location clientID:self.clientID question:question];
}


//data = Question_id/data/client_id/privilege#
-(void)decodeQandAResponse:(NSString *)response{
    [self.questionData removeAllObjects];
    NSArray *dataArray = [response componentsSeparatedByString:@"#"];
    
    for(NSString *str in dataArray){
        NSArray *data = [str componentsSeparatedByString:@"/"];
        [self.questionData addObject:data];
    }
}

//data = answer_id/data/client_id/vote#
-(void)decodeInsertAnswerResponse:(NSString *)response{
    if (self.insertAnswerData == nil) {
        self.insertAnswerData = [[NSMutableArray alloc] init];
    }
    [self.insertAnswerData removeAllObjects];
    NSArray *dataArray = [response componentsSeparatedByString:@"#"];
    
    for(NSString *str in dataArray){
        NSArray *data = [str componentsSeparatedByString:@"/"];
        [self.insertAnswerData addObject:data];
    }
}

- (void)viewDidUnload {
    [self setTableView:nil];
    [super viewDidUnload];
}
@end
