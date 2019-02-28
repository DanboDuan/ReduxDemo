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

@property (nonatomic, assign, readonly) NSInteger number;

+ (instancetype)stateWithNumber:(NSInteger)number;

@end

NS_ASSUME_NONNULL_END
