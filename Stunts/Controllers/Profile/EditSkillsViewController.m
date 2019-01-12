//
//  EditSkillsViewController.m
//  Stunts
//
//  Created by Richard Allen on 25/06/2018.
//  Copyright © 2018 Richard Allen. All rights reserved.
//

#import "EditSkillsViewController.h"
#import "MBProgressHUD.h"


@interface EditSkillsViewController ()
{
    __weak IBOutlet UITableView *SkillsTableView;
    NSMutableArray *skills;
    NSMutableArray *selectedSkills;
    NSMutableArray *retrievedSkills;
}
@end

@implementation EditSkillsViewController
@synthesize profile;

- (void)viewDidLoad {
    [super viewDidLoad];
    SkillsTableView.separatorInset = UIEdgeInsetsZero;
    selectedSkills = [[NSMutableArray alloc]init];
    skills = [self GetAvialableSkills];
    
    retrievedSkills = profile[@"skills"];
    
    NSLog(@"Sklills: %@", retrievedSkills);
    [self GetIndexPathsForMatchedSkills];
    
    
}

-(void)GetIndexPathsForMatchedSkills
{
    NSIndexPath *path;
    
    for (int i = 0; i<= skills.count-1; i++)
    {
        for (NSString *str in [[skills objectAtIndex:i]objectForKey:@"skills"])
        {
            if ([retrievedSkills containsObject:str])
            {
                NSLog(@"Matched index %lu for %@", [[[skills objectAtIndex:i]objectForKey:@"skills"] indexOfObject:str], str);
                path = [NSIndexPath indexPathForRow:[[[skills objectAtIndex:i]objectForKey:@"skills"] indexOfObject:str] inSection:i];
                [selectedSkills addObject:path];
            }
        }
    }
    
    
    [SkillsTableView reloadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[skills objectAtIndex:section] objectForKey:@"skills"] count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return [skills count];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
    return [[skills objectAtIndex:section] objectForKey:@"title"];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    NSArray *skillsArray = [[skills objectAtIndex:indexPath.section] objectForKey:@"skills"];
    
    if ([selectedSkills containsObject:indexPath])
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    
    cell.textLabel.text = [skillsArray objectAtIndex:indexPath.row];
    
    cell.layoutMargins = UIEdgeInsetsZero;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([selectedSkills containsObject:indexPath]) {
        cell.accessoryType = UITableViewCellAccessoryNone;
        [selectedSkills removeObject:indexPath];
    } else {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        [selectedSkills addObject:indexPath];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



-(NSMutableArray *)GetAvialableSkills
{
    NSMutableArray *returnValue = [[NSMutableArray alloc]init];
    
    /*Combat Skills*/
    NSMutableDictionary *combat = [[NSMutableDictionary alloc]init];
    [combat setObject:@"Combat" forKey:@"title"];
    NSArray *combatSkills = [[NSArray alloc] initWithObjects:@"Fight choreography", @"Sword  & Shield Work", @"Fencing", @"Jousting", @"Armoury", nil];
    [combat setObject:combatSkills forKey:@"skills"];
    [returnValue addObject:combat];
    
    /*Falls and Heights Skills*/
    NSMutableDictionary *falls = [[NSMutableDictionary alloc]init];
    [falls setObject:@"Falls" forKey:@"title"];
    NSArray *fallsSkills = [[NSArray alloc] initWithObjects:@"Trampoline", @"High Dive", @"Air Ram", @"Air Bag Falls", @"Car Knockdowns", @"Falls >50ft", @"High Falls <50ft", @"High Dive 10m", @"Springboard", @"Work at Heights", @"Stair Falls", nil];
    [falls setObject:fallsSkills forKey:@"skills"];
    [returnValue addObject:falls];
    
    /*Riding*/
    
    NSMutableDictionary *riding = [[NSMutableDictionary alloc]init];
    [riding setObject:@"Horse Riding" forKey:@"title"];
    NSArray *ridingSkills = [[NSArray alloc] initWithObjects:@"Horse Riding", @"Horse Master", @"Coach/Chariot Driver", @"Jousting", @"Dressage", @"BMX", nil];
    [riding setObject:ridingSkills forKey:@"skills"];
    [returnValue addObject:riding];
    
    /*Driving */
    
    NSMutableDictionary *driving = [[NSMutableDictionary alloc]init];
    [driving setObject:@"Driving" forKey:@"title"];
    NSArray *drivingSkills = [[NSArray alloc] initWithObjects:@"Motorcycle - Tricks", @"Rally", @"Precision Driving", @"Pipe Ramps", @"Drifting", @"Kart Racing", @"HGV", @"Heavy Plant Operator", @"Farm Machinery Operator", @"Motorboat", @"Powerboat", @"Sailing", @"Water Ski", nil];
    [driving setObject:drivingSkills forKey:@"skills"];
    [returnValue addObject:driving];
    
    /*Driving */
    
    NSMutableDictionary *agility = [[NSMutableDictionary alloc]init];
    [agility setObject:@"Agility & Strength" forKey:@"title"];
    NSArray *agilitySkills = [[NSArray alloc] initWithObjects: @"Gymnastics", @"Rock Climbing", @"Dance", @"Breakdance", @"Bungee", @"Parkour", @"Tumbling", nil];
    [agility setObject:agilitySkills forKey:@"skills"];
    [returnValue addObject:agility];
    
    /* Water */
    
    NSMutableDictionary *water = [[NSMutableDictionary alloc]init];
    [water setObject:@"Water" forKey:@"title"];
    NSArray *waterSkills = [[NSArray alloc] initWithObjects: @"Swimming", @"Sub Aqua", @"Advanced Diver", @"Cliff diving", @"Motorboat", @"PADI Divemaster", @"Powerboat", @"Sailing", @"Surf", @"Wake Boarding", @"Water Ski", @"Wind-Surf", nil];
    
    [water setObject:waterSkills forKey:@"skills"];
    [returnValue addObject:water];
    
    /* Air */
    
    NSMutableDictionary *air = [[NSMutableDictionary alloc]init];
    [air setObject:@"Air" forKey:@"title"];
    NSArray *airSkills = [[NSArray alloc] initWithObjects: @"Air Ram", @"Bunji", @"Hot Air Balloon", @"Microlight", @"Parachute", @"Paraglide", @"Synchronised Parachute", @"Synchronised Wing Suit", @"Wing Suit", nil];
    [air setObject:airSkills forKey:@"skills"];
    [returnValue addObject:air];
    
    /* Fire */
    
    NSMutableDictionary *fire = [[NSMutableDictionary alloc]init];
    [fire setObject:@"Fire" forKey:@"title"];
    NSArray *fireSkills = [[NSArray alloc] initWithObjects: @"Burns - Basic", @"Burns - Experienced", @"Burns - Expert", @"Partial  Burns", @"Full Burns", @"Fire Safety", nil];
    [fire setObject:fireSkills forKey:@"skills"];
    [returnValue addObject:fire];
    
    /* Other Stunts */
    
    NSMutableDictionary *other = [[NSMutableDictionary alloc]init];
    [other setObject:@"Other -Stunt Specific" forKey:@"title"];
    NSArray *otherSkills = [[NSArray alloc] initWithObjects: @"2nd Unit Director", @"Acting", @"Bungee", @"Burns", @"Camera", @"First Aid", @"Jerks", @"Mo-Cap Performer", @"Rigging", @"Rigging Supervisor", @"Wire Work", nil];
    [other setObject:otherSkills forKey:@"skills"];
    [returnValue addObject:other];
    
    /* Other Sports */
    
    NSMutableDictionary *otherSports = [[NSMutableDictionary alloc]init];
    [otherSports setObject:@"Other - Sports/Specialisms" forKey:@"title"];
    NSArray *otherSportsSkills = [[NSArray alloc] initWithObjects: @"Archery", @"Abseiling", @"Circus Skills", @"Decathlon", @"Endurance Cycle", @"Iron Man", @"Parkour", @"Rock Climbing", @"Rugby", @"Skiing", @"Snowboarding", @"Triathlon", nil];
    [otherSports setObject:otherSportsSkills forKey:@"skills"];
    [returnValue addObject:otherSports];
    
    
    return returnValue;
}
- (IBAction)done:(id)sender
{
    NSMutableArray *arr = [[NSMutableArray  alloc]init];
    for (NSIndexPath *path in selectedSkills)
    {
        NSString *str = [[[skills objectAtIndex:path.section]objectForKey:@"skills"]objectAtIndex:path.row];
        NSLog(@"%@ - %@", path, str);
        [arr addObject:[[[skills objectAtIndex:path.section]objectForKey:@"skills"]objectAtIndex:path.row]];
    }
    NSLog(@"%@", arr);
    
    //Add to Profile Object
    profile[@"skills"] = arr;
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.label.text = @"Saving Skills..";
    
    [profile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            
            [hud hideAnimated:YES];
            [self.navigationController popViewControllerAnimated:YES];
            
        } else {
            
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Oops....."
                                                                           message:@"We seem to have hit an issue in saving your skills. Please try again. If the problem persists please contact britishstuntapp@gmail.com"
                                                                    preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction * action) {}];
            
            
            [alert addAction:defaultAction];
            [self presentViewController:alert animated:YES completion:nil];
            [self.navigationController popViewControllerAnimated:YES];
            
        }
    }];

}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end