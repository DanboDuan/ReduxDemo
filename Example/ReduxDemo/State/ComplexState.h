//
//  ComplexState.h
//  ReduxDemo
//
//  Created by bob on 2019/2/28.
//  Copyright © 2019 bob. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Redux/Redux.h>
#import "CounterState.h"

NS_ASSUME_NONNULL_BEGIN

@interface ComplexState : NSObject<State, HasCounterState>

@property (strong, nonatomic, readonly) CounterState *counterState;

+ (instancetype)stateWithCounter:(CounterState *)counter;

@end

NS_ASSUME_NONNULL_END
