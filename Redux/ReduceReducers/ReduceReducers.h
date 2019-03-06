//
//  ReduceReducers.h
//  Pods-ReduxDemo
//
//  Created by bob on 2019/3/6.
//

#import <Foundation/Foundation.h>
#import "Reducer.h"

typedef Reducer (^ReduceReducersF)(NSArray<Reducer> *reducers);

FOUNDATION_EXTERN ReduceReducersF reduceReducers;

