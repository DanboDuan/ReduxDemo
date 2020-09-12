//
//  Reducer.h
//  Pods-ReduxDemo
//
//  Created by bob on 2019/2/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol Action;
@protocol State;

typedef id<State> (^Reducer)(id<Action> action, id<State> state);

NS_ASSUME_NONNULL_END


