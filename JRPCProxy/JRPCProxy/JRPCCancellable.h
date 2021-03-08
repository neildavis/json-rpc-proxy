//
//  JRPCCancellable.h
//  JRPCProxy
//
//  Created by Neil Davis on 08/03/2021.
//  Copyright © 2021 YouView. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 JRPCCancellable defines methods used to cancel a transport task
 */
@protocol JRPCCancellable <NSObject>

/*
    cancels the request and returns immediately
    Note: It is not a requirment that transports support cancellation. But it  is preferred on a 'best effort' basis
    A transport supporting cancellable requests is expected to complete with an appropriate error code in completion blocks
 */
@optional
- (void)cancel;


@end

NS_ASSUME_NONNULL_END
