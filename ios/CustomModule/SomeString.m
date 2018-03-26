//
//  SomeString.m
//  CustomModule
//
//  Created by Minh Chien on 3/23/18.
//  Copyright © 2018 Facebook. All rights reserved.
//

#import "SomeString.h"
#import <React/RCTConvert.h>
//#import "RCTEventEmitter.h"

@implementation SomeString {
  BOOL hasListeners;
}


RCT_EXPORT_MODULE();

RCT_EXPORT_METHOD(hello:
                  (NSString *)name
                  callback:(RCTResponseSenderBlock) callback) {
  NSString *helloString = [NSString stringWithFormat:@"Hi %@, This message from native", name];
  callback(@[helloString]);
}

RCT_REMAP_METHOD(isString,
                 value:(NSString *)value
                 resolve:(RCTPromiseResolveBlock)resolve
                 reject:(RCTPromiseRejectBlock)reject) {
  @try {
    NSScanner *scanner = [NSScanner scannerWithString:value];
    BOOL isNumeric = [scanner scanInteger:NULL] && [scanner isAtEnd];
    if(isNumeric == YES) {
      NSString *err = [NSString stringWithFormat:@" '%@', This is not string.", value];
      @throw [NSException exceptionWithName:@"SignalException" reason:err userInfo:nil];
    }
    NSString *data = [NSString stringWithFormat:@" '%@', This is string.", value];
    resolve(data);
  }@catch(NSException *exception) {
    NSMutableDictionary *info = [NSMutableDictionary dictionary];
    [info setValue:exception.name forKey:@"ExceptionName"];
    [info setValue:exception.reason forKey:@"ExceptionReason"];
    [info setValue:exception.callStackReturnAddresses forKey:@"ExceptionCallStackReturnAddresses"];
    [info setValue:exception.callStackSymbols forKey:@"ExceptionCallStackSymbols"];
    [info setValue:exception.userInfo forKey:@"ExceptionUserInfo"];
    
    NSError *error = [[NSError alloc] initWithDomain:@"com.example.myApp" code:4 userInfo:info];
    reject([info valueForKey:@"ExceptionName"], [info valueForKey:@"ExceptionReason"], error);
  }
}

@end
