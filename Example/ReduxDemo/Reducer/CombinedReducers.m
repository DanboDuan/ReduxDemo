//
//  Combine.m
//  ReduxDemo
//
//  Created by bob on 2019/3/6.
//  Copyright © 2019 bob. All rights reserved.
//

#import "CombinedReducers.h"

#import "CounterState.h"
#import "OperationState.h"
#import "CounterAction.h"

Reducer CombinedOperationtReducer = ^OperationState * (OperationAction *action, OperationState *state) {

    if (state == nil) {
        OperationState *nextState = [OperationState new];
        nextState.operation = @"init operation";
        return nextState;
    }

    if ([state isKindOfClass:[OperationState class]] && [action isKindOfClass:[OperationAction class]]) {
        state.operation = action.operation;
    }

    return state;
};

Reducer CombinedNumberReducer = ^CounterState * (id<Action> action, CounterState *state) {

    if (state == nil) {
        CounterState *nextState = [CounterState new];
        nextState.number = 0;
        return nextState;
    }

    
    if ([state isKindOfClass:[CounterState class]]) {
        
        CounterState *nextState = [CounterState new];
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
