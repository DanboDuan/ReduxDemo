## Thunk

### 用ThunkMiddleware创建Store


```Objective-C
self.store = [[Store alloc] initWithReducer:CounterReducer
                                              state:[CounterState stateWithNumber:12]
                                        middlewares:@[ThunkMiddleware, ActionLogger, StateLogger]];
                                        
```

### 异步Action


可以直接使用

```Objective-C
id<Action> asycAction = [[ThunkAction alloc] initWithBody:^(DispatchFunction dispatch, GetState getState) {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // do some thing Async
        NSLog(@"Time - %.2f",CFAbsoluteTimeGetCurrent());
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // then back to dispatch on main queue
            dispatch(action);
        });


    });
}];

[self.store dispatch:action]];
```

也可以定制

```Objective-C
@interface AsyncAction : ThunkAction

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
                dispatch(action);
            });


        });
    }];
}

@end


[self.store dispatch:[AsyncAction actionWithAction:[CounterIncrAction new]]];
```

### CustomThunkMiddleware

也可以参考ThunkMiddleware定制自己的CustomThunkMiddleware
```Objective-C
Middleware CustomThunkMiddleware = ImplementMiddleware({
    // don't foraward to next
    if (/some condition/) {
        do something
    } else {
        next(action);
    }
    return action;
})
```