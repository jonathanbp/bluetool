//
//  PBBluetoothParams.h
//  bluetool
//
//  Created by Jonathan Bunde-Pedersen on 30/03/09.
//  Copyright 2009 PureBadger. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "PBParams.h"


@interface PBBluetoothParams : NSObject {

}

+ (void) initParams:(struct params *)params;

+ (void) executeParams:(struct params *)fsm withString:(const char *)data andLength:(int) len;

+ (int) finishParams:(struct params *)fsm;

+ (PBParams *) parseParams:(char**) argv withCount:(int)argc;

@end
