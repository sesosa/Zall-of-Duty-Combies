
//  ***
//
//  AppDelegate.h
//  StarterGame
//
//  Created by Savannah Sosa and Aaron Chapman on 5/2/15.
//  Copyright (c) 2015 All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "GameIO.h"
#import "Game.h"
#import <AVFoundation/AVFoundation.h>

@interface AppDelegate : NSObject <NSApplicationDelegate, AVAudioPlayerDelegate> {
    GameIO *gameIO;
    Game *game;
    
    AVAudioPlayer *player;
}

@property (assign) IBOutlet NSTextField *command;
@property (assign) IBOutlet NSTextView *output;
@property (assign) IBOutlet NSWindow *window;
@property (nonatomic, retain) AVAudioPlayer *player;

- (IBAction)receiveCommandFrom:(id)sender;

@end