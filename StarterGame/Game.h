//  ***
//
//  Game.h
//  StarterGame
//
//  Created by Savannah Sosa and Aaron Chapman on 5/2/15.
//  Copyright (c) 2015 All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Parser.h"
#import "Player.h"
#import "GameIO.h"
#import "Item.h"
#import "Item+Weapon.h"

@class Player;
@class Parser;
@class Room;

@interface Game : NSObject {
    int combieCounter;
    BOOL playing, combiesKilled, obtainedMedicalFile;
    NSTimer *combieCreator;
    NSMutableArray *rooms, *combieRoomArray;
    Room *lobby, *cafeteria, *meetingRoom, *lockerRoom, *developmentRoom, *warpRoom, *factorySection1, *factorySection2, *factorySection3, *factorySection4, *factorySection5;
}

@property (retain, nonatomic)Parser *parser;
@property (retain, nonatomic)Player *player;
@property (retain, nonatomic)NSMutableArray *rooms, *combieRoomArray;
@property (retain, nonatomic)Room *lobby, *cafeteria, *meetingRoom, *lockerRoom, *developmentRoom, *warpRoom, *factorySection1, *factorySection2, *factorySection3, *factorySection4, *factorySection5;

-(id)initWithGameIO:(GameIO *)theIO;
-(Room *)createWorld;
-(void)createItems;
-(void)createCombies;
-(void)start;
-(void)killed:(NSNotification *)notification;
-(void)end;
-(BOOL)execute:(NSString *)commandString;
-(NSString *)begin;
-(NSString *)finish;
-(void)allCombiesKilled:(NSNotification *)notification;
-(void)medicalFileObtained:(NSNotification *)notification;
-(void)warpToRoof:(NSNotification *)notification;
-(void)win; 

@end