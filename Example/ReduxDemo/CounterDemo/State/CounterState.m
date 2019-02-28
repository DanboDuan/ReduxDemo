//
//  CounterState.m
//  ReduxDemo
//
//  Created by bob on 2019/2/28.
//  Copyright © 2019 bob. All rights reserved.
//

#import "CounterState.h"

@interface CounterState()

@property (nonatomic, assign) NSInteger number;

@end

@implementation CounterState

+ (instancetype)stateWithNumber:(NSInteger)number {
    return [[self alloc] initWithNumber:number];
}

- (instancetype)initWithNumber:(NSInteger)number {
    self = [super init];
    if (self) {
        self.number = number;
    }
    return self;
}

- (BOOL)isEqualToState:(nullable id<State>)object {

    if ([object isKindOfClass:[CounterState class]]) {
        CounterState *state = (CounterState *)object;
        return state.number == self.number;
    }

    return NO;
}

-(NSString *)description {
    return [NSString stringWithFormat:@"CounterState(%zd)",self.number];
}

@end
