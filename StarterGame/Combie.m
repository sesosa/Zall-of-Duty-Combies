//
//  Combie.m
//  StarterGame
//
//  Created by Savannah Sosa and Aaron Chapman on 5/2/15.
//  Copyright (c) 2015 All rights reserved.
//

#import "Combie.h"

@implementation Combie

@synthesize delegate;

-(id)init {
    return [self initWithRoom:nil andTimer:nil];
}

-(id)initWithRoom:(Room *)room andTimer:(NSTimer *)timer {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updatePlayerRoom:) name:@"playerDidEnterRoom" object:nil];
    
    self = [super init];
    
    if (nil != self) {
        combieRoom = room;
        combieTimer = timer;
        health = 5;
    }
    
    return self;
}

-(NSTimer *)getTimer {
    return combieTimer;
}

-(void)setTimer:(NSTimer *)newTimer {
    combieTimer = newTimer;
}

-(void)resetTimer {
    int lowerBound = 20;
    int upperBound = 30;
    int rndValue = lowerBound + arc4random() % (upperBound - lowerBound);
    
    NSTimer *resetTimer = [NSTimer scheduledTimerWithTimeInterval:rndValue target:self selector:@selector(endOfCombieTimer:) userInfo:nil repeats:YES];
    
    [self setTimer:resetTimer];
}

-(void)updatePlayerRoom:(NSNotification *)notification {
    currentPlayerRoom = [notification object];
}

-(void)endOfCombieTimer:(NSTimer *)timer {
    if ([currentPlayerRoom tag] == [combieRoom tag]) {
        [delegate performSelector:@selector(attackPlayer)];
        
        [combieTimer invalidate];
    } else {
        [self moveCombie];
        
        [combieTimer invalidate]; 
    }
}

-(int)getHealth {
    return health;
}

-(void)setHealth:(int) newHealth {
    health = newHealth;
}

-(void)takeDamage:(int)damage {
    health = [self getHealth] - damage;
}

-(void)setRoom:(Room *)newRoom {
    combieRoom = newRoom;
}

-(void)moveCombie {
    if (moveCombieCounter == 4)
        NSLog(@"too many combies to move");
    else {
        NSMutableDictionary *dictionary = [combieRoom getExitArray];
        NSArray *array = [dictionary allKeys];
        
        int random = arc4random() % [array count];
        
        NSString *key = [array objectAtIndex:random];
        Room *newRoom = [combieRoom getExit:key];
        
        if ([newRoom hasCombie]) {
            [self moveCombie];
            
            moveCombieCounter++;
        } else {
            [combieRoom removeCombie];
            
            [self setRoom:newRoom];
            
            [newRoom addCombie:self];
        }
    }
}

-(void)die {
    [self dealloc];
}

@end