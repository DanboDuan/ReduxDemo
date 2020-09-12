//
//  Subscription.m
//  Pods-ReduxDemo
//
//  Created by bob on 2019/2/27.
//

#import "Subscription.h"

typedef void (^ObserverBlock)(id oldState, id updatedState);
typedef void (^SinkBlock)(ObserverBlock observer);
typedef BOOL (^StateCompareBlock)(id oldState, id updatedState);
typedef id (^StateTransFormBlock)(id state);

@interface Subscription<__covariant StateType> ()

@end

@implementation Subscription

- (instancetype)init {
    return [super init];
}

- (instancetype)initWithSink:(SinkBlock)sink {
    self = [self init];
    if (self) {
        ObserverBlock block = ^(id oldState, id updatedState){
            [self updateValues:oldState with:updatedState];
        };
        sink(block);
    }

    return self;
}

- (void)updateValues:(id)oldState with:(id)updatedState {
    self.observer(oldState, updatedState);
}

/// not a init method
- (instancetype)select:(StateTransFormBlock)selector {
    SinkBlock sink =  ^(ObserverBlock observer){
        self.observer = ^(id oldState, id updatedState) {
            observer(selector(oldState), selector(updatedState));
        };
    };

    return [[[self class] alloc] initWithSink:sink];
}

/// not a init method
- (instancetype)skipRepeats:(StateCompareBlock)isRepeat {
    SinkBlock sink =^(ObserverBlock observer) {
        self.observer = ^(id oldState, id updatedState) {
            if (oldState && updatedState) {
                if (!isRepeat(oldState, updatedState)) {
                    observer(oldState, updatedState);
                }
            } else {
                observer(oldState, updatedState);
            }
        };
    };

    return [[[self class] alloc] initWithSink:sink];
}

/// not a init method
- (instancetype)skip:(StateCompareBlock)when {
    return [self skipRepeats:when];
}

/// not a init method
- (instancetype)only:(StateCompareBlock)when {
    return [self skipRepeats:^BOOL(id oldState, id updatedState) {
        return !when(oldState, updatedState);
    }];
}

@end

#pragma mark Selector

@interface SubscriptionTransForm<__covariant StateType,__covariant TransFormType>()

@property (nonatomic, copy) Subscription * (^transForm)(Subscription *subscription);

@end

@implementation SubscriptionTransForm

- (instancetype)initWith:(Subscription * (^)(Subscription *subscription))transForm {
    self = [super init];
    if (self) {
        self.transForm = transForm;
    }

    return self;
}

- (Subscription *)select:(Subscription *)before
                    with:(id (^)(id))selector {

    return [before select:selector];
}

- (Subscription *)transForm:(Subscription *)before {
    return self.transForm(before);
}

@end
