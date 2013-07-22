#import <CoreData/CoreData.h>

@interface NSFetchRequest (Additions)

- (NSExpression *)predicateExpressionForAttribute:(NSString *)attribute;

- (NSDictionary *)predicateExpressionMapping;

@end
