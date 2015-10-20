//  ***
//
//  CommandWords.h
//  StarterGame
//
//  Created by Savannah Sosa and Aaron Chapman on 5/2/15.
//  Copyright (c) 2015 All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Command.h"

@class Command;

@interface CommandWords : NSObject {
	NSMutableDictionary *commands;
}

-(id)init;
-(id)initFromList:(NSString *)commandList;
-(Command *)get:(NSString *)word;
-(NSString *)descriptionWith;
-(NSString *)descriptionWithout:(NSString *)room and:(NSString *)otherRoom and:(NSString *)thirdRoom;

@end