//
//  CombineState.h
//  Pods-ReduxDemo
//
//  Created by bob on 2019/3/6.
//

#import <Foundation/Foundation.h>
#import "State.h"

NS_ASSUME_NONNULL_BEGIN

@interface CombinedState<__covariant KeyType, __covariant SubStateType : id<State>> : NSObject<State>

- (nullable SubStateType)subStateForKey:(KeyType)aKey;
- (void)setSubState:(SubStateType)anObject forKey:(KeyType <NSCopying>)aKey;

@end

NS_ASSUME_NONNULL_END
