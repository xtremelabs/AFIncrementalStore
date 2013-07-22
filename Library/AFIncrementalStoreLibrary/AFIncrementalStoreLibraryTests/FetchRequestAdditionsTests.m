//
//  PredicateAdditionsTests.m
//  Basic Example
//
//  Created by Elliot Garcea on 2013-07-22.
//
//

#import "FetchRequestAdditionsTests.h"
#import "NSFetchRequest+Additions.h"

@interface FetchRequestAdditionsTests ()
@property (nonatomic, strong) NSFetchRequest *fetchRequest;
@property (nonatomic, strong) NSDictionary *predicateMapping;
@end

@implementation FetchRequestAdditionsTests

- (void)setUpFetchRequest {
    self.fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"TestEntity"];
}

- (void)setUpPredicte {
    __block NSMutableArray *predicateArray = [[NSMutableArray alloc] initWithCapacity:self.predicateMapping.count];
    
    [self.predicateMapping enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        NSPredicate *comparisonPredicate = [NSComparisonPredicate predicateWithLeftExpression:[NSExpression expressionWithFormat:key]
                                                                              rightExpression:[NSExpression expressionWithFormat:obj]
                                                                                     modifier:NSDirectPredicateModifier
                                                                                         type:NSEqualToPredicateOperatorType
                                                                                      options:NSDiacriticInsensitivePredicateOption | NSCaseInsensitivePredicateOption];
        [predicateArray addObject:comparisonPredicate];
    }];
    
    NSPredicate *predicate = predicateArray[0];
    if (predicateArray.count > 1) {
        predicate = [[NSCompoundPredicate alloc] initWithType:NSAndPredicateType subpredicates:predicateArray];
    }
    [self.fetchRequest setPredicate:predicate];
}

- (void)setUpCompoundPredicate {
    self.predicateMapping = @{@"attribute1" : @"value1", @"attribute2" : @"value2"};
    [self setUpPredicte];
}

- (void)setUpSinglePredicate {
    self.predicateMapping = @{@"attribute1" : @"value1"};
    [self setUpPredicte];
}

- (void)setUp {
    [super setUp];
    [self setUpFetchRequest];
}

- (void)tearDown {
    self.fetchRequest = nil;
    self.predicateMapping = nil;
    
    [super tearDown];
}

- (void)predicateExpressionForAttribute {
    [self.predicateMapping enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        NSExpression *expression = [self.fetchRequest predicateExpressionForAttribute:key];
        STAssertEqualObjects((NSString *)[expression keyPath], (NSString *)obj, @"Predicate expression value does not match expected value.");
    }];
}

- (void)predicateExpressionMapping {
    NSDictionary *mapping = [self.fetchRequest predicateExpressionMapping];
    [self.predicateMapping enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        STAssertEqualObjects([mapping objectForKey:key], obj, @"Predicate expression mapping value does not match expected value.");
    }];
}

- (void)testCompoundPredicateExpressionForAttribute {
    [self setUpCompoundPredicate];
    [self predicateExpressionForAttribute];
}

- (void)testCompoundPredicateExpressionMapping {
    [self setUpCompoundPredicate];
    [self predicateExpressionMapping];
}

- (void)testSinglePredicateExpressionForAttribute {
    [self setUpSinglePredicate];
    [self predicateExpressionForAttribute];
}

- (void)testSinglePredicateExpressionMapping {
    [self setUpSinglePredicate];
    [self predicateExpressionMapping];
}

@end
