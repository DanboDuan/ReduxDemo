## TODO

* [combineReducers vs reduceReducers](https://stackoverflow.com/questions/38652789/correct-usage-of-reduce-reducers/44371190#44371190)

```
/**
 * Schedules actions with { meta: { delay: N } } to be delayed by N milliseconds.
 * Makes `dispatch` return a function to cancel the interval in this case.
 */
const timeoutScheduler = store => next => action => {
  if (!action.meta || !action.meta.delay) {
    return next(action);
  }

  let intervalId = setTimeout(
    () => next(action),
    action.meta.delay
  );

  return function cancel() {
    clearInterval(intervalId);
  };
};

```