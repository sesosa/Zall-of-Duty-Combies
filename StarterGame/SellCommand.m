//
//  SellCommand.m
//  StarterGame
//
//  Created by Savannah Sosa and Aaron Chapman on 5/2/15.
//  Copyright (c) 2015 All rights reserved.
//

#import "SellCommand.h"

@implementation SellCommand

-(id)init {
    self = [super init];
    
    if (nil != self) {
        name = @"sell";
    }
    
    return self;
}

-(BOOL)execute:(Player *)player {
    if ([player developmentRoomKeyObtained] && [[[player currentRoom] tag] isEqualToString:@"in the development room"])
        if ([self hasSecondWord])
            [player sellItem:secondWord];
        else
            [player warningMessage:@"\nimproper command format"];
    else
        [player warningMessage:@"you need to be in the development room for that"];
    
    return NO;
}

@end