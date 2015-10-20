//  ***
//
//  DropCommand.m
//  StarterGame
//
//  Created by Savannah Sosa and Aaron Chapman on 5/2/15.
//  Copyright (c) 2015 All rights reserved.
//

#import "WarpCommand.h"

@implementation WarpCommand

-(id)init {
    self = [super init];
    
    if (nil != self) {
        name = @"warp";
    }
    
    return self;
}

-(BOOL)execute:(Player *)player {
    if ([player warpRoomKeyObtained] && [[[player currentRoom] tag] isEqualToString:@"in the warp room"]) {
        if ([self hasSecondWord]) {
            [player warpTo:secondWord];
        } else {
            [player warningMessage:@"\nthat is not an option"];
        }
    } else
        [player warningMessage:@"\nyou need to be in the warp room"];
    
    return NO;
}

@end