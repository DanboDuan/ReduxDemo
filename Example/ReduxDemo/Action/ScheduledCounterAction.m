//
//  ScheduledCounterAction.m
//  ReduxDemo
//
//  Created by bob on 2019/3/11.
//  Copyright © 2019 bob. All rights reserved.
//

#import "ScheduledCounterAction.h"

@interface ScheduledCounterAction ()

@property (nonatomic, strong) NSString *operation;

@end

@implementation ScheduledCounterAction

- (instancetype)initWithOperation:(NSString *)operation  {
    self = [super initWithStart:1 interval:2 repeats:YES];
    if (self) {
        self.operation = operation;
    }
    
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"Scheduled(%@)", self.operation];
}

@end
