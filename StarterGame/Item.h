//
//  Item.h
//  StarterGame
//
//  Created by Savannah Sosa and Aaron Chapman on 5/2/15.
//  Copyright (c) 2015 All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Item : NSObject {
    NSString *itemName, *itemDescription;
    Item *subItem;
    
    int itemWeight, itemVolume, itemCost, attackPower;
}

-(id)init;
-(id)initWithName:(NSString *)name andDescription:(NSString *)description andWeight:(int)weight andVolume:(int)volume andCost:(int)cost andSubItem:(Item *)subItem;
-(NSString *)itemName;
-(NSString *)itemDescription;
-(Item *)subItem;
-(int)itemWeight;
-(int)itemVolume;
-(int)itemCost;
-(BOOL)hasSubItem;

@end