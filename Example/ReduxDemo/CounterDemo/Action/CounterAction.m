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


@interface CounterTypeAction ()

@property (nonatomic, strong) NSString *type;

@end


@implementation CounterTypeAction

+ (instancetype)actionWithType:(NSString *)type {
    return [[self alloc] initWithType:type];
}

- (instancetype)initWithType:(NSString *)type {
    self = [super init];
    if (self) {
        self.type = type;
    }

    return self;
}

-(NSString *)description {
    return [NSString stringWithFormat:@"CounterTypeAction(%@)",self.type];
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
