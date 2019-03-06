//
//  CounterReducer.m
//  ReduxDemo
//
//  Created by bob on 2019/2/28.
//  Copyright © 2019 bob. All rights reserved.
//

#import "CounterReducer.h"
#import "CounterState.h"
#import "CounterAction.h"

Reducer CounterReducer = ^CounterState * (id<Action> action, CounterState *state) {

    if (state == nil) {
        CounterState *nextState = [CounterState new];
        nextState.number = 0;
        return nextState;
    }

    if ([state isKindOfClass:[CounterState class]]) {
        CounterState *nextState = [CounterState new];
        nextState.operation = state.operation;
        nextState.number = state.number;

        if ([action isKindOfClass:[CounterIncrAction class]]) {
            nextState.number = state.number + 1;
        }

        if ([action isKindOfClass:[CounterDecrAction class]]) {
            nextState.number = state.number - 1;
        }

        if ([action isKindOfClass:[CounterSetAction class]]) {
            CounterSetAction *set = (CounterSetAction *)action;
            nextState.number = set.targetValue;
        }

        return nextState;
    }

    return state;
};


