//
//  ReduxTimer.m
//  Pods-ReduxDemo
//
//  Created by bob on 2019/3/11.
//

#import "ReduxTimer.h"

@implementation ReduxTimer

+ (dispatch_source_t)scheduleTimer:(NSTimeInterval)start
                          interval:(NSTimeInterval)interval
                           repeats:(BOOL)repeats
                            action:(dispatch_block_t)action
                            cancel:(dispatch_block_t)cancel {

    dispatch_queue_t queue = dispatch_get_main_queue();
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(timer, dispatch_time(DISPATCH_TIME_NOW, start * NSEC_PER_SEC), interval * NSEC_PER_SEC, NSEC_PER_MSEC);
    dispatch_source_set_event_handler(timer, ^{
        if (action) {
            action();
        }

        if (!repeats) {
            dispatch_source_cancel(timer);
        }
    });
    if (cancel) dispatch_source_set_cancel_handler(timer,cancel);

    dispatch_resume(timer);

    return timer;
}

@end
