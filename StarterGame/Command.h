//  ***
//
//  Command.h
//  StarterGame
//
//  Created by Savannah Sosa and Aaron Chapman on 5/2/15.
//  Copyright (c) 2015 All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Player.h"

@class Player;

@interface Command : NSObject {
    NSString *name;
    NSString *secondWord;
}

@property (readonly, nonatomic)NSString *name;
@property (retain, nonatomic)NSString *secondWord;

-(id)init;
-(BOOL)hasSecondWord;
-(BOOL)execute:(Player *)player;

@end