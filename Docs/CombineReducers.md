## combineReducers

* [Redux的combineReducers用法说明](https://www.jianshu.com/p/6a041ad8abdb)
* [Redux的 combineReducers.js源码](https://github.com/reduxjs/redux/blob/master/src/combineReducers.js)
* [combineReducers vs reduceReducers](https://stackoverflow.com/questions/38652789/correct-usage-of-reduce-reducers/44371190#44371190)


### 使用tip

* 每一个`reducer`会根据`combineReducers`中设置的`key`在处理中获得一个独立`subState`
*  每一个`reducer`处理`subState`的时候不要返回nil
*  所有未匹配到的`action`，必须把它接收到`state`原封不动返回

### 编写Reducer

```Objective-C
Reducer SubReducer01 = ^SubState01 * (id<Action> action, SubState01 *state) {

    if (state == nil) {
    	// 需要处理nil 返回初始值
        SubState01 *nextState = [SubState01 new];
        return nextState;
    }

    if ([state isKindOfClass:[SubState01 class]]) {
        // do something
    }

    return state;
};

Reducer SubReducer02 = ^ SubState02 * (id<Action> action, SubState02 *state) {

    if (state == nil) {
    // 需要处理nil 返回初始值
        SubState02 *nextState = [SubState02 new];
        return nextState;
    }

    if ([state isKindOfClass:[SubState02 class]]) {
        // do something
    }

    return state;
};

```

### 使用combineReducers


```Objective-C
#import <Redux/Combine.h>

Reducer reducer = combineReducers(@{kSubState01: SubReducer01,
                                    kSubState02: SubReducer02,
                                    ...
                                   });
Store *store = [[Store alloc] initWithReducer:reducer
                                      state:nil
                                middlewares:@[middleware01, middleware02, ...]];


```

### 回调的地方

```Objective-C

- (void)updateState:(CombinedState *)state {
    // 依次处理每个sub state
    SubState01 subState01 = [state subStateForKey:kSubState01];
    ...
}

```

**或者如果不想回调CombinedState，可以再subscribe的时候传入transForm**，可以参见ComplexCounter Demo