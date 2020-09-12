//
//  State.h
//  Pods
//
//  Created by bob on 2019/2/27.
//


#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol State <NSObject>

@optional
- (BOOL)isEqualToState:(nullable id<State>)object;

@end


NS_ASSUME_NONNULL_END
