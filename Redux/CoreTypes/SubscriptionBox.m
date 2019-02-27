//
//  SubscriptionBox.m
//  Pods-ReduxDemo
//
//  Created by bob on 2019/2/27.
//

#import "SubscriptionBox.h"
#import "Subscriber.h"
#import "ReduxMacro.h"

@interface SubscriptionBox<__covariant StateType,__covariant TransformedType> ()


@property (nonatomic, strong) Subscription<StateType> *originalSubscription;
@property (nonatomic, weak) id<Subscriber> subscriber;
@property (nonatomic, strong) NSString *identifier;


@end

@implementation SubscriptionBox


- (instancetype)initWith:(Subscription *)original
             transformed:(Subscription *)transformed
              subscriber:(id<Subscriber>)subscriber {
    self = [super init];
    if (self) {
        self.originalSubscription = original;
        self.subscriber = subscriber;
        self.identifier = [NSString stringWithFormat:@"%p", subscriber];
        if (transformed) {
            ReduxWeakSelf;
            transformed.observer = ^(id  _Nonnull oldState, id  _Nonnull updatedState) {
                ReduxStrongSelf;
                [self.subscriber updateState:updatedState];
            };
        } else {
            ReduxWeakSelf;
            original.observer = ^(id  _Nonnull oldState, id  _Nonnull updatedState) {
                ReduxStrongSelf;
                [self.subscriber updateState:updatedState];
            };
        }
    }

    return self;
}

- (void)updateValues:(id)oldState with:(id)updatedState {
    [self.originalSubscription updateValues:oldState with:updatedState];
}

-(NSUInteger)hash {
    return [self.identifier hash];
}


@end
