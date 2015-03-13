//
//  TableViewController.m
//  TaiLocPhat
//
//  Created by Maximus on 9/14/13.
//  Copyright (c) 2013 Hai Do Minh. All rights reserved.
//

#import "TableViewController.h"
#import "TwoAttTableCell.h"
#import "NetworkController.h"
#import "SoKetQuaCell.h"

@interface TableViewController ()

@property (nonatomic, retain)NSArray *titles;
@property (nonatomic, retain)NSArray *data;
@property NSInteger section1RowsNumb;
@property NSInteger section2RowsNumb;
@property NSInteger section3RowsNumb;

@end

@implementation TableViewController

-(id)initWithCellType:(NSInteger)pCellType titleArray:(NSArray *)itemArray priceArray:(NSArray *) valueArray{
//    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
        self = [super initWithNibName:@"TableViewController_ipad" bundle:nil];
    }else{
        self = [super initWithNibName:@"TableViewController_iphone" bundle:nil];
    }
    
    if (self) {
        _cellType = pCellType;
        _titles = itemArray;
        _data = valueArray;
        // NSLog(@"%@ %@",_titles,_data);
        if(pCellType == 4){
            if ([itemArray count] >= 3) {
                _section1RowsNumb = [itemArray[0] count];
                _section2RowsNumb = [itemArray[1] count];
                _section3RowsNumb = [itemArray[2] count];
            }
        }
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
    self.view.backgroundColor = [UIColor clearColor];

    //// NSLog(@"Table Item %@", self.titles[0]);

    //self.titles = @[@"Giai nhat", @"Giai nhi", @"Giai ba"];
    //self.data = @[@"234", @"G24324", @"3245435"];
    
    // Uncomment the following line to preserve selection between presentations.
    // 
    
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
    if(self.cellType == 4){
        return 3;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //#warning Incomplete method implementation.
    // Return the number of rows in the section.
    // // NSLog(@"tableView count: %d", [self.tableData count]);
    if(self.cellType == 4){
        // NSLog(@"section %i",section);
        switch (section) {
            case 0:
                return self.section1RowsNumb;
                break;
            case 1:
                return self.section2RowsNumb;
                break;
            case 2:
                return self.section3RowsNumb;
                break;
                
            default:
                break;
        }
    }
    
    return [self.titles count];
}

//
// 0: Tuong Thuat, So Ket Qua
// 1: Thong Ke (Dac Biet)
// 2: Tu Van (Tips)
// 3: Tu Van (Question)
// 4: Thong Ke nhanh
// 5 soi lo
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UIFont* ipadFont = [UIFont boldSystemFontOfSize:22.0];
    // check cellType
    if (self.cellType == 0) {
        SoKetQuaCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil)
        {
            NSArray *nib;
            //            if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
            if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
                nib = [[NSBundle mainBundle] loadNibNamed:@"SoKetQuaCell_ipad" owner:self options:nil];
            }else{
                nib = [[NSBundle mainBundle] loadNibNamed:@"SoKetQuaCell_iphone" owner:self options:nil];
            }
            
            cell = [nib objectAtIndex:0];
            cell.showsReorderControl = YES;
        }
        
        // Configure the cell...
//        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
            cell.titlelabel.font = ipadFont;
            cell.detailLabel.font = ipadFont;
        }
        
        cell.titlelabel.text = [self.titles objectAtIndex:[indexPath row]];
        //cell.textLabel.backgroundColor = [UIColor clearColor];
        
        @try {            
            cell.detailLabel.text = [self.data objectAtIndex:[indexPath row]];
            cell.detailLabel.numberOfLines = 3;
            [cell.detailTextLabel sizeToFit];
        } @catch (NSException *e) {
            // NSLog(@"%@: %@\n", e.name, e.reason);
        }
        
        //cell.detailTextLabel.backgroundColor = [UIColor clearColor];
        return cell;
    } else if (self.cellType == 1) {
        TwoAttTableCell *cell = (TwoAttTableCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil)
        {
            NSArray *nib;
//            if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
            if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
                nib = [[NSBundle mainBundle] loadNibNamed:@"TwoAttTableCell_ipad" owner:self options:nil];
            }else{             
                nib = [[NSBundle mainBundle] loadNibNamed:@"TwoAttTableCell_iphone" owner:self options:nil];
            }
            
            cell = [nib objectAtIndex:0];
            cell.showsReorderControl = YES;
        }
        
        cell.lblTitle.text = [[NSString alloc]initWithFormat:@"%@",self.titles[indexPath.row]];
        NSArray *date = [self.data[indexPath.row][0] componentsSeparatedByString:@"-"];
        cell.lblDetail.text = [[NSString alloc]initWithFormat:@"%@/%@",date[2], date[1] ];
        cell.lblTitle1.text = self.data[indexPath.row][1];
        cell.lblDetail1.text = self.data[indexPath.row][2];
        
        return  cell;
    } else if (self.cellType == 2) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {        // Create new cell
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            cell.showsReorderControl = YES;
        }
        // Configure the cell...
//        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
            cell.textLabel.font = ipadFont;
            cell.detailTextLabel.font = ipadFont;
        }
        cell.imageView.image = [UIImage imageNamed:@"star.png"];
        cell.textLabel.text = [self.data objectAtIndex:[indexPath row]];
        return cell;
    } else if (self.cellType == 3) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {        // Create new cell
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
            cell.showsReorderControl = YES;
        }
        // Configure the cell...
//        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
            cell.textLabel.font = ipadFont;
        }
        cell.textLabel.text = [self.titles objectAtIndex:[indexPath row]];
        return cell;
    } else if(self.cellType == 4) {
//        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//        if (!cell) {        // Create new cell
//            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
//            cell.showsReorderControl = YES;
//        }
//        // Configure the cell...
////        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
//        if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
//            cell.textLabel.font = ipadFont;
//            cell.detailTextLabel.font = ipadFont;
//        }
//        cell.textLabel.text = self.titles[indexPath.section][indexPath.row];
//        
//        @try {
//            cell.detailTextLabel.text =self.data[indexPath.section][indexPath.row];
//            cell.detailTextLabel.textColor = [UIColor blueColor];
//        } @catch (NSException *e) {
//            // NSLog(@"%@: %@\n", e.name, e.reason);
//        }
//        return cell;
        SoKetQuaCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil)
        {
            NSArray *nib;
            //            if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
            if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
                nib = [[NSBundle mainBundle] loadNibNamed:@"SoKetQuaCell_ipad" owner:self options:nil];
            }else{
                nib = [[NSBundle mainBundle] loadNibNamed:@"SoKetQuaCell_iphone" owner:self options:nil];
            }
            
            cell = [nib objectAtIndex:0];
            cell.showsReorderControl = YES;
        }
        
        // Configure the cell...
        //        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
            cell.titlelabel.font = ipadFont;
            cell.detailLabel.font = ipadFont;
        }
        
        cell.titlelabel.text = self.titles[indexPath.section][indexPath.row];
        //cell.textLabel.backgroundColor = [UIColor clearColor];
        
        @try {
            cell.detailLabel.text = self.data[indexPath.section][indexPath.row];
        } @catch (NSException *e) {
            // NSLog(@"%@: %@\n", e.name, e.reason);
        }
        
        //cell.detailTextLabel.backgroundColor = [UIColor clearColor];
        return cell;
    }
    return nil;
}

// 2: Tu Van (Tips)
// 3: Tu Van (Question)
#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // NSLog(@"select row at: %d", indexPath.row);
    if (self.cellType == 2) {
        [[NetworkController shared] getTipsContentWithID:self.titles[indexPath.row]];
    } else if (self.cellType == 3) {
        //        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Cau hoi" message:@"noi dung" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        //        [alertView show];
    }
}

/*

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellText = @"Go get some text for your cell.";
    UIFont *cellFont = [UIFont fontWithName:@"Helvetica" size:([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) ? 22: 17.0];
    CGSize constraintSize = CGSizeMake(280.0f, MAXFLOAT);
    CGSize labelSize = [cellText sizeWithFont:cellFont constrainedToSize:constraintSize lineBreakMode:UILineBreakModeWordWrap];
    
    return labelSize.height + 20;
}
*/

// heigh of custom cell get from lib file
- (CGFloat)tableView:(UITableView *)aTableView
heightForRowAtIndexPath:(NSIndexPath *)anIndexPath
{
    if(self.cellType == 0){
        if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
            return 70;
        }else{
            
            return 62;
        }
    }else{
        if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
            return 88;
        }else{
            
            return 53;
        }
    }
}

- (NSString *)tableView:(UITableView *)aTableView titleForHeaderInSection:(NSInteger)section
{
    if(self.cellType == 4){
        if (section == 0)
        {
            return NSLocalizedString(@"Về nhiều trong 10 lần quay", nil);
        }
        else if (section == 1)
        {
            return NSLocalizedString(@"Ra liên tiếp", nil);
        }
        else if (section == 2)
        {
            return NSLocalizedString(@"Chưa ra khoảng 10-30 ngày", nil);
        }
        
    }
	return nil;
}

//- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//	UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 40)];
//	tableView.sectionHeaderHeight = headerView.frame.size.height;
//	UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, headerView.frame.size.width - 20, 22)];
//	label.text = [self tableView:tableView titleForHeaderInSection:section];
//	label.font = [UIFont boldSystemFontOfSize:16.0];
//	label.shadowOffset = CGSizeMake(0, 1);
//	label.shadowColor = [UIColor whiteColor];
//	label.backgroundColor = [UIColor clearColor];
//    
////	label.textColor = [[ApplicationControl sharedInstance] fontColor];
//    
//	[headerView addSubview:label];
//	return headerView;
//}



@end
