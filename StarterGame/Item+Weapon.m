//
//  Item+Weapon.m
//  StarterGame
//
//  Created by Savannah Sosa and Aaron Chapman on 5/2/15.
//  Copyright (c) 2015 All rights reserved.
//

#import "Item+Weapon.h"

@implementation Item (Weapon)

-(int)getAttack {
    return attackPower;
}

-(void)setAttack:(int)attack {
    attackPower = attack;
}

@end
