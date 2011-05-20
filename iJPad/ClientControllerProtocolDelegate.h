//
//  ClientControllerProtocolDelegate.h
//  iJPad
//
//  Created by Tommaso Piazza on 5/20/11.
//  Copyright 2011 ChalmersTH. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NSNetService;


@protocol ClientControllerProtocolDelegate <NSObject>
@optional
- (void) didFindService:(NSNetService *)aService;
- (void) didRemoveService:(NSNetService *)aService;

@end
