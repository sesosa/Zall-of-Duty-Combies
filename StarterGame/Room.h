//  ***
//
//  Room.h
//  StarterGame
//
//  Created by Savannah Sosa and Aaron Chapman on 5/2/15.
//  Copyright (c) 2015 All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Item.h"
#import "Combie.h"

@class Combie;

@interface Room : NSObject {
	NSMutableDictionary *exits, *roomItems;
    NSMutableArray *roomCombies;
    BOOL locked;
}

@property (retain, nonatomic)NSString *tag;
@property (retain, nonatomic)NSMutableDictionary *roomItems;

-(id)init;
-(id)initWithTag:(NSString *)newTag locked:(BOOL)lockState;
-(void)setExit:(NSString *)exit toRoom:(Room *)room;
-(void)addItem:(Item *)item;
-(void)addCombie:(Combie *)combie;
-(void)removeCombie;
-(BOOL)hasCombie;
-(BOOL)locked;
-(Combie *)getCombie;
-(Room *)getExit:(NSString *)exit;
-(Room *)randomFactorySection:(NSArray *)roomArray;
-(NSString *)getExits;
-(NSString *)getRoomItems;
-(NSMutableDictionary *)getExitArray;

@end