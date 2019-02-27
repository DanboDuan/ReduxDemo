//
//  Middleware.h
//  Pods-ReduxDemo
//
//  Created by bob on 2019/2/25.
//

#import <Foundation/Foundation.h>

@protocol Action;
@protocol State;

typedef void (^DispatchFunction)(id<Action> action);

typedef id<State> (^GetState)(void);
typedef DispatchFunction (^DispatchFunctionChain)(DispatchFunction function);

typedef DispatchFunctionChain (^Middleware)(DispatchFunction dispatchFunction, GetState getState);

#define ImplementMiddleware(SATEMENT)                                       \
^ DispatchFunctionChain (DispatchFunction function, GetState getState) {    \
    return ^DispatchFunction (DispatchFunction next) {                      \
        return ^(id<RxAction> action) {                                     \
            SATEMENT                                                        \
        };                                                                  \
    };                                                                      \
};
