/* 
 ofSerialImpl.cpp - ofSerialImpl library
 Copyright (c) 2012 Copenhagen Institute of Interaction Design. 
 All right reserved.
 
 This library is free software: you can redistribute it and/or modify
 it under the terms of the GNU Lesser Public License as published by
 the Free Software Foundation, either version 3 of the License, or
 (at your option) any later version.
 
 This library is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU Lesser Public License for more details.
 
 You should have received a copy of the GNU Lesser Public License
 along with Foobar.  If not, see <http://www.gnu.org/licenses/>.
 
 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 + author: dviid + yufan
 + contact: dviid@labs.ciid.dk + w.yufan@edu.ciid.dk
 */

#import "redparkSerialListener.h"
#import "ofSerialImpl.h"

////////////////////////////////////////////////////////////////////////////////
////////////////////--- redparkSerialListerner implitation ---//////////////////
////////////////////////////////////////////////////////////////////////////////

@implementation redparkSerialListener
@synthesize rscMgr;
@synthesize cable_connected;

// init readpark manager
-(id) init
{
    self = [super init];
    rscMgr = [[RscMgr alloc] init];
    [rscMgr setDelegate:self];
    return self;
}

#pragma mark - RscMgrDelegate methods///////////////////////////////////////////
- (void) cableConnected:(NSString *)protocol
{
    NSLog(@"Cable Connected: %@", protocol);
    cable_connected = TRUE;
}

// Redpark Serial Cable was disconnected and/or application moved to background
- (void) cableDisconnected
{
    NSLog(@"Cable disconnected");
    cable_connected = FALSE;
}

// serial port status has changed
// user can call getModemStatus or getPortStatus to get current state
- (void) portStatusChanged
{
    NSLog(@"portStatusChanged");
}

// bytes are available to be read (user calls read:)
- (void) readBytesAvailable:(UInt32)length
{
    return;
}


////////////////////////////////////////////////////////////////////////////////
/////////////////////--- ofSerialImpl implitation ---///////////////////////////
////////////////////////////////////////////////////////////////////////////////

ofSerialImpl::ofSerialImpl(void) : _initialised(false)
{
    self = [[redparkSerialListener alloc] init];
}

ofSerialImpl::~ofSerialImpl(void)
{
    [(id)self dealloc];
}

bool ofSerialImpl::setup(int baud)
{
    [[(id)self rscMgr] setBaud:baud];
    _initialised = true;
    
    if([(id)self cable_connected])
    {
        [[(id)self rscMgr] open];
    }
        
    return true;
}

int ofSerialImpl::read(unsigned char* buffer, int length)
{
    return [[(id)self rscMgr] read:buffer Length:length];
}

int ofSerialImpl::write(unsigned char* buffer, int length)
{
    return [[(id)self rscMgr] write:buffer Length:length];
}

int ofSerialImpl::available()
{
    return [[(id)self rscMgr] getReadBytesAvailable];
}

void ofSerialImpl::flush(bool flushIn, bool flushOut)
{
    serialPortControl* ctrl;
    ctrl->rxFlush = (flushIn ? 1 : 0);
    ctrl->txFlush = (flushOut ? 1 : 0);
    [[(id)self rscMgr] setPortControl: ctrl:FALSE];
}

bool ofSerialImpl::connected()
{
    return [(id)self cable_connected];
}

bool ofSerialImpl::initialised()
{
    return _initialised;
}

@end




