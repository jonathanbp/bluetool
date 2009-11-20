//
//  BluetoothInquiryDelegate.m
//  bluetool
//
//  Created by Jonathan Bunde-Pedersen on 30/03/09.
//  Copyright 2009 PureBadger. All rights reserved.
//

#import "BluetoothInquiryDelegate.h"


@implementation BluetoothInquiryDelegate

@synthesize running;

- (id) initWithCondition:(NSCondition*) condition {
	inquiryCondition = condition;
	return self;
}

- (void) deviceInquiryComplete:(IOBluetoothDeviceInquiry*)sender error:(IOReturn)error aborted:(BOOL)aborted {
	NSLog(@"deviceInquiryComplete");
	[inquiryCondition lock];
	self.running = NO;
	[inquiryCondition signal];
	[inquiryCondition unlock];
	CFRunLoopStop( CFRunLoopGetCurrent() );
}

- (void) deviceInquiryDeviceFound:(IOBluetoothDeviceInquiry*)sender device:(IOBluetoothDevice*)device {
	NSLog(@"deviceInquiryDeviceFound - %@ (%@)", [device getNameOrAddress], [device getAddressString]);
}

- (void) deviceInquiryDeviceNameUpdated:(IOBluetoothDeviceInquiry*)sender device:(IOBluetoothDevice*)device devicesRemaining:(uint32_t)devicesRemaining {
	NSLog(@"deviceInquiryDeviceNameUpdated - %@ (%@)", [device getName], [device getAddressString]);
	
}

- (void) deviceInquiryStarted:(IOBluetoothDeviceInquiry*)sender {
	self.running = YES;
	NSLog(@"deviceInquiryStarted");
}

- (void) deviceInquiryUpdatingDeviceNamesStarted:(IOBluetoothDeviceInquiry*)sender devicesRemaining:(uint32_t)devicesRemaining {
	NSLog(@"deviceInquiryUpdatingDeviceNamesStarted");
}

@end
