//
//  SomeString.h
//  CustomModule
//
//  Created by Minh Chien on 3/23/18.
//  Copyright © 2018 Facebook. All rights reserved.
//

#import <React/RCTBridgeModule.h>
#import <React/RCTEventEmitter.h>

/**
 * Basic native module without support emit event, we just need NSObject<RCTBridgeModule>
 * othercase we need RCTEventEmitter<RCTBridgeModule>
 */
@interface SomeString: RCTEventEmitter<RCTBridgeModule>

@end
