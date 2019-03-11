//
//  ThunkMiddleware.m
//  Pods-ReduxDemo
//
//  Created by bob on 2019/3/3.
//

#import "ThunkMiddleware.h"
#import "Redux.h"
#import "ThunkAction.h"

Middleware ThunkMiddleware = ImplementMiddleware({
    // don't foraward to next
    if ([action isKindOfClass:[ThunkAction class]]) {
        ThunkAction *thunk = (ThunkAction *)action;
        thunk.body(dispatch, getState);
    } else {
        next(action);
    }
    return action;
})
