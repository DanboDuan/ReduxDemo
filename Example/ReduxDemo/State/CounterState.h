//
//  CounterState.h
//  ReduxDemo
//
//  Created by bob on 2019/2/28.
//  Copyright © 2019 bob. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Redux/Redux.h>

NS_ASSUME_NONNULL_BEGIN

@interface CounterState : NSObject<State>

@property (nonatomic, assign) NSInteger number;
@property (nonatomic, copy) NSString *operation;

@end

@protocol HasCounterState <State>

@property (strong, nonatomic, readonly) CounterState *counterState;

@end

NS_ASSUME_NONNULL_END
