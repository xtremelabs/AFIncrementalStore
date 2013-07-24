//
//  TestRESTClient.h
//  AFIncrementalStoreLibrary
//
//  Created by Elliot Garcea on 2013-07-23.
//  Copyright (c) 2013 Xtreme Labs. All rights reserved.
//

#import "AFRESTClient.h"

@interface TestRESTClient : AFRESTClient <AFIncrementalStoreHTTPClient>

+ (TestRESTClient *)sharedClient;

@end
