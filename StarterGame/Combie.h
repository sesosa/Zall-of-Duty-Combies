//
//  Combie.h
//  StarterGame
//
//  Created by Savannah Sosa and Aaron Chapman on 5/2/15.
//  Copyright (c) 2015 All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Room.h"

@class Combie;
@class Room;

@protocol CombieDelegate <NSObject>

-(void)attackPlayer;

@end

@interface Combie : NSObject {
    NSTimer* combieTimer;
    Room *combieRoom, *currentPlayerRoom;
    
    id <CombieDelegate> delegate;
    
    int health, moveCombieCounter;
}

@property (nonatomic, assign) id <CombieDelegate> delegate;

-(NSTimer *)getTimer;

-(id)init;
-(id)initWithRoom:(Room *)room andTimer:(NSTimer *)timer;

-(int)getHealth;

-(void)setHealth:(int) newHealth;
-(void)setTimer:(NSTimer *)newTimer;
-(void)resetTimer;
-(void)updatePlayerRoom:(NSNotification *)notification;
-(void)endOfCombieTimer:(NSTimer *)timer;
-(void)takeDamage:(int)damage;
-(void)setRoom:(Room *)newRoom;
-(void)moveCombie;
-(void)die;

@end



