//
//  FetchRequestIntegrationTests.m
//  AFIncrementalStoreLibrary
//
//  Created by Elliot Garcea on 2013-07-23.
//  Copyright (c) 2013 Xtreme Labs. All rights reserved.
//

#import "FetchRequestIntegrationTests.h"
#import "TestRESTClient.h"
#import "AFIncrementalStore.h"
#import "NSFetchRequest+Additions.h"
#import "TestHelper.h"
#import "CoreDataHelper.h"
#import <OCMock/OCMock.h>
#import <CoreData/CoreData.h>

@interface FetchRequestIntegrationTests ()

@property (nonatomic, strong) NSDictionary *argumentsDictionary;
@property (nonatomic, strong) CoreDataHelper *coreDataHelper;

@end

@implementation FetchRequestIntegrationTests

- (void)setUp {
    [super setUp];
    
    self.coreDataHelper = [[CoreDataHelper alloc] init];
}

- (void)tearDown {
    self.coreDataHelper = nil;
    self.argumentsDictionary = nil;
    
    [super tearDown];
}

- (NSMutableURLRequest *)expressionForAttribute_requestForFetchRequest:(NSFetchRequest *)fetchRequest
                                                           withContext:(NSManagedObjectContext *)context {
    [self.argumentsDictionary
     enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
         NSExpression *expression = [fetchRequest predicateExpressionForAttribute:key];
         STAssertEqualObjects(obj, [fetchRequest valueForExpression:expression], @"Predicate Expression does not match arguments dictionary value.");
     }];
    return nil;
}

- (NSMutableURLRequest *)expressionMapping_requestForFetchRequest:(NSFetchRequest *)fetchRequest
                                                      withContext:(NSManagedObjectContext *)context {
    NSDictionary *mapping = [fetchRequest predicateExpressionMapping];
    
    [mapping enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        STAssertEqualObjects(obj, self.argumentsDictionary[key], @"Arguments dictionary value does not match predicateExpressionMapping value.");
    }];
    return nil;
}

- (id)partialClientMock:(NSFetchRequest *)fetchRequest callSelector:(SEL)selector {
    id partialRESTClientMock = [OCMockObject partialMockForObject:[TestRESTClient sharedClient]];
    
    [[[partialRESTClientMock stub] andCall:selector onObject:self] requestForFetchRequest:OCMOCK_ANY withContext:OCMOCK_ANY];
    return partialRESTClientMock;
}

- (void)executeFetchRequest:(NSFetchRequest *)fetchRequest {
    NSError *error;
    
    [self.coreDataHelper.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    if (error) {
        STFail(@"FetchRequestPredicate failed: %@ %@", error, [error userInfo]);
    }
}

- (NSFetchRequest *)singleArgumentFetchRequest {
    self.argumentsDictionary = [TestHelper singleArgumentMapping];
    NSFetchRequest *fetchRequest = [TestHelper fetchRequest];
    [fetchRequest setPredicate:[TestHelper singlePredicate]];
    return fetchRequest;
}

- (NSFetchRequest *)compoundArgumentFetchRequest {
    self.argumentsDictionary = [TestHelper compoundArgumentMapping];
    NSFetchRequest *fetchRequest = [TestHelper fetchRequest];
    [fetchRequest setPredicate:[TestHelper compoundPredicate]];
    return fetchRequest;
}

#pragma mark - Integration Tests

- (void)testFetchRequestSinglePredicate_ExpressionMapping {
    NSFetchRequest *fetchRequest = [self singleArgumentFetchRequest];
    
    [self partialClientMock:fetchRequest callSelector:@selector(expressionMapping_requestForFetchRequest:withContext:)];
    [self executeFetchRequest:fetchRequest];
}

- (void)testFetchRequestCompoundPredicate_ExpressionForMapping {
    NSFetchRequest *fetchRequest = [self compoundArgumentFetchRequest];
    
    [self partialClientMock:fetchRequest callSelector:@selector(expressionMapping_requestForFetchRequest:withContext:)];
    [self executeFetchRequest:fetchRequest];
}

- (void)testFetchRequestSinglePredicate_ExpressionForAttribute {
    NSFetchRequest *fetchRequest = [self singleArgumentFetchRequest];
    
    [self partialClientMock:fetchRequest callSelector:@selector(expressionForAttribute_requestForFetchRequest:withContext:)];
    [self executeFetchRequest:fetchRequest];
}

- (void)testFetchRequestCompoundPredicate_ExpressionForAttribute {
    NSFetchRequest *fetchRequest = [self compoundArgumentFetchRequest];
    
    [self partialClientMock:fetchRequest callSelector:@selector(expressionForAttribute_requestForFetchRequest:withContext:)];
    [self executeFetchRequest:fetchRequest];
}

@end
