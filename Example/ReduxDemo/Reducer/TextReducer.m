//
//  TextReducer.m
//  ReduxDemo
//
//  Created by bob on 2019/3/6.
//  Copyright © 2019 bob. All rights reserved.
//

#import "TextReducer.h"
#import "CounterState.h"
#import "CounterAction.h"

Reducer TextReducer = ^CounterState * (id<Action> action, CounterState *state) {

    if (state == nil) {
        CounterState *nextState = [CounterState new];
        nextState.number = 0;
        nextState.operation = @"init operation";
        return nextState;
    }

    if ([state isKindOfClass:[CounterState class]]) {
        state.operation = action.description;
    }

    return state;
};
