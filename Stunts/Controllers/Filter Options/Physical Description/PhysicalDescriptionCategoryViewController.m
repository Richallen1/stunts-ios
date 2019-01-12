//
//  PhysicalDecriptionLevel2ViewController.m
//  Stunts
//
//  Created by Richard Allen on 26/06/2018.
//  Copyright © 2018 Richard Allen. All rights reserved.
//

#import "PhysicalDescriptionCategoryViewController.h"
#import "FilterOptionsViewController.h"

@interface PhysicalDescriptionCategoryViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    __weak IBOutlet UILabel *DescriptionHeaderLabel;
    __weak IBOutlet UITableView *categoryTableView;
    NSMutableArray *categoryOptions;
    NSMutableArray *selectedOptions;
}
@end

@implementation PhysicalDescriptionCategoryViewController
@synthesize descriptionCategory;
@synthesize parent;

- (void)viewDidLoad {
    [super viewDidLoad];
    categoryOptions = [[NSMutableArray alloc]init];
    DescriptionHeaderLabel.text = descriptionCategory;
    selectedOptions = [[NSMutableArray alloc]init];
    [self GetData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)GetData
{
    if ([descriptionCategory isEqualToString:@"Eye Colour"])
    {
        [categoryOptions addObject:@"Black"];
        [categoryOptions addObject:@"Blue"];
        [categoryOptions addObject:@"Blue-Green"];
        [categoryOptions addObject:@"Blue-Grey"];
        [categoryOptions addObject:@"Brown"];
        [categoryOptions addObject:@"Green"];
        [categoryOptions addObject:@"Grey"];
        [categoryOptions addObject:@"Grey-Green"];
        [categoryOptions addObject:@"Hazel"];
        [categoryOptions addObject:@"Light Blue"];
    }
    if ([descriptionCategory isEqualToString:@"Hair Colour"])
    {
        [categoryOptions addObject:@"Auburn"];
        [categoryOptions addObject:@"Black"];
        [categoryOptions addObject:@"Blond"];
        [categoryOptions addObject:@"Brown"];
        [categoryOptions addObject:@"Dark Blond"];
        [categoryOptions addObject:@"Dark Brown"];
        [categoryOptions addObject:@"Fair"];
        [categoryOptions addObject:@"Grey"];
        [categoryOptions addObject:@"Greying"];
        [categoryOptions addObject:@"Medium Blond"];
        [categoryOptions addObject:@"Sandy"];
        [categoryOptions addObject:@"Titain"];
        [categoryOptions addObject:@"White"];
    }
    if ([descriptionCategory isEqualToString:@"Facial Hair"])
    {
        [categoryOptions addObject:@"None"];
        [categoryOptions addObject:@"Beard"];
        [categoryOptions addObject:@"Clean Shaven"];
        [categoryOptions addObject:@"Full Set"];
        [categoryOptions addObject:@"Goatee"];
        [categoryOptions addObject:@"Moustache"];
        [categoryOptions addObject:@"Side Burns"];
    }
    if ([descriptionCategory isEqualToString:@"Hair Length"])
    {
        [categoryOptions addObject:@"Bald"];
        [categoryOptions addObject:@"Balding"];
        [categoryOptions addObject:@"Shaved"];
        [categoryOptions addObject:@"Short"];
        [categoryOptions addObject:@"Mid Length"];
        [categoryOptions addObject:@"Long"];
    }

    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return categoryOptions.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIFont *labelFont = [UIFont fontWithName:@"SFProText-Light" size:17];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    cell.textLabel.text = [categoryOptions objectAtIndex:indexPath.row];
    cell.textLabel.font = labelFont;
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ([selectedOptions containsObject:indexPath]) {
        cell.accessoryType = UITableViewCellAccessoryNone;
        [selectedOptions removeObject:indexPath];
    } else {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        [selectedOptions addObject:indexPath];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(IBAction)Done:(id)sender
{
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    
    for (NSIndexPath *path in selectedOptions)
    {
        [arr addObject:[categoryOptions objectAtIndex:path.row]];
    }
    
    FilterOptionsViewController *grandParent = parent.parent;
    [grandParent.filterChoices setObject:arr forKey:descriptionCategory];
    NSLog(@"Parent filter selection: %@", parent.physicalFilterSelections);
    NSLog(@"Parent: %@", parent);
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

-(IBAction)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
