//
//  Item.m
//  StarterGame
//
//  Created by Savannah Sosa and Aaron Chapman on 5/2/15.
//  Copyright (c) 2015 All rights reserved.
//

#import "Item.h"

@implementation Item

-(id)init {
    return [self initWithName:@"Item Name" andDescription:@"Item Description" andWeight:0 andVolume:0 andCost:0 andSubItem:nil];
}

-(id)initWithName:(NSString *)name andDescription:(NSString *)description andWeight:(int)weight andVolume:(int)volume andCost:(int)cost andSubItem:(Item *)item {
    self = [super init];
    
    if (nil != self) {
        itemName = name;
        itemDescription = description;
        itemWeight = weight;
        itemVolume = volume;
        itemCost = cost;
        subItem = item;
        attackPower = nil;
    }
    
    return self;
}

-(NSString *)itemName {
    return itemName;
}

-(NSString *)itemDescription {
    return itemDescription;
}

-(Item *)subItem {
    return subItem;
}

-(BOOL)hasSubItem {
    if (subItem != nil)
        return YES;
    else
        return NO;
}

-(int)itemWeight {
    return itemWeight;
}

-(int)itemVolume {
    return itemVolume;
}

-(int)itemCost {
    return itemCost;
}

@end