//
//  ScheduledAction.m
//  Pods-ReduxDemo
//
//  Created by bob on 2019/3/11.
//

#import "ScheduledAction.h"
#import <objc/runtime.h>

extern const void * kReduxScheduleMiddlewareTimer;

@interface ScheduledAction ()

@property (nonatomic, assign) NSTimeInterval start;
@property (nonatomic, assign) NSTimeInterval interval;
@property (nonatomic, assign) BOOL repeats;
@end

@implementation ScheduledAction

- (instancetype)initWithStart:(NSTimeInterval)start
                     interval:(NSTimeInterval)interval
                      repeats:(BOOL)repeats {
    self = [super init];
    if (self) {
        self.start = start;
        self.interval = interval;
        self.repeats = repeats;
    }

    return self;
}

- (void)cancelAction {
    dispatch_source_t timer = objc_getAssociatedObject(self, kReduxScheduleMiddlewareTimer);
    if (timer) {
        dispatch_source_cancel(timer);
    }
}

@end
