//
//  JRPCURLSessionTransport.h
//  JRPCProxy
//
//  Created by Neil Davis on 08/03/2021.
//  Copyright © 2021 YouView. All rights reserved.
//

#import "JRPCProxyTransport.h"

NS_ASSUME_NONNULL_BEGIN

/**
 JRPCURLSessionTransport conforms to JRPCProxyTransport and provides a simple HTTP transport using [NS]URLSession
 */
@interface JRPCURLSessionTransport : NSObject<JRPCProxyTransport>

/**
 Create the transport
 @param session An existing NSULRSession instance. If nil, the result of [NSURLSession sharedSession] will be used
 @param invocationURL The URL of the server providing the JSON-RPC service
 @return an instance of JRPCURLSessionTransport that can be passed to JRPCAbstractProxy
 */
+ (JRPCURLSessionTransport*) transportWithURLSession: (NSURLSession* _Nullable)session url:(NSURL* _Nullable)invocationURL;

/** init is unavailable */
- (instancetype) init __attribute__((unavailable("init is not available, use class factory methods")));

@end

NS_ASSUME_NONNULL_END
