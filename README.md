# ReduxDemo
--

参照[ReSwift](https://github.com/ReSwift/ReSwift)改写的Objective-C版本Redux。

## Swift vs Objective-C

在把[ReSwift](https://github.com/ReSwift/ReSwift)改成`Objective-C`版的过程中一些个人体验。

* Swift泛型更加强大
* Swift闭包更加强大
* 但是Swift复杂闭包嵌套可读性比较差（个人理解，不寻求认同）

## Redux

![](Docs/Img/redux_concept.png)

![](Docs/Img/redux_detail.png)

1. 单一数据源
2. State 是只读的
3. 使用纯函数来执行修改

## 使用

直接copy代码，并用你的项目前缀重命名文件、类和协议。

## Finished

* State
* Action
* Store
* Middleware

## TODO

* combineReducers
* [reduceReducers](https://github.com/redux-utilities/reduce-reducers)
* [ReSwift-Thunk](https://github.com/ReSwift/ReSwift-Thunk)
* [ReSwift-Router](https://github.com/ReSwift/ReSwift-Router)
* [ReSwift-Recorder](https://github.com/ReSwift/ReSwift-Recorder)

## 参考

1. [ReSwift](https://github.com/ReSwift/ReSwift)
2. [Redux](http://cn.redux.js.org/)

## 协议

使用 MIT 协议，详情见[LICENSE](LICENSE)文件。
