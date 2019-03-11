//
//  ScheduleReducer.m
//  ReduxDemo
//
//  Created by bob on 2019/3/11.
//  Copyright © 2019 bob. All rights reserved.
//

#import "ScheduleReducer.h"
#import "CounterState.h"
#import "ScheduledCounterAction.h"

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

