//
//  CombineReducers.h
//  Pods-ReduxDemo
//
//  Created by bob on 2019/3/6.
//

#import <Foundation/Foundation.h>
#import "Reducer.h"

@class CombinedState;

typedef CombinedState* (^CombineReducer)(id<Action> action, CombinedState *state);
typedef CombineReducer (^CombineReducersF)(NSDictionary<id, Reducer> *reducers);

FOUNDATION_EXTERN CombineReducersF combineReducers;
