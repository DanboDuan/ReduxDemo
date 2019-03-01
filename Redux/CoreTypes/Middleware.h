//
//  Middleware.h
//  Pods-ReduxDemo
//
//  Created by bob on 2019/2/25.
//

#import <Foundation/Foundation.h>

@protocol Action;
@protocol State;

typedef id<Action> (^DispatchFunction)(id<Action> action);

typedef id<State> (^GetState)(void);
typedef DispatchFunction (^DispatchFunctionChain)(DispatchFunction dispatch);

typedef DispatchFunctionChain (^Middleware)(DispatchFunction dispatch, GetState getState);

#define ImplementMiddleware(SATEMENT)                                       \
^ DispatchFunctionChain (DispatchFunction dispatch, GetState getState) {    \
    return ^DispatchFunction (DispatchFunction next) {                      \
        return ^(id<Action> action) {                                     \
            SATEMENT                                                        \
        };                                                                  \
    };                                                                      \
};
