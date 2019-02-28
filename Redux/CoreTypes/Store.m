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
#import "NSArray+Redux.h"


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
    return [self initWithReducer:rootReducer state:rootState middlewares:@[]];
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
        self.subscriptions = [NSMutableSet set];
        DispatchFunction defaultDispatch = ^(id<Action> action) {
            [self internalDefaultDispatch:action];
        };

        ReduxWeakSelf;
        self.dispatchFunction = middlewares.reverse.reduce(defaultDispatch,^id(DispatchFunction df, Middleware middleware){
            DispatchFunction dispatch = ^(id<Action> action) {
                ReduxStrongSelf;
                [self dispatch:action];
            };
            GetState getState = ^id<State>() {
                 ReduxStrongSelf;
                return self.state;
            };
            
            return middleware([dispatch copy], [getState copy])(df);
        });

        if (rootState) {
            self.state = rootState;
        } else {
            [self dispatch:[InitAction new]];
        }
    }
    
    return self;
}

- (void)subscribe:(id<Subscriber>)subscriber {
    SubscriptionTransForm *transform = self.autoSkipRepeats ? [[SubscriptionTransForm alloc] initWith:^Subscription * _Nonnull(Subscription * _Nonnull subscription) {
        return [subscription skipRepeats:^BOOL(id<State>  _Nonnull oldState, id<State>  _Nonnull updatedState) {
            if ([updatedState respondsToSelector:@selector(isEqualToState:)]) {
                return [updatedState isEqualToState:oldState];
            }

            return NO;
        }];
    }] : nil;

    [self subscribe:subscriber withTransform:transform];
}

- (void)subscribe:(id<Subscriber>)subscriber withTransform:(SubscriptionTransForm *)transform {
    Subscription *orginal = [Subscription new];
    Subscription *transformed = transform ? [transform transForm:orginal] : nil;

    if(self.autoSkipRepeats && transformed) {
        transformed = [transformed skipRepeats:^BOOL(id<State>  _Nonnull oldState, id<State>  _Nonnull updatedState) {
            if ([updatedState respondsToSelector:@selector(isEqualToState:)]) {
                return [updatedState isEqualToState:oldState];
            }

            return NO;
        }];
    }

    [self internalSubscribe:subscriber orginal:orginal transformed:transformed];
}

- (void)internalSubscribe:(id<Subscriber>)subscriber orginal:(Subscription *)orginal transformed:(Subscription *)transformed {
    SubscriptionBox *box = [[SubscriptionBox alloc] initWith:orginal
                                                 transformed:transformed
                                                  subscriber:subscriber];

    [self.subscriptions addObject:box];
    
    if (self.state) {
        [orginal updateValues:nil with:self.state];
    }
}

- (void)unsubscribe:(id<Subscriber>)subscriber {
    SubscriptionBox *box = [self subscriptionWithSubscriber:subscriber];
    if (box) {
        [self.subscriptions removeObject:box];
    }
}

- (SubscriptionBox *) subscriptionWithSubscriber:(id<Subscriber>)subscriber {
    for (SubscriptionBox *sub in self.subscriptions) {
        if(sub.subscriber == subscriber) {
            return sub;
        }
    }

    return nil;
}

-(void)internalDefaultDispatch:(id<Action>)action {
    if (self.isDispatching) {
         NSAssert(0, nil);
    }

    self.isDispatching = YES;
    id<State> state = self.reducer(action, self.state);
    self.isDispatching = NO;

    self.state  = state;
}

- (void)dispatch:(id<Action>)action {
    self.dispatchFunction(action);
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


