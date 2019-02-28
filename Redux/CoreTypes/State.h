//
//  State.h
//  Pods
//
//  Created by bob on 2019/2/27.
//


#import <Foundation/Foundation.h>

@protocol State <NSObject>

@optional
- (BOOL)isEqualToState:(nullable id<State>)object;

@end
