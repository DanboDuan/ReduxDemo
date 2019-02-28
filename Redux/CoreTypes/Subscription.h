//
//  Subscription.h
//  Pods-ReduxDemo
//
//  Created by bob on 2019/2/27.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Subscription<__covariant StateType> : NSObject

@property (nonatomic, copy) void (^observer)(StateType oldState, StateType updatedState);

- (void)updateValues:(nullable StateType)oldState with:(nullable StateType)updatedState;

- (instancetype)skipRepeats:(BOOL (^)(StateType oldState, StateType updatedState))isRepeat;
- (instancetype)skip:(BOOL (^)(StateType oldState, StateType updatedState))when;
- (instancetype)only:(BOOL (^)(StateType oldState, StateType updatedState))when;

@end


@interface SubscriptionTransForm<__covariant StateType,__covariant TransFormType>: NSObject

- (instancetype)initWith:(Subscription * (^)(Subscription *subscription))transForm;

- (Subscription<TransFormType> *)select:(Subscription<StateType> *)before
                                   with:(TransFormType (^)(StateType state))selector;

- (Subscription<TransFormType> *)transForm:(Subscription<StateType> *)before;

@end

NS_ASSUME_NONNULL_END
