//
//  Subscriber.h
//  Pods-ReduxDemo
//
//  Created by bob on 2019/2/27.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol Subscriber <NSObject>

- (void)updateState:(id)state;

@end

NS_ASSUME_NONNULL_END
