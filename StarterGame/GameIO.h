//  ***
//
//  GameIO.h
//  StarterGame
//
//  Created by Savannah Sosa and Aaron Chapman on 5/2/15.
//  Copyright (c) 2015 All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameIO : NSObject{
    NSTextView *output;
    NSColor *currentColor;
}

@property (retain, nonatomic)NSColor *currentColor;

-(id)initWithOutput:(NSTextView *)theOutput;
-(void)sendLines:(NSString *)input;
-(void)clear;

@end