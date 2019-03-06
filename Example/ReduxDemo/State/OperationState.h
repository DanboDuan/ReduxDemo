//
//  OperationState.h
//  ReduxDemo
//
//  Created by bob on 2019/3/6.
//  Copyright © 2019 bob. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Redux/Redux.h>

NS_ASSUME_NONNULL_BEGIN

@interface OperationState : NSObject<State>

@property (nonatomic, copy) NSString *operation;

@end

NS_ASSUME_NONNULL_END
