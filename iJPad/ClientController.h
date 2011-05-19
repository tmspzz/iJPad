//
//  ClientController.h
//  iJPad
//
//  Created by Tommaso Piazza on 5/18/11.
//  Copyright 2011 ChalmersTH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AsyncSocket.h"
#import "TBMessageBroker.h"
#import "TBActionPassingProtocolDelegate.h"


@interface ClientController : NSObject <NSNetServiceBrowserDelegate, NSNetServiceDelegate, 
                                        AsyncSocketDelegate, TBActionPassingProtocolDelegate, TBMessageBrokerProtocolDelegate> 
{
    
    BOOL isConnected;
    NSNetServiceBrowser *_browser;
    NSNetService *_connectedService;
    NSMutableArray *_services;

    @private
    AsyncSocket *_socket;
    TBMessageBroker *_messageBroker;

}

@property (readonly, retain) NSMutableArray *services;
@property (readonly, assign) BOOL isConnected;
@property (nonatomic, retain) NSNetServiceBrowser *browser;
@property (nonatomic, retain) NSNetService *connectedService;
@property (nonatomic, retain) AsyncSocket *socket;
@property (nonatomic, retain) TBMessageBroker *messageBroker;


+ (ClientController *) sharedClientController;
- (void) search;
- (void) connect;
- (void) dealloc;

@end
