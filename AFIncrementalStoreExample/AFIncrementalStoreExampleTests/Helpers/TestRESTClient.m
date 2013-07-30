//
//  TestRESTClient.m
//  AFIncrementalStoreLibrary
//
//  Created by Elliot Garcea on 2013-07-23.
//  Copyright (c) 2013 Xtreme Labs. All rights reserved.
//

#import "TestRESTClient.h"

static NSString * const kExampleAPIBaseURLString = @"http://localhost:5000";

@implementation TestRESTClient

- (id)init {
    self = [self initWithBaseURL:[NSURL URLWithString:kExampleAPIBaseURLString]];
    return self;
}

- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    
    [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
    [self setDefaultHeader:@"Accept" value:@"application/json"];
    
    return self;
}

@end
