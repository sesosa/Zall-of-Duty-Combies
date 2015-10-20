//
//  Inventory.h
//  StarterGame
//
//  Created by Savannah Sosa and Aaron Chapman on 5/2/15.
//  Copyright (c) 2015 All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Item.h"
#import "Game.h"

@interface Inventory : NSObject {
    NSMutableDictionary *items;
}

@property (nonatomic, retain)NSMutableDictionary *items;

-(id)init;
-(id)initWithItems:(NSMutableDictionary *)items;
-(void)addItem:(Item *)item;
-(void)removeItem:(Item *)item;
-(NSMutableDictionary *)getItems;

@end