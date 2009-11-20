#import <Foundation/Foundation.h>
#import <CoreFoundation/CoreFoundation.h>
#import <CoreServices/CoreServices.h>

#import <IOBluetooth/objc/IOBluetoothDeviceInquiry.h>
#import <IOBluetooth/IOBluetoothUserLib.h>
#import <IOBluetoothUI/IOBluetoothUIUserLib.h>


#include "BluetoothInquiryDelegate.h"
#include "PBBluetoothParams.h"

int main (int argc, const char * argv[]) {
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	
	[PBBluetoothParams parseParams:(char**)argv withCount:argc];
   
	NSCondition *inquiryFinished = [[NSCondition alloc] init];
	[inquiryFinished retain];
	
	BluetoothInquiryDelegate *inquiryDelegate = [[BluetoothInquiryDelegate alloc] initWithCondition:inquiryFinished];
	[inquiryDelegate retain];
	
	IOBluetoothDeviceInquiry* inquiry = [IOBluetoothDeviceInquiry inquiryWithDelegate:inquiryDelegate]; 
	[inquiry start];
	
	CFRunLoopRun();
	
	// wait for bluetooth inquiry to finish
	[inquiryFinished lock];
	while([inquiryDelegate running]) 
		[inquiryFinished wait];
	
	[inquiryFinished unlock];
		
	[pool release];
    return 0;
}
