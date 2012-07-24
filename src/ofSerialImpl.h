/* 
 ofSerialImpl.h - ofSerialImpl library
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

#pragma once

class ofSerialImpl
{
public:
    ofSerialImpl(void);
    ~ofSerialImpl(void);
    
    bool setup(int baud = 9600);
    
    int read(unsigned char* buffer, int length);
    int write(unsigned char* buffer, int length);
    
    int available();
    void flush(bool flushIn = true, bool flushOut = true);
    
    bool connected();
    bool initialised();    
    
private:
    void* self;
    bool _initialised;
    bool _connected;
};
