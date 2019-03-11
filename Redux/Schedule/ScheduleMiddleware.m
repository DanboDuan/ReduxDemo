//
//  ScheduleMiddleware.m
//  Pods-ReduxDemo
//
//  Created by bob on 2019/3/11.
//

#import "ScheduleMiddleware.h"
#import "Redux.h"
#import "ScheduledAction.h"
#import <objc/runtime.h>
#import "ReduxTimer.h"

const void * kReduxScheduleMiddlewareTimer = &kReduxScheduleMiddlewareTimer;

Middleware ScheduleMiddleware = ImplementMiddleware({
    
    if ([action isKindOfClass:[ScheduledAction class]]) {
        // scheduled
        dispatch_source_t timer = objc_getAssociatedObject(action, kReduxScheduleMiddlewareTimer);
        if (timer) {
            next(action);
        } else {
            // schedule it
            ScheduledAction *scheduled = (ScheduledAction *)action;
            timer = [ReduxTimer scheduleTimer:scheduled.start interval:scheduled.interval repeats:scheduled.repeats action:^{
                dispatch(action);
            } cancel:^{
                objc_setAssociatedObject(scheduled, kReduxScheduleMiddlewareTimer, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }];
            objc_setAssociatedObject(scheduled, kReduxScheduleMiddlewareTimer, timer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    } else {
        next(action);
    }

    return action;
});
