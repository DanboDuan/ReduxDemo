//
//  AsyncAction.h
//  ReduxDemo
//
//  Created by bob on 2019/3/3.
//  Copyright © 2019 bob. All rights reserved.
//

#import <Redux/Thunk.h>

NS_ASSUME_NONNULL_BEGIN

@interface AsyncAction : ThunkAction

+ (instancetype)actionWithAction:(id<Action>)action;

@end

NS_ASSUME_NONNULL_END
