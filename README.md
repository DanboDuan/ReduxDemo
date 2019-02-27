# ReduxDemo

```
public typealias Middleware<State> = (@escaping DispatchFunction, @escaping () -> State?)
    -> (@escaping DispatchFunction) -> DispatchFunction


public typealias Middleware<State> = (@escaping DispatchFunction, @escaping () -> State?)
    -> ((@escaping DispatchFunction) -> DispatchFunction)
```