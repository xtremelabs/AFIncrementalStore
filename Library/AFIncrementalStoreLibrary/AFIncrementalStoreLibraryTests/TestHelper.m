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

+ (NSPredicate *)setUpPredicateWithMapping:(NSDictionary *)predicateMapping {
    return nil;
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

+ (NSPredicate *)compoundComparisonPredicate {
    NSDictionary *predicateMapping = @{@"attribute1" : @"value1", @"attribute2" : @"value2"};
    return [TestHelper setUpComparisonPredicateWithMapping:predicateMapping];
}

+ (NSPredicate *)singleComparisonPredicate {
    NSDictionary *predicateMapping = @{@"attribute1" : @"value1"};
    return [TestHelper setUpComparisonPredicateWithMapping:predicateMapping];
}


@end
