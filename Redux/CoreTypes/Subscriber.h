//
//  Subscriber.h
//  Pods-ReduxDemo
//
//  Created by bob on 2019/2/27.
//

#import <Foundation/Foundation.h>

@protocol Subscriber <NSObject>

- (void)updateState:(id)state;

@end
