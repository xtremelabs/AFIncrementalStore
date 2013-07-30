//
//  AFIncrementalStoreExampleTests.m
//  AFIncrementalStoreExampleTests
//
//  Created by Elliot Garcea on 2013-07-30.
//  Copyright (c) 2013 Xtreme Labs. All rights reserved.
//

#import "Kiwi.h"
#import "CoreDataHelper.h"
#import "Artist.h"
#import "TestRESTClient.h"
#import "AFIncrementalStoreExampleTests.h"

@implementation AFIncrementalStoreExampleTests

+ (void)insertNewArtistIntoCoreDataWithDictionary:(NSDictionary *)dict coreDataHelper:(CoreDataHelper *)coreDataHelper {
    [coreDataHelper.managedObjectContext performBlockAndWait:^{
        Artist *artist = [Artist insertInManagedObjectContext:coreDataHelper.managedObjectContext];
        [artist setValuesForKeysWithDictionary:dict];
        NSError *error;
        if(![coreDataHelper.managedObjectContext save:&error]) {
            fail(@"Managed object context save failed: %@ %@", error, error.userInfo);
        }
    }];
}

@end


SPEC_BEGIN(AFIncrementalStoreSpec)

describe(@"AFIncrementalStore Insert", ^{
    context(@"when used to insert new object into Core Data", ^{
        
        static NSString * const kExampleAPIBaseURLString = @"http://localhost:5000";
        
        __block CoreDataHelper *coreDataHelper;
        __block id incrementalStoreMock;
        __block AFRESTClient *RESTClientMock;
        
        beforeEach(^{
            RESTClientMock = [KWMock partialMockForObject:[[AFRESTClient alloc] initWithBaseURL:[NSURL URLWithString:kExampleAPIBaseURLString]]];
            [AFIncrementalStore stub:@selector(type) withBlock:^id(NSArray *params) {
                NSString *test = NSStringFromClass([AFIncrementalStore class]);
                return test;
            }];
            
            [AFIncrementalStore stub:@selector(model) withBlock:^id(NSArray *params) {
                return [[NSManagedObjectModel alloc] initWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"IncrementalStoreExample" withExtension:@"xcdatamodeld"]];
            }];
            
            [AFIncrementalStore stub:@selector(initialize) withBlock:^id(NSArray *params) {
                [NSPersistentStoreCoordinator registerStoreClass:self forStoreType:[AFIncrementalStore type]];
                return nil;
            }];
            coreDataHelper = [[CoreDataHelper alloc] init];
            
            [coreDataHelper.persistentStoreCoordinator.persistentStores enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                if ([obj isKindOfClass:[NSIncrementalStore class]]) {
                    incrementalStoreMock = [KWMock partialMockForObject:obj];
                    [incrementalStoreMock setHTTPClient:RESTClientMock];
                }
            }];
        });
        
        afterEach(^{
            coreDataHelper = nil;
        });
        
        it(@"should insert the object in the Core Data database", ^{
            NSString *artistDescription = @"New Artist Description";
            [AFIncrementalStoreExampleTests insertNewArtistIntoCoreDataWithDictionary:@{@"artistDescription" : artistDescription} coreDataHelper:coreDataHelper];            
            __block NSArray *results;
            [coreDataHelper.managedObjectContext performBlockAndWait:^{
                NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:Artist.entityName];
                request.predicate = [NSPredicate predicateWithFormat:@"%K == %@", ArtistAttributes.artistDescription, artistDescription];
                NSError *error;
                results = [coreDataHelper.managedObjectContext executeFetchRequest:request error:&error];
            }];
            
            [[[(Artist *)results.lastObject artistDescription] should] equal:artistDescription];
        });
        
        
        it(@"should perform remote PUT operation to reflect the insert on the server", ^{
            NSString *artistDescription = @"New Artist Description";
            [[incrementalStoreMock should] receive:@selector(executeSaveChangesRequest:withContext:error:) withArguments:any(), any(), any()];
            [AFIncrementalStoreExampleTests insertNewArtistIntoCoreDataWithDictionary:@{@"artistDescription" : artistDescription} coreDataHelper:coreDataHelper];
        });
//
//        it(@"should store objectID if network operation fails", ^{
//            fail(@"UNTESTED");
//        });
    });
});

SPEC_END
