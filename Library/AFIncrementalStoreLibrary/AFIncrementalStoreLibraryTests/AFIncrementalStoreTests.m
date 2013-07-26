//
//  AFIncrementalStoreTests.m
//  AFIncrementalStoreLibrary
//
//  Created by Elliot Garcea on 2013-07-26.
//  Copyright (c) 2013 Xtreme Labs. All rights reserved.
//

#import "AFIncrementalStoreTests.h"
#import "CoreDataHelper.h"
#import "TestRESTClient.h"
#import "Artist.h"
#import <OCMock/OCMock.h>

@interface AFIncrementalStoreTests ()

@property (nonatomic, strong) CoreDataHelper *coreDataHelper;

@end

@implementation AFIncrementalStoreTests

- (void)setUp {
    [super setUp];
    
    self.coreDataHelper = [[CoreDataHelper alloc] init];
}

- (void)tearDown {
    self.coreDataHelper = nil;
    
    [super tearDown];
}

- (id)partialClientMock {
    id partialRESTClientMock = [OCMockObject partialMockForObject:[TestRESTClient sharedClient]];
    [[[partialRESTClientMock stub] andCall:@selector(requestForInsertedObject:) onObject:self] requestForInsertedObject:OCMOCK_ANY];
    [[[partialRESTClientMock stub] andCall:@selector(HTTPRequestOperationWithRequest:success:failure:) onObject:self] HTTPRequestOperationWithRequest:OCMOCK_ANY success:OCMOCK_ANY failure:OCMOCK_ANY];
    
    return partialRESTClientMock;
}

- (NSMutableURLRequest *)requestForInsertedObject:(NSManagedObject *)insertedObject {
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    return request;
}

- (AFHTTPRequestOperation *)HTTPRequestOperationWithRequest:(NSURLRequest *)urlRequest
                                                    success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                    failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:urlRequest];
    NSError *error = [NSError errorWithDomain:@"TestDomain" code:404 userInfo:@{@"TestError" : @"TestError"}];
    failure(operation, error);
    return operation;
}

- (void)testFailedInsertRequest {
    id clientMock = [self partialClientMock];
    
    [self.coreDataHelper.managedObjectContext performBlockAndWait:^{
        Artist *artist = [Artist insertInManagedObjectContext:self.coreDataHelper.managedObjectContext];
    }];
}

@end
