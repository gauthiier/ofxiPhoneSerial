//
//  serialListener.m
//  emptyExample
//
//  Created by Wang Yufan on 7/21/12.
//  Copyright (c) 2012 CIID. All rights reserved.
//

#import "serialListener.h"
//#import "MyViewController.h"


@implementation serialListener

@synthesize rscMgr;
@synthesize delegate;
@synthesize serialCommand;

-(id) init{
    self = [super init];
    rscMgr = [[RscMgr alloc] init];
    [rscMgr setDelegate:self];
    serialCommand = [[NSMutableString alloc] initWithString:@""];
    return self;
}

-(void) processCommand{
    NSString *ss = [[NSString alloc] initWithString:[self.serialCommand stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]]];
    [self.serialCommand setString: @""];
    [[self delegate] newMessageAvailable:ss];
    
} 


#pragma mark - RscMgrDelegate methods


- (void) cableConnected:(NSString *)protocol {
    NSLog(@"Cable Connected: %@", protocol);
    [rscMgr setBaud:9600];
	[rscMgr open];    
    
}


- (void) cableDisconnected {
    NSLog(@"Cable disconnected");
	
}


- (void) portStatusChanged {
    NSLog(@"portStatusChanged");
    
}

// bytes are available to be read (user calls read:)
- (void) readBytesAvailable:(UInt32)length{
    
    UInt8 newBuffer[BUFFER_LEN];
    //newBuffer is pointer and gets populated by rscMgr
    int bytesRead = [rscMgr read:newBuffer Length:length];
    NSString *newCommand = [[NSString alloc] initWithBytes:(char*)newBuffer length:length encoding:NSASCIIStringEncoding];
    [self.serialCommand appendString:newCommand];
    
    if([self.serialCommand hasSuffix:@"\n"]){
        [self processCommand];
    }
    
}



- (BOOL) rscMessageReceived:(UInt8 *)msg TotalLength:(int)len {
    NSLog(@"rscMessageRecieved:TotalLength:");
    return FALSE;    
}

- (void) didReceivePortConfig {
    NSLog(@"didRecievePortConfig");
}


@end
