//
//  Inventory.m
//  StarterGame
//
//  Created by Savannah Sosa and Aaron Chapman on 5/2/15.
//  Copyright (c) 2015 All rights reserved.
//

#import "Inventory.h"

@implementation Inventory

@synthesize items;

-(id)init {
    return [self initWithItems:items];
}

-(id)initWithItems:(NSMutableDictionary *)theItems {
    self = [super init];
    
    if (nil != self) {
        items = [[NSMutableDictionary alloc] initWithCapacity:30];
    }
    
    return self;
}

-(void)addItem:(Item *)item {
    [items setObject:[item retain] forKey:[item itemName]];
}

-(void)removeItem:(Item *)item {
    [items removeObjectForKey:[item itemName]];
}

-(NSMutableDictionary *)getItems {
    return items;
}

-(NSString *)description {
    NSArray *itemNames = [items allKeys];
    
    return [NSString stringWithFormat:@"\nitems: %@", [itemNames componentsJoinedByString:@", "]];
}

-(void)dealloc {
    [items release];
    
    [super dealloc];
}

@end