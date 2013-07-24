//
//  TestHelper.h
//  AFIncrementalStoreLibrary
//
//  Created by Elliot Garcea on 2013-07-23.
//  Copyright (c) 2013 Xtreme Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface TestHelper : NSObject

+ (NSPredicate *)setUpComparisonPredicateWithMapping:(NSDictionary *)predicateMapping;

+ (NSPredicate *)setUpPredicateWithMapping:(NSDictionary *)predicateMapping;

//+ (NSPredicate *)compoundPredicate;

+ (NSPredicate *)compoundComparisonPredicate;

//+ (NSPredicate *)singlePredicate;

+ (NSPredicate *)singleComparisonPredicate;

+ (NSFetchRequest *)fetchRequest;

@end
