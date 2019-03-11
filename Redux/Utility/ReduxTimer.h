//
//  ReduxTimer.h
//  Pods-ReduxDemo
//
//  Created by bob on 2019/3/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ReduxTimer : NSObject

+ (dispatch_source_t)scheduleTimer:(NSTimeInterval)start
                          interval:(NSTimeInterval)interval
                           repeats:(BOOL)repeats
                            action:(dispatch_block_t)action
                            cancel:(dispatch_block_t)cancel;

@end

NS_ASSUME_NONNULL_END
