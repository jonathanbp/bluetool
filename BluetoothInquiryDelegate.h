//
//  BluetoothInquiryDelegate.h
//  bluetool
//
//  Created by Jonathan Bunde-Pedersen on 30/03/09.
//  Copyright 2009 PureBadger. All rights reserved.
//

#include <Foundation/Foundation.h>
#include <CoreFoundation/CoreFoundation.h>
#include <CoreServices/CoreServices.h>

#include <IOBluetooth/objc/IOBluetoothDeviceInquiry.h>
#include <IOBluetooth/IOBluetoothUserLib.h>
#include <IOBluetoothUI/IOBluetoothUIUserLib.h>
#include <IOBluetooth/objc/IOBluetoothDevice.h>


@interface BluetoothInquiryDelegate : NSObject {
	BOOL running;
	NSCondition *inquiryCondition;
}

@property (assign) BOOL running;

- (id) initWithCondition:(NSCondition*)condition;

- (void) deviceInquiryComplete:(IOBluetoothDeviceInquiry*)sender error:(IOReturn)error aborted:(BOOL)aborted; 

- (void) deviceInquiryDeviceFound:(IOBluetoothDeviceInquiry*)sender device:(IOBluetoothDevice*)device;

- (void) deviceInquiryDeviceNameUpdated:(IOBluetoothDeviceInquiry*)sender device:(IOBluetoothDevice*)device devicesRemaining:(uint32_t)devicesRemaining; 

- (void) deviceInquiryStarted:(IOBluetoothDeviceInquiry*)sender; 

- (void) deviceInquiryUpdatingDeviceNamesStarted:(IOBluetoothDeviceInquiry*)sender devicesRemaining:(uint32_t)devicesRemaining; 

@end
