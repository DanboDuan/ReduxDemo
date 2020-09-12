//
//  Store.h
//  Pods-ReduxDemo
//
//  Created by bob on 2019/2/27.
//

#import <Foundation/Foundation.h>

#import "Reducer.h"
#import "Middleware.h"
#import "Subscription.h"

NS_ASSUME_NONNULL_BEGIN

@protocol Action;
@protocol State;
@protocol Subscriber;

@protocol Store <NSObject>

@property (nonatomic, strong, readonly) id<State> state;
@property (nonatomic, copy, readonly) DispatchFunction dispatchFunction;

- (instancetype)initWithReducer:(Reducer)rootReducer
                          state:(nullable id<State>)rootState;


- (instancetype)initWithReducer:(Reducer)rootReducer
                          state:(nullable id<State>)rootState
                    middlewares:(NSArray<Middleware> *)middlewares;

- (instancetype)initWithReducer:(Reducer)rootReducer
                          state:(nullable id<State>)rootState
                    middlewares:(NSArray<Middleware> *)middlewares
                autoSkipRepeats:(BOOL)autoSkipRepeats;

- (void)subscribe:(id<Subscriber>)subscriber;

- (void)subscribe:(id<Subscriber>)subscriber withTransform:(nullable SubscriptionTransForm *)transform;

- (void)unsubscribe:(id<Subscriber>)subscriber;

- (id<Action>)dispatch:(id<Action>)action;

@end

@interface Store<__covariant StateType:id<State>> : NSObject<Store>

@property (nonatomic, strong, readonly) StateType state;
@property (nonatomic, copy, readonly) DispatchFunction dispatchFunction;

- (instancetype)initWithReducer:(Reducer)rootReducer
                          state:(nullable StateType)rootState;


- (instancetype)initWithReducer:(Reducer)rootReducer
                          state:(nullable StateType)rootState
                    middlewares:(NSArray<Middleware> *)middlewares;

- (instancetype)initWithReducer:(Reducer)rootReducer
                          state:(nullable StateType)rootState
                    middlewares:(NSArray<Middleware> *)middlewares
                autoSkipRepeats:(BOOL)autoSkipRepeats;

- (void)subscribe:(id<Subscriber>)subscriber;

- (void)subscribe:(id<Subscriber>)subscriber withTransform:(nullable SubscriptionTransForm<StateType, id> *)transform;

- (void)unsubscribe:(id<Subscriber>)subscriber;

- (id<Action>)dispatch:(id<Action>)action;

@end



NS_ASSUME_NONNULL_END
