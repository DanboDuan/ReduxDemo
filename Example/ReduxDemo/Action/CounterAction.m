//
//  CounterAction.m
//  ReduxDemo
//
//  Created by bob on 2019/2/28.
//  Copyright © 2019 bob. All rights reserved.
//

#import "CounterAction.h"

NSString * const CounterIncrActionType    =   @"+";
NSString * const CounterDecrActionType    =   @"-";

@implementation CounterIncrAction

-(NSString *)description {
    return [NSString stringWithFormat:@"CounterIncrAction"];
}

@end


@implementation CounterDecrAction

-(NSString *)description {
    return [NSString stringWithFormat:@"CounterDecrAction"];
}

@end


@interface OperationAction ()

@property (nonatomic, strong) NSString *operation;

@end


@implementation OperationAction

+ (instancetype)actionWithOperation:(NSString *)operation {
    return [[self alloc] initWithOperation:operation];
}

- (instancetype)initWithOperation:(NSString *)operation {
    self = [super init];
    if (self) {
        self.operation = operation;
    }

    return self;
}

-(NSString *)description {
    return [NSString stringWithFormat:@"OperationAction(%@)",self.operation];
}

@end


@interface CounterSetAction ()

@property (nonatomic, assign) NSInteger targetValue;

+ (instancetype)actionWithValue:(NSInteger)targetValue;

@end

@implementation CounterSetAction

+ (instancetype)actionWithValue:(NSInteger)targetValue {
    return  [[self alloc] initWithValue:targetValue];
}

- (instancetype)initWithValue:(NSInteger)targetValue {
    self = [super init];
    if (self) {
        self.targetValue = targetValue;
    }

    return self;
}

-(NSString *)description {
    return [NSString stringWithFormat:@"CounterSetAction(%zd)",self.targetValue];
}

@end
