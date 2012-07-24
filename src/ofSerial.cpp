/* 
 ofSerial.cpp - ofSerial library
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

#include "ofSerial.h"
#include "ofSerialImpl.h"

ofSerialImpl *_impl = NULL; // only one (static) redpark serial port
int cnt = 0;

ofSerial::ofSerial()
{
    if(!_impl) _impl = new ofSerialImpl();
    cnt++;
}

ofSerial::~ofSerial()
{
    if(--cnt == 0 && _impl) {
        delete _impl;
        _impl = NULL;
    }
}

void ofSerial::listDevices(){;}

vector <ofSerialDeviceInfo> ofSerial::getDeviceList(){;}

void ofSerial::close() {;}


bool ofSerial::setup()
{
    if(_impl) _impl->setup();
}


bool ofSerial::setup(string portName, int baudrate)
{
    // add output comments
    if(_impl) _impl->setup(baudrate);
}


bool ofSerial::setup(int deviceNumber, int baudrate)
{
    // add output comments
    if(_impl) return _impl->setup(baudrate);
}


int ofSerial::readBytes(unsigned char * buffer, int length)
{
    if(_impl) return _impl->read(buffer, length);
}


int ofSerial::writeBytes(unsigned char * buffer, int length)
{
    if(_impl) return _impl->write(buffer, length);
}


bool ofSerial::writeByte(unsigned char singleByte)
{
    if(_impl) return (_impl->read(&singleByte, 1) == 1);
}


int ofSerial::readByte()
{  // returns -1 on no read or error...
    unsigned char singleByte;
    if(_impl) {
        _impl->read(&singleByte, 1);
        return singleByte;
    }
    else return -1;
}

void ofSerial::flush(bool flushIn, bool flushOut)
{
    if(_impl) return _impl->flush(flushIn, flushOut);
}


int ofSerial::available()
{
    if(_impl) return _impl->available();
}

void ofSerial::drain() {;}
