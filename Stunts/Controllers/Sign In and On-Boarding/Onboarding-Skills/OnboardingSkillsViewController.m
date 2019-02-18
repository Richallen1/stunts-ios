//
//  OnboardingSkillsViewController.m
//  Stunts
//
//  Created by Richard Allen on 03/06/2018.
//  Copyright © 2018 Richard Allen. All rights reserved.
//

#import "OnboardingSkillsViewController.h"
#import "OnboardingGalleryViewController.h"


@interface OnboardingSkillsViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    __weak IBOutlet UITableView *SkillsTableView;
    NSMutableArray *skills;
    NSMutableArray *selectedSkills;
}
@end

@implementation OnboardingSkillsViewController
@synthesize profile;


- (void)viewDidLoad {
    [super viewDidLoad];
    SkillsTableView.separatorInset = UIEdgeInsetsZero;
    selectedSkills = [[NSMutableArray alloc]init];
    skills = [self GetAvialableSkills];
    
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

-(IBAction)Next:(id)sender
{
    //Get Selected Skills
   
    NSMutableArray *arr = [[NSMutableArray  alloc]init];
    for (NSIndexPath *path in selectedSkills)
    {
        [arr addObject:[[[skills objectAtIndex:path.section]objectForKey:@"skills"]objectAtIndex:path.row]];
    }
    
    //Add to Profile Object
    profile[@"skills"] = arr;

    //creditsDone
    [self performSegueWithIdentifier:@"creditsDone" sender:self];
    //[self performSegueWithIdentifier:@"gallery_segue" sender:self];
}
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"gallery_segue"])
    {
    }
}
-(NSMutableArray *)GetAvialableSkills
{
    NSMutableArray *returnValue = [[NSMutableArray alloc]init];
    
    /*Combat Skills*/
    NSMutableDictionary *combat = [[NSMutableDictionary alloc]init];
    [combat setObject:@"Combat" forKey:@"title"];
    NSArray *combatSkills = [[NSArray alloc] initWithObjects:@"Aikido Boxing",@"ABA Boxing",@"Champion Boxing",@"Coach Boxing",@"Professional Fencing Fight Choreography Firearms Firearms",@"Basic Handling Firearms",@"Special Ops Firearms",@"Vintage Firearms Instructor Hand to Hand Combat Jousting Jiu Jitsu Ji",@"itsu",@"Brazilian  Judo Karate Kendo Kickboxing Knife Work Krav Maga Kung Fu Martial Art",@"Champion Martial Arts",@"Coach Martial Arts",@"Tricking Martial Arts",@"Various Mixed Martial Arts (MMA)",@"Amateur Mixed Martial Arts (MMA)Pro ",@"Muay Thai", @"Nunchaku",@"Sanda",@"Staff",@"Sword & Shield Work",@"Tae Kwon Do",@"WeaponryMedieval",@"Weaponry Oriental",@"Wing Chun",@"Wrestling",@"Wushu", nil];
    [combat setObject:combatSkills forKey:@"skills"];
    [returnValue addObject:combat];
    
    /*Falls and Heights Skills*/
    NSMutableDictionary *falls = [[NSMutableDictionary alloc]init];
    [falls setObject:@"Falls" forKey:@"title"];
    NSArray *fallsSkills = [[NSArray alloc] initWithObjects:@"Air Bags", @"Air Ram", @"Bungee", @"Car Knockdowns", @"Falls - Air Bags", @"Falls - 25m +", @"Falls - Saddle", @"Falls - Stairs", @"Falls - Up to 10m", @"Falls - Up to 20m", @"Falls - Up to 5m", @"Falls - Water", @"High Dive", @"High Fall Specialist", @"Springboard", @"Trampette", @"Trampoline", nil];
    [falls setObject:fallsSkills forKey:@"skills"];
    [returnValue addObject:falls];
    
    /*Riding*/
    
    NSMutableDictionary *riding = [[NSMutableDictionary alloc]init];
    [riding setObject:@"Horse Riding" forKey:@"title"];
    NSArray *ridingSkills = [[NSArray alloc] initWithObjects:@"Car Knockdowns", @"Driving - Blind", @"Driving - Drifting", @"Driving - Off Road", @"Driving - Precision", @"Driving - Rally", @"Driving - Tank", @"Farm Machinery Operator", @"Heavy Plant Operator", @"HGV", @"Horse - Dressage", @"Horse - Eventing", @"Horse - Trick Riding", @"Horse Carriage/Chariot Driver", @"Horse Master", @"Horse Riding - Advanced", @"Horse Riding - Basic", @"Jet Ski", @"Jousting", @"Kart Racing", @"Motocross", @"Motorboat", @"Motorcycle", @"Motorcycle - Lay Down", @"Motorcycle - Tricks", @"Pipe Ramps", @"Powerboat", @"Quad Bike", @"Rodeo", @"Sailing", @"Snowmobile", @"Vehicle Crashes", @"Water Ski", nil];
    [riding setObject:ridingSkills forKey:@"skills"];
    [returnValue addObject:riding];
    
//    /*Driving */
//
//    NSMutableDictionary *driving = [[NSMutableDictionary alloc]init];
//    [driving setObject:@"Driving" forKey:@"title"];
//    NSArray *drivingSkills = [[NSArray alloc] initWithObjects:@"Motorcycle - Tricks", @"Rally", @"Precision Driving", @"Pipe Ramps", @"Drifting", @"Kart Racing", @"HGV", @"Heavy Plant Operator", @"Farm Machinery Operator", nil];
//    [driving setObject:drivingSkills forKey:@"skills"];
//    [returnValue addObject:driving];
    
    /*Agillity */
    
    NSMutableDictionary *agility = [[NSMutableDictionary alloc]init];
    [agility setObject:@"Agility & Strength" forKey:@"title"];
    NSArray *agilitySkills = [[NSArray alloc] initWithObjects: @"Acrobatics", @"Acrodance", @"Ballet", @"Breakdance", @"Capoeira", @"Dance", @"Gymnastics", @"Ice Climbing", @"Parkour", @"Rock Climbing", @"Tumbling", nil];
    [agility setObject:agilitySkills forKey:@"skills"];
    [returnValue addObject:agility];
    
    /* Water */
    
    NSMutableDictionary *water = [[NSMutableDictionary alloc]init];
    [water setObject:@"Water" forKey:@"title"];
    NSArray *waterSkills = [[NSArray alloc] initWithObjects: @"Breath Holds", @"Canoe", @"Diving - 10m High Dive", @"Diving - Advanced", @"Diving - Cliff", @"Diving - Free", @"Diving - High", @"Diving - Sub Aqua", @"Jet Ski", @"Kayaking", @"Motorboat", @"PADI Divemaster", @"Powerboat", @"Sailing", @"Surfing", @"Swimming", @"Wake Boarding", @"Water Skiing", @"Wind-Surfing", nil];

    [water setObject:waterSkills forKey:@"skills"];
    [returnValue addObject:water];
    
    /* Air */
    
    NSMutableDictionary *air = [[NSMutableDictionary alloc]init];
    [air setObject:@"Air" forKey:@"title"];
    NSArray *airSkills = [[NSArray alloc] initWithObjects: @"Air Ram", @"Base Jumping", @"Bungee Jumping", @"Parachute", @"Paraglide", @"Pilot - Autogyro", @"Pilot - Fixed Wing", @"Pilot - Glider", @"Pilot - Helicopter", @"Pilot - Hot Air Balloon", @"Pilot - Microlight", @"Skydiving", @"Skydiving - Synchronised", @"Wing Suit", @"Wing Suit - Synchronised", nil];
    [air setObject:airSkills forKey:@"skills"];
    [returnValue addObject:air];

    /* Fire */
    
    NSMutableDictionary *fire = [[NSMutableDictionary alloc]init];
    [fire setObject:@"Fire" forKey:@"title"];
    NSArray *fireSkills = [[NSArray alloc] initWithObjects:@"Burns - Basic", @"Burns - Experienced", @"Burns - Expert", @"Burns - Full", @"Burns - Partial", @"Fire Fighter", @"Fire Safety Trained", nil];
    [fire setObject:fireSkills forKey:@"skills"];
    [returnValue addObject:fire];
    
    /* Other Roles Experience */
    
    NSMutableDictionary *other = [[NSMutableDictionary alloc]init];
    [other setObject:@"Other -Stunt Specific" forKey:@"title"];
    NSArray *otherSkills = [[NSArray alloc] initWithObjects: @"2nd Unit Director", @"Camera Operator", @"Camera Operator - Underwater", @"Camera Tracking", @"Drama Qualification", @"First Aid", @"Health & Safety Qualification", @"Live Performance", @"Rigging", @"Rigging Supervisor", @"Script Breakdown", @"Theatre", nil];
    [other setObject:otherSkills forKey:@"skills"];
    [returnValue addObject:other];
    
    /* Misc Skills/Sports */
    
    NSMutableDictionary *otherSports = [[NSMutableDictionary alloc]init];
    [otherSports setObject:@"Other - Sports/Specialisms" forKey:@"title"];
    NSArray *otherSportsSkills = [[NSArray alloc] initWithObjects: @"2nd Language", @"Abseiling", @"Acrobatics", @"Acrodance", @"Acting", @"Animatronics", @"Archery", @"Ballet", @"BMX", @"Bullet Reactions", @"Capoeira", @"Circus Skills", @"Creature Work", @"Decathlon", @"Endurance Cycle", @"Fan Descending", @"Fitness Instructor", @"Ice Skating", @"Iron Man", @"Jerkbacks", @"Military - Commando", @"Military - Service Trained", @"Military - Skills for Screen", @"Military - Special Ops", @"Motion Capture", @"Parkour/Free Running", @"Personal Trainer", @"Public Speaking", @"Ratchets", @"Rock Climbing", @"Roller-Blading", @"Roller-Skating", @"Rugby", @"Russian Swing", @"Skateboarding", @"Skiing (snow)", @"Snowboarding", @"Stilts", @"Triathlon", @"Wire Work", @"Work at Heights", nil];
    [otherSports setObject:otherSportsSkills forKey:@"skills"];
    [returnValue addObject:otherSports];

    
    return returnValue;
}
@end
