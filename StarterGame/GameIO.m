//  ***
//
//  GameIO.m
//  StarterGame
//
//  Created by Savannah Sosa and Aaron Chapman on 5/2/15.
//  Copyright (c) 2015 All rights reserved.
//

#import "GameIO.h"

@implementation GameIO

@synthesize currentColor;

-(id)initWithOutput:(NSTextView *)theOutput {
    self = [super init];
    
    if (nil != self) {
        [theOutput setBackgroundColor:[NSColor blackColor]];
        output = theOutput;
        
        [self setCurrentColor:[NSColor greenColor]];
        [self clear];
    }
    
    return self;
}

-(void)sendLines:(NSString *)input {
    NSInteger start = [[output string] length];
    
    [[output textStorage] appendAttributedString:[[NSAttributedString alloc] initWithString: input]];
    
    NSInteger end = [[output string] length];
    
    [output setTextColor:[self currentColor] range:NSMakeRange(start, end - start)];
    [output scrollRangeToVisible:NSMakeRange([[output string] length], 0)];
}

-(void)clear {
    [output setString:@""];
    [output setTextColor:[self currentColor]];
}

-(void)dealloc {
    [super dealloc];
}

@end