//
//  SomeString.m
//  CustomModule
//
//  Created by Minh Chien on 3/23/18.
//  Copyright © 2018 Facebook. All rights reserved.
//

#import "SomeString.h"
#import <React/RCTConvert.h>

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

RCT_EXPORT_METHOD(getInfo:
                  (NSString *)name
                  qty:(nonnull NSNumber *)qty
                  price:(nonnull NSNumber *)price
                  status:(BOOL *) status
                  array:(NSArray *)array
                  object:(NSDictionary *)object
                  callback:(RCTResponseSenderBlock)callback) {
  NSObject *date = @{@"Mon": @2, @"Tue": @3, @"Sat": @7};
  NSArray *options = @[@"One", @"Two", @"Three", date];
  NSDictionary *data = @{@"name": name,@"qty": qty, @"price": price, @"status": status ? @YES : @NO, @"options": options, @"object": object, @"array": array};
  callback(@[data]);
}

// override function to do something in case you want to use event emitter
- (void)startObserving {
  hasListeners = YES;
}

// override function to do something in case you want to use event emitter
- (void)stopObserving {
  hasListeners = NO;
}

/**
 * register event name
 * NOTE: Note that using events gives us no guarantees about execution time, as the event is handled on a separate thread
 * Events are powerful, because they allow us to change React Native components without needing a reference to them
 */
- (NSArray<NSString *> *)supportedEvents {
  return @[@"addEvent"];
}

RCT_REMAP_METHOD(addEvent,
                 name:(NSString *)name
                 details:(NSDictionary *)details)
{
  if(hasListeners) {
    NSString *value = [RCTConvert NSString:details[@"value"]];
    NSString *time = [RCTConvert NSString:details[@"time"]];
    [self sendEventWithName:@"addEvent" body:@{@"value": value, @"time": time}];
  } else {
    NSLog(@"You did not registered any event/listener");
  }
}

@end
