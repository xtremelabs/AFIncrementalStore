//
//  FetchRequestIntegrationTests.m
//  AFIncrementalStoreLibrary
//
//  Created by Elliot Garcea on 2013-07-23.
//  Copyright (c) 2013 Xtreme Labs. All rights reserved.
//

#import "FetchRequestIntegrationTests.h"
#import "TestIncrementalStore.h"
#import "TestRESTClient.h"
#import "AFIncrementalStore.h"
#import "NSFetchRequest+Additions.h"
#import "TestHelper.h"
#import <OCMock/OCMock.h>
#import <CoreData/CoreData.h>

@interface FetchRequestIntegrationTests ()

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (nonatomic, strong) NSDictionary *argumentsDictionary;

@end

@implementation FetchRequestIntegrationTests

@synthesize managedObjectContext = __managedObjectContext;
@synthesize managedObjectModel = __managedObjectModel;
@synthesize persistentStoreCoordinator = __persistentStoreCoordinator;

- (void)saveContext {
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

#pragma mark - Core Data Setup

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext {
    if (__managedObjectContext != nil) {
        return __managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    
    if (coordinator != nil) {
        __managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        [__managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    
    return __managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel {
    if (__managedObjectModel != nil) {
        return __managedObjectModel;
    }
    
    NSURL *modelURL = [[NSBundle bundleForClass:NSClassFromString(@"FetchRequestIntegrationTests")] URLForResource:@"IncrementalStoreExample" withExtension:@"momd"];
    __managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    
    return __managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if (__persistentStoreCoordinator != nil) {
        return __persistentStoreCoordinator;
    }
    
    __persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    
    AFIncrementalStore *incrementalStore = (AFIncrementalStore *)[__persistentStoreCoordinator addPersistentStoreWithType:[TestIncrementalStore type] configuration:nil URL:nil options:nil error:nil];
    NSError *error = nil;
    
    if (![incrementalStore.backingPersistentStoreCoordinator addPersistentStoreWithType:NSInMemoryStoreType configuration:nil URL:nil options:nil error:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return __persistentStoreCoordinator;
}

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    self.managedObjectContext = nil;
    self.managedObjectModel = nil;
    self.persistentStoreCoordinator = nil;
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
    
    [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
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
