//
//  OperationState.m
//  ReduxDemo
//
//  Created by bob on 2019/3/6.
//  Copyright © 2019 bob. All rights reserved.
//

#import "OperationState.h"

@implementation OperationState

-(NSString *)description {
    return [NSString stringWithFormat:@"%@(operation = %@)",self.class, self.operation];
}

@end
