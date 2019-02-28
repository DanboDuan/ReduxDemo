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
    if ([state isKindOfClass:[CounterState class]]) {
        
        if ([action isKindOfClass:[CounterIncrAction class]]) {
            return [CounterState stateWithNumber:state.number + 1];
        }

        if ([action isKindOfClass:[CounterDecrAction class]]) {
            return [CounterState stateWithNumber:state.number - 1];
        }

        if ([action isKindOfClass:[CounterTypeAction class]]) {
            CounterTypeAction *type = (CounterTypeAction *)action;
            if ([type.type isEqualToString:@"-"]) {
                return [CounterState stateWithNumber:state.number - 1];
            }
            if ([type.type isEqualToString:@"+"]) {
                return [CounterState stateWithNumber:state.number - 1];
            }
        }

        if ([action isKindOfClass:[CounterSetAction class]]) {
            CounterSetAction *set = (CounterSetAction *)action;
            return [CounterState stateWithNumber:set.targetValue];
        }

    }

    return state;
};


