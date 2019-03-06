//
//  CombineState.m
//  Pods-ReduxDemo
//
//  Created by bob on 2019/3/6.
//

#import "CombinedState.h"

@interface CombinedState<__covariant KeyType, __covariant ObjectType : id<State>>  ()

@property (nonatomic, strong) NSMutableDictionary<KeyType, ObjectType> *realState;

@end

@implementation CombinedState

- (instancetype)init {
    self = [super init];
    if (self) {
        self.realState = [NSMutableDictionary dictionary];
    }

    return self;
}

- (id)subStateForKey:(id)aKey {
    return [self.realState objectForKey:aKey];
}

- (void)setSubState:(id)anObject forKey:(id)aKey {
    if (!aKey) {
        return;
    }
    if (!anObject) {
        [self.realState removeObjectForKey:aKey];
    }
    [self.realState setObject:anObject forKey:aKey];
}

- (BOOL)isEqualToState:(id<State>)object {

    if (![object isKindOfClass:[CombinedState class]])  {
        return NO;
    }

    CombinedState *state = (CombinedState *)object;
    if (state.realState.count != self.realState.count) {
        return NO;
    }

    __block BOOL isEqual = YES;
    [state.realState enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        id<State> selfValue = [self.realState objectForKey:key];
        if (![selfValue respondsToSelector:@selector(isEqualToState:)]) {
            *stop = YES;
            isEqual = NO;
        } else {
            isEqual = [selfValue isEqualToState:obj];
            *stop = !isEqual;
        }
    }];

    return isEqual;
}

@end
