## combineReducers

* [Redux的combineReducers用法说明](https://www.jianshu.com/p/6a041ad8abdb)
* [Redux的 combineReducers.js源码](https://github.com/reduxjs/redux/blob/master/src/combineReducers.js)
* [combineReducers vs reduceReducers](https://stackoverflow.com/questions/38652789/correct-usage-of-reduce-reducers/44371190#44371190)


### combineReducers 设计原则

1. 所有未匹配到的 action，必须把它接收到的第一个参数也就是那个 state 原封不动返回。
2. 永远不能返回 undefined。当过早 return 时非常容易犯这个错误，为了避免错误扩散，遇到这种情况时 combineReducers 会抛异常。
3. 如果传入的 state 就是 undefined，一定要返回对应 reducer 的初始 state。根据上一条规则，初始 state 禁止使用 undefined。
4. 虽然 combineReducers 自动帮你检查 reducer 是否符合以上规则，但你也应该牢记，并尽量遵守。

### tip
* both reducers get their own piece of state to work with


```JavaScript
function combindReducer(reducers) {
    // 第一个只是先过滤一遍 把非function的reducer过滤掉
  const reducerKeys = Object.keys(reducers)
  const finalReducers = {}
  reducerKeys.forEach((key) => {
      if(typeof reducers[key] === 'function') {
      finalReducers[key] = reducers[key]
      } 
  })
  const finalReducersKeys = Object.keys(finalReducers)
    // 第二步比较重要 就是将所有reducer合在一起
    // 根据key调用每个reducer，将他们的值合并在一起
    let hasChange = false;
    const nextState = {};
    return function combind(state={}, action) {
        finalReducersKeys.forEach((key) => {
          // 第一步先获取目前的state[key]，所以说传入reducer的key === store的key
            const previousValue = state[key];
            // 就用reducer[key]来处理，得到下一个状态
            const nextValue = reducers[key](previousValue, action);
            // 根据key更新store的值
            nextState[key] = nextValue;
            hasChange = hasChange || previousValue !== nextValue
        })
        // 如果整个循环都没有被更新过，返回state
        return hasChange ? nextState : state;
    }
}


```
