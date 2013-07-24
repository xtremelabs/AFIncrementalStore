#import "NSFetchRequest+Additions.h"

@implementation NSFetchRequest (Additions)

- (void)enumeratePredicateUsingBlock:(void (^)(NSComparisonPredicate *obj, NSUInteger idx, BOOL *stop))block NS_AVAILABLE(10_6, 4_0) {
    if ([self.predicate isKindOfClass:[NSCompoundPredicate class]]) {
        [[(NSCompoundPredicate *)self.predicate subpredicates] enumerateObjectsUsingBlock:block];
    } else if([self.predicate isKindOfClass:[NSComparisonPredicate class]]) {
        BOOL stop = NO;
        block((NSComparisonPredicate *)self.predicate, 0, &stop);
    }
}

- (NSExpression *)predicateExpressionForAttribute:(NSString *)attribute {
    __block NSExpression *rightExpression;
    [self enumeratePredicateUsingBlock:^(NSComparisonPredicate *obj, NSUInteger idx, BOOL *stop) {
        if ([obj.leftExpression.keyPath isEqualToString:attribute]) {
            rightExpression = obj.rightExpression;
            *stop = YES;
        }
    }];

    return rightExpression;
}

- (NSString *)valueForExpression:(NSExpression *)expression {
    return expression.expressionType == NSConstantValueExpressionType ? expression.constantValue : expression.keyPath;
}

- (NSDictionary *)predicateExpressionMapping {
    __block NSMutableDictionary *expressionMapping = [[NSMutableDictionary alloc] init];
    [self enumeratePredicateUsingBlock:^(NSComparisonPredicate *obj, NSUInteger idx, BOOL *stop) {
        NSString *value = [self valueForExpression:obj.rightExpression];
        NSString *key = [self valueForExpression:obj.leftExpression];
        [expressionMapping setObject:value forKey:key];
    }];
    return expressionMapping;
}

@end