//
//  LocationTableViewController.m
//  TaiLocPhat
//
//  Created by Maximus on 9/20/13.
//  Copyright (c) 2013 Hai Do Minh. All rights reserved.
//

#import "LocationTableViewController.h"

@interface LocationTableViewController ()

@property NSDictionary *alphabetizedLocationArray;

@end

@implementation LocationTableViewController

@synthesize locationArray;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initLocationArray: (NSArray *)locArray{
    self = [super init];
    if(self){
        locationArray = locArray;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.alphabetizedLocationArray = [self alphabetizeFruits:self.locationArray];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark Table View Data Source Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // return 1;
    
    NSArray *keys = [self.alphabetizedLocationArray allKeys];
    return [keys count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // return [self.fruits count];
    
    NSArray *unsortedKeys = [self.alphabetizedLocationArray allKeys];
    NSArray* sortedValues = [unsortedKeys sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    NSString *key = [sortedValues objectAtIndex:section];
    NSArray *fruitsForSection = [self.alphabetizedLocationArray objectForKey:key];
    return [fruitsForSection count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell Identifier";
    
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Fetch Fruit
    NSArray *unsortedKeys = [self.alphabetizedLocationArray allKeys];
    NSArray* sortedValues = [unsortedKeys sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    NSString *key = [sortedValues objectAtIndex:indexPath.section];
    NSArray *locationForSection = [self.alphabetizedLocationArray objectForKey:key];
    NSString *location = [locationForSection objectAtIndex:indexPath.row];
    
    [cell.textLabel setText:location];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSArray *keys = [self.alphabetizedLocationArray allKeys];
    NSArray* sortedValues = [keys sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];  
    NSString *key = [sortedValues objectAtIndex:section];
    return key;
}

#pragma mark -
#pragma mark Table View Delegate Methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Fetch Fruit
    NSArray *unsortedKeys = [self.alphabetizedLocationArray allKeys];
    NSArray* sortedValues = [unsortedKeys sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    NSString *key = [sortedValues objectAtIndex:[indexPath section]];
    NSArray *locationForSection = [self.alphabetizedLocationArray objectForKey:key];
    self.chossenLocation = [locationForSection objectAtIndex:[indexPath row]];
}

#pragma mark -
#pragma mark Helper Methods
- (NSDictionary *)alphabetizeFruits:(NSArray *)fruits {
    NSMutableDictionary *buffer = [[NSMutableDictionary alloc] init];
    
    // Put Fruits in Sections
    for (int i = 0; i < [fruits count]; i++) {
        NSString *fruit = [fruits objectAtIndex:i];
        NSString *firstLetter = [[fruit substringToIndex:1] uppercaseString];
        
        if ([buffer objectForKey:firstLetter]) {
            [(NSMutableArray *)[buffer objectForKey:firstLetter] addObject:fruit];
        } else {
            NSMutableArray *mutableArray = [[NSMutableArray alloc] initWithObjects:fruit, nil];
            [buffer setObject:mutableArray forKey:firstLetter];
        }
    }
    
    // Sort Fruits
    NSArray *keys = [buffer allKeys];
    for (int j = 0; j < [keys count]; j++) {
        NSString *key = [keys objectAtIndex:j];
        [(NSMutableArray *)[buffer objectForKey:key] sortUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    }
    
    return buffer;
}
@end
