//
//  AsyncAction.m
//  ReduxDemo
//
//  Created by bob on 2019/3/3.
//  Copyright © 2019 bob. All rights reserved.
//

#import "AsyncAction.h"

@interface AsyncAction ()

@end

@implementation AsyncAction

+ (instancetype)actionWithAction:(id<Action>)action {
    return [[self alloc] initWithAction:action];
}

- (instancetype)initWithAction:(id<Action>)action {
    return [super initWithBody:^(DispatchFunction dispatch, GetState getState) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            // do some thing Async
            NSLog(@"Time - %.2f",CFAbsoluteTimeGetCurrent());


            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                // then back to dispatch on main queue
                NSLog(@"Time - %.2f",CFAbsoluteTimeGetCurrent());
                // shouldn't dispatch yourself, or will get infinite loop
                dispatch(action);
            });


        });
    }];
}

@end


