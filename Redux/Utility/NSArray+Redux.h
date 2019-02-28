//
//  NSArray+Redux.h
//  Pods-ReduxDemo
//
//  Created by bob on 2019/2/27.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef id (^ReduxArrayMapOperator)(id object);
typedef NSArray* (^ReduxArrayMap)(ReduxArrayMapOperator mapOperator);

typedef BOOL (^ReduxArrayFilterOperator)(id object);
typedef NSArray* (^ReduxArrayFilter)(ReduxArrayFilterOperator filterOperator);

typedef id (^ReduxArrayReduceOperator)(id result, id object);
typedef id (^ReduxArrayReduce) (id _Nullable initialValue, ReduxArrayReduceOperator reduceOperator);

typedef NSString*(^ReduxArrayJoin)(NSString *sep);

typedef void (^ReduxArrayForeachOperator)(id object, NSInteger index);
typedef void (^ReduxArrayForeach)(ReduxArrayForeachOperator foreachOperator);

typedef NSArray* (^ReduxArrayFlatmapOperator)(id object);
typedef NSArray* (^ReduxArrayFlatmap) (ReduxArrayFlatmapOperator reduceOperator);


typedef NSArray* (^ReduxArrayApply) (NSArray<ReduxArrayMapOperator> *mapOperators);

@interface NSArray (Redux)

/**
 * Functor
 */
@property (readonly) ReduxArrayMap map;

/**
 * Monad
 */
@property (readonly) ReduxArrayFlatmap flatmap;

/**
 * Applicative
 */
@property (readonly) ReduxArrayApply apply;

@property (readonly) ReduxArrayFilter filter;

@property (readonly) NSArray* reverse;

@property (readonly) NSArray* flatten;

@property (readonly) ReduxArrayReduce reduce;

@property (readonly) ReduxArrayJoin join;

@property (readonly) ReduxArrayForeach foreach;


@end

NS_ASSUME_NONNULL_END
