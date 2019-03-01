//
//  Logger.m
//  ReduxDemo
//
//  Created by bob on 2019/2/28.
//  Copyright © 2019 bob. All rights reserved.
//

#import "Logger.h"

Middleware ActionLogger = ImplementMiddleware({
    printf("\nACTION %s\n", [action description].UTF8String);
    next(action);
    return action;
})


Middleware StateLogger = ImplementMiddleware({
    next(action);
    printf("\nSTATE %s\n", [getState() description].UTF8String);
    return action;
})
