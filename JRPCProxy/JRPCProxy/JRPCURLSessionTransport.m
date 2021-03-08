//
//  JRPCURLSessionTransport.m
//  JRPCProxy
//
//  Created by Neil Davis on 08/03/2021.
//  Copyright © 2021 YouView. All rights reserved.
//

#import "JRPCURLSessionTransport.h"

@interface NSURLSessionDataTask (JRPCCancellable)<JRPCCancellable>
@end

@interface JRPCURLSessionTransport()

@property (nonatomic, strong) NSURLSession *urlSession;
@property (nonatomic, strong, nullable) NSURL *invocationURL;

@end

@implementation JRPCURLSessionTransport

+ (JRPCURLSessionTransport*) transportWithURLSession:(NSURLSession* _Nullable)session url:(NSURL* _Nullable)invocationURL {
    return [[[self class] alloc] initWithURLSession:session url:invocationURL];
}

#pragma mark - JRPCProxyTransport

- (id<JRPCCancellable>) sendJSONRPCPayloadWithRequestData:(NSData*)payload
                           completionQueue:(dispatch_queue_t __nullable)completionQueue
                                               completion:(JRPCTransportDataCompletion)completion {
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:self.invocationURL];
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    request.HTTPMethod = @"POST";
    request.HTTPBody = payload;
    NSURLSessionDataTask *task = [self.urlSession dataTaskWithRequest:[request copy]
                                                    completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        dispatch_queue_t dispatchQueue = completionQueue ?: dispatch_get_main_queue();
        dispatch_async(dispatchQueue, ^{
            completion(data, error);
        });
     }];
    [task resume];
    return task;
}

#pragma mark - Private

- (id) initWithURLSession:(NSURLSession* _Nullable)session url:(NSURL* _Nullable)invocationURL {
    self = [super init];
    if (self) {
        self.urlSession = session ?: [NSURLSession sharedSession];
        self.invocationURL = invocationURL;
    }
    return self;
}


@end
