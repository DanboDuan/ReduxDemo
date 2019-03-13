//
//  NSArray+Redux.h
//  Pods-ReduxDemo
//
//  Created by bob on 2019/2/27.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef id _Nonnull (^ReduxArrayMapOperator)(id object);
typedef NSArray * _Nonnull (^ReduxArrayMap)(ReduxArrayMapOperator mapOperator);

typedef BOOL (^ReduxArrayFilterOperator)(id object);
typedef NSArray * _Nonnull (^ReduxArrayFilter)(ReduxArrayFilterOperator filterOperator);

typedef id _Nonnull (^ReduxArrayReduceOperator)(id result, id object);
typedef id _Nonnull (^ReduxArrayReduce) (id _Nullable initialValue, ReduxArrayReduceOperator reduceOperator);

typedef NSString * _Nonnull (^ReduxArrayJoin)(NSString *sep);

typedef void (^ReduxArrayForeachOperator)(id object, NSInteger index);
typedef void (^ReduxArrayForeach)(ReduxArrayForeachOperator foreachOperator);

typedef NSArray * _Nonnull (^ReduxArrayFlatmapOperator)(id object);
typedef NSArray * _Nonnull (^ReduxArrayFlatmap) (ReduxArrayFlatmapOperator reduceOperator);


typedef NSArray * _Nonnull (^ReduxArrayApply) (NSArray<ReduxArrayMapOperator> *mapOperators);

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
