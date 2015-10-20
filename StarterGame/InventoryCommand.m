//  ***
//
//  InventoryCommand.m
//  StarterGame
//
//  Created by Savannah Sosa and Aaron Chapman on 5/2/15.
//  Copyright (c) 2015 All rights reserved.
//

#import "InventoryCommand.h"

@implementation InventoryCommand

-(id)init {
    self = [super init];
    
    if (nil != self) {        
        name = @"inventory";
    }
    
    return self;
}

-(BOOL)execute:(Player *)player {
    if ([self hasSecondWord]) {
        [player errorMessage:@"\nimproper command format"];
    } else {
        [player outputMessage:[[player inventory] description]];
    }
    
    return NO;
}

@end