//
//  ThongKeDacBietViewController.m
//  TaiLocPhat
//
//  Created by Maximus on 9/30/13.
//  Copyright (c) 2013 Hai Do Minh. All rights reserved.
//

#import "ThongKeDacBietViewController.h"

@interface ThongKeDacBietViewController ()

@property (nonatomic, strong)NSArray *menu;
@end

@implementation ThongKeDacBietViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (id)init{
//    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
        self = [super initWithNibName:@"ThongKeDacBietViewController_ipad" bundle:nil];
    }else{
        self = [super initWithNibName:@"ThongKeDacBietViewController_iphone" bundle:nil];
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.menu = @[@"Đầu", @"Đít", @"Tổng", @"Bộ"];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.menu count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell Identifier";
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        // Fetch Fruit
//    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
        cell.textLabel.font = [UIFont boldSystemFontOfSize:22.0];
        [cell sizeToFit];
    }
    NSString *menuTitle = [self.menu objectAtIndex:[indexPath row]];
    cell.imageView.image = [UIImage imageNamed:@"star.png"];
    cell.textLabel.text = menuTitle;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Fetch Fruit
    //// NSLog(@"Fruit Selected > %@", self.menu[indexPath.row]);
    [self.delegate thongKeDacBietWithType:self.menu[indexPath.row]];
}


@end
