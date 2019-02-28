//
//  NSArray+Redux.m
//  Pods-ReduxDemo
//
//  Created by bob on 2019/2/27.
//

#import "NSArray+Redux.h"

@implementation NSArray (Redux)


- (ReduxArrayMap) map {
    __weak NSArray* warray = self;
    return ^NSArray*(ReduxArrayMapOperator mo) {
        NSMutableArray *results = [NSMutableArray array];
        __strong NSArray *this = warray;
        for(id object in this) {
            [results addObject:mo(object)];
        }
        return [results copy];
    };
}

- (ReduxArrayFilter) filter {
    __weak NSArray* warray = self;
    return ^NSArray*(ReduxArrayFilterOperator fo) {
        __strong NSArray *this = warray;
        NSMutableArray *results = [NSMutableArray array];
        for(id object in this) {
            if(fo(object)) {
                [results addObject:object];
            }
        }
        return [results copy];
    };
}

- (ReduxArrayReduce) reduce {
    __weak NSArray* warray = self;
    return ^id(id initial, ReduxArrayReduceOperator ro) {
        __strong NSArray *array = warray;
        id result = initial;
        for(id object in array) {
            result = ro(result, object);
        }
        return result;
    };
}

- (ReduxArrayFlatmap) flatmap {
    __weak NSArray* warray = self;
    return ^NSArray*(ReduxArrayFlatmapOperator fmo) {
        NSMutableArray *results = [NSMutableArray array];
        __strong NSArray *this = warray;
        for(id object in this) {
            id newArray = fmo(object);
            if(newArray == nil) continue;
            [results addObjectsFromArray:newArray];
        }
        return [results copy];
    };
}

- (ReduxArrayApply) apply {
    __weak NSArray* warray = self;
    return ^NSArray*(NSArray* operators) {
        NSMutableArray *array = [NSMutableArray array];
        for(ReduxArrayMapOperator mo in operators) {
            __strong NSArray *this = warray;
            [array addObjectsFromArray:this.map(mo)];
        }
        return [array copy];
    };
}

- (NSArray*) reverse {
    return self.reverseObjectEnumerator.allObjects;
}

- (NSArray*) flatten {
    NSMutableArray *results = [NSMutableArray array];
    for(id obj in self) {
        if([obj isKindOfClass:[NSArray class]]) {
            [results addObjectsFromArray:((NSArray*)obj).flatten];
        } else {
            [results addObject:obj];
        }
    }
    return [results copy];
}

- (ReduxArrayJoin) join {
    __weak NSArray* warray = self;
    return ^NSString*(NSString *sep) {
        __strong NSArray *this = warray;
        return this.reduce(nil, ^id(NSString *ret, id obj){
            if(ret == nil) {
                return obj;
            } else {
                return [NSString stringWithFormat:@"%@%@%@", ret, sep, obj];
            }
        });
    };
}

- (ReduxArrayForeach) foreach {
    __weak NSArray* warray = self;
    return ^(ReduxArrayForeachOperator foreachOperator) {
        __strong NSArray *this = warray;
        for(NSInteger index = 0; index < this.count; ++index) {
            foreachOperator([this objectAtIndex:index], index);
        }
    };
}

@end
