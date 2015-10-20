//
//  AppDelegate.m
//  StarterGame
//
//  Created by Savannah Sosa and Aaron Chapman on 5/2/15.
//  Copyright (c) 2015 All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

@synthesize command, output, player;

-(void)dealloc {
    [gameIO release];
    [game release];
    
    [super dealloc];
}

-(void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    gameIO = [[GameIO alloc] initWithOutput:output];
    game = [[Game alloc] initWithGameIO:gameIO];
    
    player = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"ZODCTheme" ofType:@"wav"]] error:NULL];
    player.numberOfLoops = -1;
    player.volume = 0.35;
    [player prepareToPlay];
    [player play];
    
    [game start];
}

-(IBAction)receiveCommandFrom:(id)sender {
    if ([game execute: [sender stringValue]]) {
        [game end];
    }
    
    [sender setStringValue:@""];
}

@end