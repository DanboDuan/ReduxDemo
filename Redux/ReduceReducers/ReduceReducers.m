//
//  ReduceReducers.m
//  Pods-ReduxDemo
//
//  Created by bob on 2019/3/6.
//

#import "ReduceReducers.h"
#import "Redux.h"
#import "NSArray+Redux.h"

ReduceReducersF reduceReducers = ^Reducer (NSArray<Reducer> *reducers) {

    Reducer defaultReducer = ^id<State> (id<Action> action, id<State> state) {
        return state;
    };

    return reducers.reduce(defaultReducer, ^id(Reducer preReducer, Reducer next) {

        return ^id<State> (id<Action> action, id<State> state) {
            return next(action, preReducer(action, state));;
        };

    });
};
