//
//  SubscriptionBox.h
//  Pods-ReduxDemo
//
//  Created by bob on 2019/2/27.
//

#import <Foundation/Foundation.h>
#import "Subscription.h"

NS_ASSUME_NONNULL_BEGIN

@protocol Subscriber;


@interface SubscriptionBox<__covariant StateType,__covariant TransformedType> : NSObject

@property (nonatomic, weak, readonly) id<Subscriber> subscriber;;

- (instancetype)initWith:(Subscription<StateType> *)original
             transformed:(Subscription<TransformedType> *)transformed
              subscriber:(id<Subscriber>)subscriber;

- (void)updateValues:(StateType)oldState with:(StateType)updatedState;

@end

NS_ASSUME_NONNULL_END
