//
//  Store.m
//  Pods-ReduxDemo
//
//  Created by bob on 2019/2/27.
//

#import "Store.h"
#import "Action.h"
#import "State.h"
#import "Subscriber.h"
#import "SubscriptionBox.h"
#import "ReduxMacro.h"

@interface InitAction : NSObject <Action>
@end
@implementation InitAction
@end

@interface Store<__covariant StateType:id<State>> ()

@property (nonatomic, strong) StateType state;
@property (nonatomic, copy) DispatchFunction dispatchFunction;
@property (copy, nonatomic) Reducer reducer;
@property (strong, nonatomic) NSMutableSet<SubscriptionBox *> *subscriptions;
@property (assign, nonatomic) BOOL isDispatching;
@property (assign, nonatomic) BOOL autoSkipRepeats;

@end

@implementation Store

- (instancetype)init {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:@"Failed to call designated initializer." userInfo:nil];
}

- (instancetype)initWithReducer:(Reducer)rootReducer
                          state:(nullable id<State>)rootState {
    return [self initWithReducer:rootReducer state:rootState middlewares:[NSArray array]];
}


- (instancetype)initWithReducer:(Reducer)rootReducer
                          state:(nullable id<State>)rootState
                    middlewares:(NSArray<Middleware> *)middlewares {
    return [self initWithReducer:rootReducer state:rootState middlewares:middlewares autoSkipRepeats:YES];
}

- (instancetype)initWithReducer:(Reducer)rootReducer
                          state:(nullable id<State>)rootState
                    middlewares:(NSArray<Middleware> *)middlewares
                autoSkipRepeats:(BOOL)autoSkipRepeats {
    self = [super init];
    if (self) {
        self.autoSkipRepeats = autoSkipRepeats;
        self.reducer = rootReducer;

        if (rootState) {
            self.state = rootState;
        } else {
            [self dispatch:[InitAction new]];
        }
    }
    return self;
}

- (void)subscribe:(id<Subscriber>)subscriber {

}

- (void)subscribe:(id<Subscriber>)subscriber withTransform:(SubscriptionTransForm *)transform {

}

- (void)unsubscribe:(id<Subscriber>)subscriber {

}

- (void)dispatch:(id<Action>)action {

}


- (void)setState:(id<State>)state {
    NSMutableArray<SubscriptionBox *> *toRemove = [NSMutableArray arrayWithCapacity:self.subscriptions.count];

    for (SubscriptionBox *box in self.subscriptions) {
        if (!box.subscriber) {
            [toRemove addObject:box];
            continue;
        }
        [box updateValues:_state with:state];
    }
    if (toRemove.count) {
        for (SubscriptionBox *box in toRemove) {
            [self.subscriptions removeObject:box];
        }
    }
    _state = state;
}

@end


