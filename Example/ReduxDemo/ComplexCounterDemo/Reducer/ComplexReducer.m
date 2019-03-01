//
//  ComplexReducer.m
//  ReduxDemo
//
//  Created by bob on 2019/2/28.
//  Copyright © 2019 bob. All rights reserved.
//

#import "ComplexReducer.h"
#import "ComplexState.h"
#import "CounterReducer.h"

Reducer ComplexReducer = ^ComplexState * (id<Action> action, ComplexState *state) {

    if (!state) {
        return [ComplexState stateWithCounter:CounterReducer(action, nil)];
    }

    if ([state conformsToProtocol:@protocol(HasCounterState)]) {
        return [ComplexState stateWithCounter:CounterReducer(action, state.counterState)];
    }

    return state;
};
