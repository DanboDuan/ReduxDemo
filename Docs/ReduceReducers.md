## reduceReducers

* [combineReducers vs reduceReducers](https://stackoverflow.com/questions/38652789/correct-usage-of-reduce-reducers/44371190#44371190)
* [Redux的reduceReducers源码](https://github.com/redux-utilities/reduce-reducers/blob/master/src/index.js)

### 使用Tip

* 所有的reducer会依次处理同样一个state
* 需要确保每个reducer处理逻辑没有问题

### 编写Reducer

```Objective-C
Reducer YourReducer01 = ^TheSameState * (id<Action> action, TheSameState *state) {

    if (state == nil) {
    // 需要处理nil 返回初始值
        TheSameState *nextState = [TheSameState new];
        return nextState;
    }

    if ([state isKindOfClass:[TheSameState class]]) {
        // do something
    }

    return state;
};
Reducer YourReducer02 = ^TheSameState * (id<Action> action, TheSameState *state) {

    if (state == nil) {
    	// 需要处理nil 返回初始值
        TheSameState *nextState = [TheSameState new];
        return nextState;
    }

    if ([state isKindOfClass:[TheSameState class]]) {
        // do something
    }

    return state;
};

```
### 使用reduceReducers

```Objective-C
#import <Redux/Reduce.h>

Reducer reducer = reduceReducers(@[YourReducer01, YourReducer02,...]);
Store *store = [[Store alloc] initWithReducer:reducer
                                      state:nil
                                middlewares:@[middleware01, middleware02, ...]];

```

### Demo

详细内容参见`Demo`中的`ReduceReducers Demo`


