//
//  ComplexState.m
//  ReduxDemo
//
//  Created by bob on 2019/2/28.
//  Copyright © 2019 bob. All rights reserved.
//

#import "ComplexState.h"

@interface ComplexState ()

@property (strong, nonatomic) CounterState *counterState;

@end

@implementation ComplexState

+ (instancetype)stateWithCounter:(CounterState *)counter {
    return [[self alloc] initWithCounter:counter];
}

- (instancetype)initWithCounter:(CounterState *)counter {
    self = [super init];
    if(self) {
        self.counterState = counter;
    }
    
    return self;
}

- (BOOL)isEqualToState:(id<State>)object {
    if ([object isKindOfClass:[ComplexState class]]) {
        ComplexState *state = (ComplexState *)object;
        if ([self.counterState respondsToSelector:@selector(isEqualToState:)]) {
            return [self.counterState isEqualToState:state.counterState];
        }
    }

    return NO;
}

@end
