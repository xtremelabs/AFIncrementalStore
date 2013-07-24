//
//  PredicateAdditionsTests.m
//  Basic Example
//
//  Created by Elliot Garcea on 2013-07-22.
//
//

#import "FetchRequestAdditionsTests.h"
#import "NSFetchRequest+Additions.h"
#import "TestHelper.h"

@interface FetchRequestAdditionsTests ()
@property (nonatomic, strong) NSFetchRequest *fetchRequest;
@property (nonatomic, strong) NSDictionary *predicateMapping;
@end

@implementation FetchRequestAdditionsTests

- (void)setUpFetchRequest {
    self.fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"TestEntity"];
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

- (void)predicateExpressionMappingForFetchRequest:(NSFetchRequest *)request {
    NSDictionary *mapping = [request predicateExpressionMapping];
    [self.predicateMapping enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        STAssertEqualObjects([mapping objectForKey:key], obj, @"Predicate expression mapping value does not match expected value.");
    }];
}

- (void)testCompoundPredicateExpressionForAttribute {
    NSPredicate *predicate = [TestHelper compoundComparisonPredicate];
    [self.fetchRequest setPredicate:predicate];
    [self predicateExpressionForAttribute];
}

- (void)testCompoundPredicateExpressionMapping {
    NSPredicate *predicate = [TestHelper compoundComparisonPredicate];
    [self.fetchRequest setPredicate:predicate];
    [self predicateExpressionMappingForFetchRequest:self.fetchRequest];
}

- (void)testSinglePredicateExpressionForAttribute {
    NSPredicate *predicate =[TestHelper singleComparisonPredicate];
    [self.fetchRequest setPredicate:predicate];
    [self predicateExpressionForAttribute];
}

- (void)testSinglePredicateExpressionMapping {
    NSPredicate *predicate = [TestHelper singleComparisonPredicate];
    [self.fetchRequest setPredicate:predicate];
    [self predicateExpressionMappingForFetchRequest:self.fetchRequest];
}

@end
