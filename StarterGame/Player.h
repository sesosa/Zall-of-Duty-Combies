//  ***
//
//  Player.h
//  StarterGame
//
//  Created by Savannah Sosa and Aaron Chapman on 5/2/15.
//  Copyright (c) 2015 All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Room.h"
#import "GameIO.h"
#import "Game.h"
#import "Inventory.h"
#import "Item.h"
#import "Combie.h"

@class Inventory;
@class Game;

@interface Player : NSObject <CombieDelegate> {
    Inventory *inventory;
    Item *playerWeapon;
    NSMutableArray *roomOrder;
    Game *game;
    NSTimer *newTimer;
    
    int weightAvailable, volumeAvailable, credits, lifeCount, combiesKilled;
    BOOL scancardObtained, meetingRoomKeyObtained, developmentRoomKeyObtained, warpRoomKeyObtained, medicalFileObtained;
}

@property (retain, nonatomic)Room *currentRoom;
@property (retain, nonatomic)Inventory *inventory;
@property (retain, nonatomic)Item *playerWeapon;
@property (retain, nonatomic)GameIO *io;

-(Item *)getWeapon;
-(id)init;
-(id)initWithRoom:(Room *)room andIO:(GameIO *)theIO;
-(BOOL)warpRoomKeyObtained;
-(BOOL)developmentRoomKeyObtained;
-(void)walkTo:(NSString *)direction;
-(void)warpTo:(NSString *)room;
-(void)attack:(NSString *)roomCombie;
-(void)attackPlayer;
-(void)respawn;
-(void)moveAndPrint:(Room *)room;
-(void)checkForCombies:(Room *)room;
-(void)goBack;
-(void)takeItem:(NSString *)itemName;
-(void)dropItem:(NSString *)itemName;
-(void)searchItem:(NSString *)itemName;
-(void)sellItem:(NSString *)itemName;
-(void)buyItem:(NSString *)itemName;
-(void)outputMessage:(NSString *)message;
-(void)outputMessage:(NSString *)message withColor:(NSColor *)color;
-(void)warningMessage:(NSString *)message;
-(void)errorMessage:(NSString *)message;
-(void)commandMessage:(NSString *)message;
-(void)setCurrentRoom:(Room *)room;
-(void)setWeapon:(Item *)weapon;
-(void)checkIfRoomIsLockedAndSortAccordingly:(Room *)room;

@end