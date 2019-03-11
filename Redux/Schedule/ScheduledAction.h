//
//  ScheduledAction.h
//  Pods-ReduxDemo
//
//  Created by bob on 2019/3/11.
//

#import <Foundation/Foundation.h>
#import "Action.h"
#import "Middleware.h"

NS_ASSUME_NONNULL_BEGIN

@interface ScheduledAction : NSObject<Action>

@property (nonatomic, assign, readonly) NSTimeInterval start;
@property (nonatomic, assign, readonly) NSTimeInterval interval;
@property (nonatomic, assign, readonly) BOOL repeats;

- (instancetype)initWithStart:(NSTimeInterval)start
                     interval:(NSTimeInterval)interval
                      repeats:(BOOL)repeats;

- (void)cancelAction;

@end

NS_ASSUME_NONNULL_END
