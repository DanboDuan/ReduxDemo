//
//  CombineReducers.m
//  Pods-ReduxDemo
//
//  Created by bob on 2019/3/6.
//

#import "CombineReducers.h"
#import "Redux.h"
#import "CombinedState.h"


CombineReducersF combineReducers = ^Reducer (NSDictionary<id, Reducer> *reducers) {

    return ^CombinedState* (id<Action> action, CombinedState *state) {
        CombinedState *nextState = [CombinedState new];

        [reducers enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, Reducer  _Nonnull reducer, BOOL * _Nonnull stop) {
            [nextState setSubState:reducer(action, [state subStateForKey:key]) forKey:key];
        }];

        return nextState;
    };
};
