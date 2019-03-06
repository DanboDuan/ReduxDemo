//
//  CounterAction.h
//  ReduxDemo
//
//  Created by bob on 2019/2/28.
//  Copyright © 2019 bob. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Redux/Redux.h>

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXTERN NSString * const CounterIncrActionType;
FOUNDATION_EXTERN NSString * const CounterDecrActionType;

@interface CounterIncrAction : NSObject<Action>

@end


@interface CounterDecrAction : NSObject<Action>

@end


@interface OperationAction : NSObject<Action>

@property (nonatomic, strong, readonly) NSString *operation;

+ (instancetype)actionWithOperation:(NSString *)operation;

@end

@interface CounterSetAction : NSObject<Action>

@property (nonatomic, assign, readonly) NSInteger targetValue;

+ (instancetype)actionWithValue:(NSInteger)targetValue;

@end

NS_ASSUME_NONNULL_END
