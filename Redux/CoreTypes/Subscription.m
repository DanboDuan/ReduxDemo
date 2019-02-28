//
//  Subscription.m
//  Pods-ReduxDemo
//
//  Created by bob on 2019/2/27.
//

#import "Subscription.h"

@interface Subscription<__covariant StateType> ()

@end

@implementation Subscription

- (instancetype)init {
    return [super init];
}

- (instancetype)initWithSink:(void (^)(void (^)(id, id)))sink {
    self = [super init];
    if (self) {
        void (^block)(id, id) = ^(id oldState, id updatedState){
            [self updateValues:oldState with:updatedState];
        };
        sink(block);
    }

    return self;
}

- (void)updateValues:(id)oldState with:(id)updatedState {
    self.observer(oldState, updatedState);
}

- (instancetype)select:(id (^)(id))selector {

    return [self initWithSink:^(void (^block)(id, id)) {
        self.observer = ^(id oldState, id updatedState) {
            block(selector(oldState), selector(updatedState));
        };
    }];
}

- (instancetype)skipRepeats:(BOOL (^)(id, id))isRepeat {

    return [self initWithSink:^(void (^block)(id, id)) {
        self.observer = ^(id oldState, id updatedState) {
            if (oldState && updatedState) {
                if (!isRepeat(oldState, updatedState)) {
                    block(oldState, updatedState);
                }
            } else {
                block(oldState, updatedState);
            }
        };
    }];
}

- (instancetype)skip:(BOOL (^)(id, id))when {
    
    return [self skipRepeats:when];
}

- (instancetype)only:(BOOL (^)(id, id))when {

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
