//
//  SubHomeTableViewController.m
//  TaiLocPhat
//
//  Created by Hai Do Minh on 8/7/13.
//  Copyright (c) 2013 Hai Do Minh. All rights reserved.
//

#import "SubHomeTableViewController.h"
#import "TwoAttTableCell.h"

@interface SubHomeTableViewController ()

@end

@implementation SubHomeTableViewController

-(id)initWithCellType:(NSInteger)pCellType {
    self = [self init];
    if (self) {
        self.cellType = pCellType;
    }
    return  self;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableData = [NSArray arrayWithObjects:
                 [NSDictionary dictionaryWithObjectsAndKeys:@"t1",@"title",@"Facebook",@"detail", nil],
                 [NSDictionary dictionaryWithObjectsAndKeys:@"t18",@"title",@"Facebook1",@"detail", nil],
                 [NSDictionary dictionaryWithObjectsAndKeys:@"t17",@"title",@"Facebook2",@"detail", nil],
                 [NSDictionary dictionaryWithObjectsAndKeys:@"t16",@"title",@"Facebook3",@"detail", nil],
                 [NSDictionary dictionaryWithObjectsAndKeys:@"t15",@"title",@"Facebook4",@"detail", nil],
                 [NSDictionary dictionaryWithObjectsAndKeys:@"t14",@"title",@"Facebook5",@"detail", nil],
                 [NSDictionary dictionaryWithObjectsAndKeys:@"t13",@"title",@"Facebook6",@"detail", nil],
                 [NSDictionary dictionaryWithObjectsAndKeys:@"t12",@"title",@"Facebook7",@"detail", nil],
                 [NSDictionary dictionaryWithObjectsAndKeys:@"t11",@"title",@"Facebook8",@"detail", nil],
                 [NSDictionary dictionaryWithObjectsAndKeys:@"t10",@"title",@"Facebook9",@"detail", nil],
                 nil];
    self.titles = @[@"Giai nhat", @"Giai nhi", @"Giai ba"];
    self.data = @[@"234", @"G24324", @"3245435"];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
//    self.tableView.backgroundColor = nil;//[UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
////    self.tableView.delegate = self;
////    self.tableView.dataSource = self;
//    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//#warning Incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
   // NSLog(@"tableView count: %d", [self.tableData count]);
    return [self.titles count];
}

//
// 0: Tuong Thuat, So Ket Qua
// 1: Thong Ke (Dac Biet)
// 2: Tu Van (Tips)
// 3: Tu Van (Question)
//

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    // check cellType
    if (self.cellType == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {        // Create new cell
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
            cell.showsReorderControl = YES;
        }
        // Configure the cell...
        cell.textLabel.text = [self.titles objectAtIndex:[indexPath row]];
        cell.textLabel.backgroundColor = [UIColor clearColor];
        cell.detailTextLabel.text = [self.data objectAtIndex:[indexPath row]];
        cell.detailTextLabel.backgroundColor = [UIColor clearColor];
        return cell;
    } else if (self.cellType == 1) {
        TwoAttTableCell *cell = (TwoAttTableCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TwoAttTableCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
            cell.showsReorderControl = YES;
        }
        
        cell.lblTitle.text = [self.titles objectAtIndex:[indexPath row]];//self.tableData[indexPath.row][@"title"];
        cell.lblDetail.text = [self.data objectAtIndex:[indexPath row]];//self.tableData[indexPath.row][@"detail"];
        cell.lblTitle1.text = [self.titles objectAtIndex:[indexPath row]];//self.tableData[indexPath.row][@"title"];
        cell.lblDetail1.text = [self.data objectAtIndex:[indexPath row]];//self.tableData[indexPath.row][@"detail"];
        return  cell;
    } else if (self.cellType == 2) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {        // Create new cell
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
            cell.showsReorderControl = YES;
        }
        // Configure the cell...
        cell.imageView.image = [UIImage imageNamed:@"star.png"];
        cell.textLabel.text = [self.titles objectAtIndex:[indexPath row]];
//        cell.textLabel.backgroundColor = [UIColor clearColor];
        return cell;
    } else if (self.cellType == 3) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {        // Create new cell
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
            cell.showsReorderControl = YES;
        }
        // Configure the cell...
//        cell.imageView.image = [UIImage imageNamed:@"star.png"];
        cell.textLabel.text = [self.titles objectAtIndex:[indexPath row]];
        return cell;
    } else {
        return nil;
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"select row at: %d", indexPath.row);
    if (self.cellType == 2) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Tips" message:@"noi dung tip" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        alertView.alertViewStyle = UIAlertViewStyleDefault;
        [alertView show];
    } else if (self.cellType == 3) {
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Cau hoi" message:@"noi dung" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        [alertView show];
    }
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
