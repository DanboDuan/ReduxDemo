## Scheduled

##### 1. 继承`ScheduledAction`或者直接使用`ScheduledAction`

```Objective-C

@interface ScheduledCounterAction ()

@property (nonatomic, strong) NSString *operation;

@end

@implementation ScheduledCounterAction

- (instancetype)initWithOperation:(NSString *)operation  {
    self = [super initWithStart:1 interval:2 repeats:YES];
    if (self) {
        self.operation = operation;
    }
    
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"Scheduled(%@)", self.operation];
}

@end

```
##### 2. Reducer

```Objective-C
Reducer ScheduleReducer = ^CounterState * (ScheduledCounterAction *action, CounterState *state) {

    if (state == nil) {
        CounterState *nextState = [CounterState new];
        nextState.number = 0;
        nextState.operation = @"init operation";
        return nextState;
    }

    if([action isKindOfClass:[ScheduledCounterAction class]]) {

        if ([action.operation isEqualToString:@"-"]) {
            state.number -= 1;
        }

        if ([action.operation isEqualToString:@"+"]) {
            state.number += 1;
        }

        state.operation = action.description;
    }

    return state;
};

```
##### 3. ScheduleMiddleware

```Objective-C
self.store = [[Store alloc] initWithReducer:ScheduleReducer
                                              state:nil
                                        middlewares:@[ActionLogger, StateLogger, ScheduleMiddleware]];
```

##### 4. dispatch scheduledAction

```Objective-C
- (void)buttonClick:(UIButton *)sender {
    NSString *type = sender.currentTitle;
    if (self.scheduledAction) {
        [self.scheduledAction cancelAction];
    }
    ScheduledCounterAction *action = [[ScheduledCounterAction alloc] initWithOperation:type];
    self.scheduledAction = [self.store dispatch:action];
}
```
**这里需要注意，如果之前的Action是repeats的，如果不cancel之前的Action，则之前action还会继续repeats**

##### 4. cancel scheduledAction

```Objective-C
- (void)cancelButtontClick:(UIButton *)sender {
    [self.scheduledAction cancelAction];
    self.scheduledAction = nil;
}

```
## tip

当然这里也可以自定义store或者Middleware来实现自己的scheduleAction