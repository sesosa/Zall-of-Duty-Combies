//  ***
//
//  Game.m
//  StarterGame
//
//  Created by Savannah Sosa and Aaron Chapman on 5/2/15.
//  Copyright (c) 2015 All rights reserved.
//

#import "Game.h"

@implementation Game

@synthesize parser, player, rooms, combieRoomArray, lobby, cafeteria, meetingRoom, lockerRoom, developmentRoom, warpRoom, factorySection1, factorySection2, factorySection3, factorySection4, factorySection5;

-(id)initWithGameIO:(GameIO *)theIO {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(allCombiesKilled:) name:@"allCombiesKilled" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(medicalFileObtained:) name:@"medicalFileObtained" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(warpToRoof:) name:@"warpToRoof" object:nil];
    
	self = [super init];
    
	if (nil != self) {
		[self setParser:[[[Parser alloc] init] autorelease]];
		[self setPlayer:[[[Player alloc] initWithRoom:[self createWorld] andIO:theIO] autorelease]];
        
        playing = NO;
        combieCounter = 0;
        combieRoomArray = [[NSMutableArray alloc] initWithObjects: cafeteria, meetingRoom, lockerRoom, developmentRoom, warpRoom, factorySection1, factorySection2, factorySection3, factorySection4, factorySection5, nil];
        rooms = [[NSMutableArray alloc] initWithObjects:lobby, cafeteria, meetingRoom, lockerRoom, developmentRoom, warpRoom, factorySection1, factorySection2, factorySection3, factorySection4, factorySection5, nil];
        
        combiesKilled = NO;
        obtainedMedicalFile = NO;
	}
    
	return self;
}

-(Room *)createWorld {
    lobby = [[[Room alloc] initWithTag:@"in the lobby" locked:NO] autorelease];
    cafeteria = [[[Room alloc] initWithTag:@"in the cafeteria" locked:YES] autorelease];
    meetingRoom = [[[Room alloc] initWithTag:@"in the meeting room" locked:YES] autorelease];
    lockerRoom = [[[Room alloc] initWithTag:@"in the locker room" locked:NO] autorelease];
    developmentRoom = [[[Room alloc] initWithTag:@"in the development room" locked:YES] autorelease];
    warpRoom = [[[Room alloc] initWithTag:@"in the warp room" locked:YES] autorelease];
    factorySection1 = [[[Room alloc] initWithTag:@"in factory section 1: shipment" locked:YES] autorelease];
    factorySection2 = [[[Room alloc] initWithTag:@"in factory section 2: assembly" locked:NO] autorelease];
    factorySection3 = [[[Room alloc] initWithTag:@"in factory section 3: welding" locked:NO] autorelease];
    factorySection4 = [[[Room alloc] initWithTag:@"in factory section 4: plastics" locked:NO] autorelease];
    factorySection5 = [[[Room alloc] initWithTag:@"in factory section 5: storage" locked:NO] autorelease];
    
    [lobby setExit:@"north" toRoom:cafeteria];
    [lobby setExit:@"west" toRoom:meetingRoom];
    [lobby setExit:@"east" toRoom:factorySection1];
    
    [cafeteria setExit:@"north" toRoom:factorySection4];
    [cafeteria setExit:@"west" toRoom:lockerRoom];
    [cafeteria setExit:@"east" toRoom:factorySection2];
    [cafeteria setExit:@"south" toRoom:lobby];
    
    [meetingRoom setExit:@"east" toRoom:lobby];
    
    [lockerRoom setExit:@"east" toRoom:cafeteria];
    [lockerRoom setExit:@"north" toRoom:factorySection5];
    
    [developmentRoom setExit:@"west" toRoom:warpRoom];
    [developmentRoom setExit:@"south" toRoom:factorySection3];
    
    [warpRoom setExit:@"east" toRoom:developmentRoom];
    
    [factorySection1 setExit:@"west" toRoom:lobby];
    [factorySection1 setExit:@"north" toRoom:factorySection2];
    
    [factorySection2 setExit:@"west" toRoom:cafeteria];
    [factorySection2 setExit:@"north" toRoom:factorySection3];
    [factorySection2 setExit:@"south" toRoom:factorySection1];
    
    [factorySection3 setExit:@"north" toRoom:developmentRoom];
    [factorySection3 setExit:@"south" toRoom:factorySection2];
    [factorySection3 setExit:@"west" toRoom:factorySection4];
    
    [factorySection4 setExit:@"south" toRoom:cafeteria];
    [factorySection4 setExit:@"east" toRoom:factorySection3];
    [factorySection4 setExit:@"west" toRoom:factorySection5];
    
    [factorySection5 setExit:@"east" toRoom:factorySection4];
    [factorySection5 setExit:@"south" toRoom:lockerRoom];
    
    [self createItems];
    
    combieCreator = [NSTimer scheduledTimerWithTimeInterval:30.0 target:self selector:@selector(createCombies) userInfo:nil repeats:YES];
        
    return lobby;
}

-(void)createItems {
    [lobby addItem:[[Item alloc] initWithName:@"computer" andDescription:@"the computer seems to be broken, but there is a sticky note attached to the monitor with the word \"obando\" written on it" andWeight:41 andVolume:26 andCost:30 andSubItem:nil]];
    [lobby addItem:[[Item alloc] initWithName:@"chair" andDescription:@"a chair for the desk" andWeight:24 andVolume:32 andCost:17 andSubItem:nil]];
    [lobby addItem:[[Item alloc] initWithName:@"desk" andDescription:@"a desk for the long-deceased secretary" andWeight:100 andVolume:50 andCost:nil andSubItem:nil]];
    [lobby addItem:[[Item alloc] initWithName:@"scancard" andDescription:@"a scancard needed to enter the factory" andWeight:1 andVolume:1 andCost:nil andSubItem:nil]];
    [lobby addItem:[[Item alloc] initWithName:@"magazines" andDescription:@"a stack of bayploys" andWeight:5 andVolume:2 andCost:13 andSubItem:nil]];
    [lobby addItem:[[Item alloc] initWithName:@"plant" andDescription:@"perhaps a fern?" andWeight:8 andVolume:14 andCost:9 andSubItem:nil]];
    
    [cafeteria addItem:[[Item alloc] initWithName:@"soda" andDescription:@"i probably would not drink that" andWeight:3 andVolume:2 andCost:5 andSubItem:nil]];
    [cafeteria addItem:[[Item alloc] initWithName:@"fruit" andDescription:@"i definitely would not eat that" andWeight:3 andVolume:2 andCost:nil andSubItem:nil]];
    [cafeteria addItem:[[Item alloc] initWithName:@"tables" andDescription:@"these are for sitting and eating at" andWeight:100 andVolume:50 andCost:nil andSubItem:nil]];
    [cafeteria addItem:[[Item alloc] initWithName:@"tray" andDescription:@"for holding food" andWeight:3 andVolume:8 andCost:3 andSubItem:nil]];
    [cafeteria addItem:[[Item alloc] initWithName:@"fridge" andDescription:@"looks like there's some aged chinese food inside - better not open it" andWeight:100 andVolume:50 andCost:nil andSubItem:nil]];
    
    Item *developmentRoomKey = [[Item alloc] initWithName:@"d-key" andDescription:@"a large steel dongle with the letter \"d\" welded on" andWeight:1 andVolume:1 andCost:nil andSubItem:nil];
                                
    [meetingRoom addItem:[[Item alloc] initWithName:@"phone" andDescription:@"the line is dead" andWeight:6 andVolume:10 andCost:15 andSubItem:nil]];
    [meetingRoom addItem:[[Item alloc] initWithName:@"chairs" andDescription:@"high quality office chairs" andWeight:60 andVolume:48 andCost:34 andSubItem:nil]];
    [meetingRoom addItem:[[Item alloc] initWithName:@"table" andDescription:@"holds up to 12 people" andWeight:100 andVolume:50 andCost:nil andSubItem:nil]];
    [meetingRoom addItem:[[Item alloc] initWithName:@"closet" andDescription:@"there are mops and a d-key in here" andWeight:100 andVolume:50 andCost:nil andSubItem:developmentRoomKey]];
    
    Item *meetingRoomKey = [[Item alloc] initWithName:@"m-key" andDescription:@"a silver key with the letter \"m\" imprinted on it" andWeight:1 andVolume:1 andCost:nil andSubItem:nil];
    Item *gun = [[Item alloc] initWithName:@"gun" andDescription:@"this will probably work better than a knife" andWeight:4 andVolume:4 andCost:nil andSubItem:nil];
    
    [gun setAttack:2];
    
    [lockerRoom addItem:[[Item alloc] initWithName:@"locker-a" andDescription:@"this locker appears to be locked" andWeight:100 andVolume:50 andCost:nil andSubItem:nil]];
    [lockerRoom addItem:[[Item alloc] initWithName:@"locker-b" andDescription:@"an open locker with an m-key inside" andWeight:100 andVolume:50 andCost:nil andSubItem:meetingRoomKey]];
    [lockerRoom addItem:[[Item alloc] initWithName:@"locker-c" andDescription:@"there's a handgun in here" andWeight:100 andVolume:50 andCost:nil andSubItem:gun]];
    [lockerRoom addItem:[[Item alloc] initWithName:@"towel" andDescription:@"just a towel" andWeight:4 andVolume:3 andCost:2 andSubItem:nil]];
    [lockerRoom addItem:[[Item alloc] initWithName:@"bench" andDescription:@"a long bench for sitting" andWeight:100 andVolume:50 andCost:nil andSubItem:nil]];
    
    Item *medicalFile = [[Item alloc] initWithName:@"m-file" andDescription:@"this is the medical file you need" andWeight:1 andVolume:1 andCost:nil andSubItem:nil];
    Item *keyFile = [[Item alloc] initWithName:@"file" andDescription:@"found something in the factory today. i think it was a tool, so i put it in the toolbox" andWeight:1 andVolume:1 andCost:nil andSubItem:nil];
    
    [developmentRoom addItem:[[Item alloc] initWithName:@"chest" andDescription:@"trading chest\noptions:    buy glock-18c (30 credits)\n\t\tbuy spas-12 (50 credits)\n\t\tbuy ak-47 (70 credits)\n\n\t\tsell *item name*" andWeight:100 andVolume:50 andCost:nil andSubItem:nil]];
    [developmentRoom addItem:[[Item alloc] initWithName:@"computer" andDescription:@"there is a file on this computer" andWeight:100 andVolume:50 andCost:nil andSubItem:keyFile]];
    [developmentRoom addItem:[[Item alloc] initWithName:@"cabinet" andDescription:@"there's something labeled \"m-file\" sticking out" andWeight:100 andVolume:50 andCost:nil andSubItem:medicalFile]];

    [warpRoom addItem:[[Item alloc] initWithName:@"warp" andDescription:@"experimental teleport\noptions:    warp random\n\t\twarp roof" andWeight:100 andVolume:50 andCost:nil andSubItem:nil]];
    
    Item *warpRoomKey = [[Item alloc] initWithName:@"w-key" andDescription:@"you've never seen anything like it" andWeight:1 andVolume:1 andCost:nil andSubItem:nil];
    NSArray *factoryArray = [NSArray arrayWithObjects: factorySection1, factorySection2, factorySection3, factorySection4, factorySection5, nil];
    Room *random = [Room alloc];
    
    [[random randomFactorySection:factoryArray] addItem:[[Item alloc] initWithName:@"toolbox" andDescription:@"among assorted tools, there is a w-key" andWeight:10 andVolume:10 andCost:25 andSubItem:warpRoomKey]];
    
    [factorySection1 addItem:[[Item alloc] initWithName:@"boxes" andDescription:@"boxes for shipment" andWeight:100 andVolume:50 andCost:nil andSubItem:nil]];
    [factorySection1 addItem:[[Item alloc] initWithName:@"tape" andDescription:@"probably for boxes" andWeight:6 andVolume:3 andCost:2 andSubItem:nil]];
    [factorySection1 addItem:[[Item alloc] initWithName:@"labels" andDescription:@"labels for box shipment" andWeight:4 andVolume:2 andCost:1 andSubItem:nil]];
    
    [factorySection2 addItem:[[Item alloc] initWithName:@"bench" andDescription:@"a long bench for sitting" andWeight:100 andVolume:50 andCost:nil andSubItem:nil]];
    [factorySection2 addItem:[[Item alloc] initWithName:@"fasteners" andDescription:@"nuts n bolts n such" andWeight:30 andVolume:22 andCost:14 andSubItem:nil]];
    [factorySection3 addItem:[[Item alloc] initWithName:@"tools" andDescription:@"welding tools" andWeight:35 andVolume:20 andCost:28 andSubItem:nil]];
    [factorySection3 addItem:[[Item alloc] initWithName:@"cart" andDescription:@"transportation cart" andWeight:100 andVolume:50 andCost:nil andSubItem:nil]];
    
    [factorySection3 addItem:[[Item alloc] initWithName:@"tools" andDescription:@"welding tools" andWeight:35 andVolume:20 andCost:28 andSubItem:nil]];
    [factorySection3 addItem:[[Item alloc] initWithName:@"scrap" andDescription:@"metal that has been scrapped" andWeight:100 andVolume:50 andCost:nil andSubItem:nil]];
    [factorySection3 addItem:[[Item alloc] initWithName:@"gloves" andDescription:@"protective gloves" andWeight:5 andVolume:7 andCost:2 andSubItem:nil]];
    [factorySection3 addItem:[[Item alloc] initWithName:@"bucket" andDescription:@"liquids can go in here" andWeight:4 andVolume:10 andCost:4 andSubItem:nil]];
    [factorySection3 addItem:[[Item alloc] initWithName:@"extinguisher" andDescription:@"why is this here?" andWeight:15 andVolume:25 andCost:22 andSubItem:nil]];
    
    [factorySection4 addItem:[[Item alloc] initWithName:@"machine" andDescription:@"plastic moulding machine" andWeight:100 andVolume:50 andCost:nil andSubItem:nil]];
    [factorySection4 addItem:[[Item alloc] initWithName:@"bin" andDescription:@"for recycling plastic trimmings" andWeight:100 andVolume:50 andCost:nil andSubItem:nil]];
    [factorySection4 addItem:[[Item alloc] initWithName:@"blade" andDescription:@"box-blade™   \"for cutting boxes\"" andWeight:2 andVolume:4 andCost:8 andSubItem:nil]];
    [factorySection4 addItem:[[Item alloc] initWithName:@"beads" andDescription:@"a barrel of plastic beads" andWeight:100 andVolume:50 andCost:nil andSubItem:nil]];
    
    [factorySection5 addItem:[[Item alloc] initWithName:@"forklift" andDescription:@"oh you want to drive this?" andWeight:100 andVolume:50 andCost:nil andSubItem:nil]];
    [factorySection5 addItem:[[Item alloc] initWithName:@"shelves" andDescription:@"rows of shelves stacked with boxes" andWeight:100 andVolume:50 andCost:nil andSubItem:nil]];
    [factorySection5 addItem:[[Item alloc] initWithName:@"note" andDescription:@"jim, i got chinese for lunch. it's in the fridge" andWeight:1 andVolume:1 andCost:nil andSubItem:nil]];
}

-(void)createCombies {
    combieCounter++;
    
    NSSet *theRooms = [NSSet setWithArray:combieRoomArray];
    Room *room = [theRooms anyObject];
    Combie *combie = [[Combie alloc] initWithRoom:room andTimer:nil];
    
    [room addCombie:combie];
    
    NSLog(@"combie created %@", [room tag]);
    
    [combieRoomArray removeObject:room];
    
    if (combieCounter == 7) {
        [combieCreator invalidate];
        
        combieCounter = 0;
    }
}


-(void)start {
    [player outputMessage:[self begin]];
    
    playing = YES;
}

-(void)killed:(NSNotification *)notification {
    [player outputMessage:@"\n\n\nyou died too many times."];
    [player outputMessage:[self finish]];
    
    playing = NO;
}

-(void)end {
    NSLog(@"attempting to end");
    if (obtainedMedicalFile && !combiesKilled) {
        [player outputMessage:@"\nyou must kill all combies in order to warp to the roof."];
    } else if (!obtainedMedicalFile && combiesKilled) {
        [player outputMessage:@"\nyou must retrieve the medical file in order to warp to the roof."];
    } else if (!obtainedMedicalFile && !combiesKilled && [player currentRoom] == warpRoom) {
        [player outputMessage:@"\nyou must retrieve the medical file and kill all combies in order to warp to the roof."];
    } else if (obtainedMedicalFile && combiesKilled) {
        NSLog(@"attempting to end");
        [self win];
        playing = NO;
    } else {
        NSLog(@"attempting to end");
        [player outputMessage:[self finish]];
        playing = NO;
    }
}

-(BOOL)execute:(NSString *)commandString {
	BOOL finished = NO;
    
    if (playing) {
        [player commandMessage:[NSString stringWithFormat:@"\n ∫ %@",commandString]];
        
        Command *command = [parser parseCommand:commandString];
        
        if (command) {
            finished = [command execute:player];
        } else {
            [player errorMessage:@"\nimproper command format"];
        }
    }
    
    return finished;
}

-(NSString *)begin {
	NSString *message = @"welcome to zall of duty: combies\n\nto refresh, your mission is to clear the factory of combies and retrieve a medical file in the development room. you have a knife in your possession\n";
    
	return [NSString stringWithFormat:@"%@\n%@", message, [player currentRoom]];
}

-(NSString *)finish {
    return @"\nplay again when you aren't such a pansy";
}

-(void)allCombiesKilled:(NSNotification *)notification {
    combiesKilled = YES;
}

-(void)medicalFileObtained:(NSNotification *)notification {
    obtainedMedicalFile = YES;
}

-(void)warpToRoof:(NSNotification *)notification {
    [self end];
}

-(void)win {
    [player outputMessage:@"\n\n~*^ congratulations ^*~\n\nyou won the game. good job i guess."];
}

-(void)dealloc {
    [rooms release];
	[parser release];
	[player release];
    [lobby release];
    [cafeteria release];
    [meetingRoom release];
    [lockerRoom release];
    [developmentRoom release];
    [warpRoom release];
    [factorySection1 release];
    [factorySection2 release];
    [factorySection3 release];
    [factorySection4 release];
    [factorySection5 release];
	
	[super dealloc];
}

@end