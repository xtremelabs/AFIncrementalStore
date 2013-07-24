#import <CoreData/CoreData.h>

@interface NSFetchRequest (Additions)

- (NSExpression *)predicateExpressionForAttribute:(NSString *)attribute;

- (NSDictionary *)predicateExpressionMapping;

- (NSString *)valueForExpression:(NSExpression *)expression;

@end
