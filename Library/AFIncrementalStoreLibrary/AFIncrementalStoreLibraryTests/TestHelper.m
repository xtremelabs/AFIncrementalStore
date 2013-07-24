//
//  TestHelper.m
//  AFIncrementalStoreLibrary
//
//  Created by Elliot Garcea on 2013-07-23.
//  Copyright (c) 2013 Xtreme Labs. All rights reserved.
//

#import "TestHelper.h"
#import "Artist.h"

@implementation TestHelper

+ (NSFetchRequest *)fetchRequest {
    return [NSFetchRequest fetchRequestWithEntityName:Artist.entityName];
}

+ (NSPredicate *)setUpComparisonPredicateWithMapping:(NSDictionary *)predicateMapping {
    __block NSMutableArray *predicateArray = [[NSMutableArray alloc] initWithCapacity:predicateMapping.count];
    
    [predicateMapping enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
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
    return predicate;
}

+ (NSPredicate *)setUpPredicateWithMapping:(NSDictionary *)predicateMapping {
    NSString *basePredicateFormat = @"%K == %@";
    NSString *compoundPredicateSeparator = @" AND ";
    __block NSMutableString *predicateFormat = [[NSMutableString alloc] init];
    __block NSMutableArray *argumentArray = [[NSMutableArray alloc] initWithCapacity:predicateMapping.count];
    [predicateMapping enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if (argumentArray.count > 1) {
            [predicateFormat appendString:compoundPredicateSeparator];
        }
        [predicateFormat appendString:basePredicateFormat];
        [argumentArray addObject:key];
        [argumentArray addObject:obj];
    }];
    return [NSPredicate predicateWithFormat:predicateFormat argumentArray:argumentArray];
}

+ (NSDictionary *)compoundArgumentMapping {
    return @{@"attribute1" : @"value1", @"attribute2" : @"value2", @"attribute3" : @"value3"};
}

+ (NSDictionary *)singleArgumentMapping {
    return @{@"attribute1" : @"value1"};
}

+ (NSPredicate *)compoundComparisonPredicate {
    NSDictionary *predicateMapping = [TestHelper compoundArgumentMapping];
    return [TestHelper setUpComparisonPredicateWithMapping:predicateMapping];
}

+ (NSPredicate *)compoundPredicate {
    NSDictionary *predicateMapping = [TestHelper compoundArgumentMapping];
    return [TestHelper setUpPredicateWithMapping:predicateMapping];
}

+ (NSPredicate *)singleComparisonPredicate {
    NSDictionary *predicateMapping = [TestHelper singleArgumentMapping];
    return [TestHelper setUpComparisonPredicateWithMapping:predicateMapping];
}

+ (NSPredicate *)singlePredicate {
    NSDictionary *predicateMapping = [TestHelper singleArgumentMapping];
    return [TestHelper setUpPredicateWithMapping:predicateMapping];
}


@end
