//
//  CounterState.m
//  ReduxDemo
//
//  Created by bob on 2019/2/28.
//  Copyright © 2019 bob. All rights reserved.
//

#import "CounterState.h"

@interface CounterState()

@end

@implementation CounterState

- (BOOL)isEqualToState:(id<State>)object {

    if ([object isKindOfClass:[CounterState class]]) {
        CounterState *state = (CounterState *)object;
        return state.number == self.number && [self.operation isEqualToString:state.operation];
    }

    return NO;
}

-(NSString *)description {
    return [NSString stringWithFormat:@"%@(number = %zd, operation = %@)",self.class, self.number, self.operation];
}

@end
