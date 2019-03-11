//
//  ScheduledCounterAction.h
//  ReduxDemo
//
//  Created by bob on 2019/3/11.
//  Copyright © 2019 bob. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Redux/Schedule.h>

NS_ASSUME_NONNULL_BEGIN

@interface ScheduledCounterAction : ScheduledAction

@property (nonatomic, strong, readonly) NSString *operation;

- (instancetype)initWithOperation:(NSString *)operation;

@end

NS_ASSUME_NONNULL_END
