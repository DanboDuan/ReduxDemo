//
//  ThunkAction.m
//  Pods-ReduxDemo
//
//  Created by bob on 2019/3/3.
//

#import "ThunkAction.h"

@interface ThunkAction<__covariant StateType> ()

@property (nonatomic, copy) ThunkBody body;

@end

@implementation ThunkAction

- (instancetype)init {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:@"Failed to call designated initializer." userInfo:nil];
}

- (instancetype)initWithBody:(ThunkBody)body {
    self = [super init];
    if (self) {
        self.body = body;
    }
    return self;
}

@end
