//
//  ClientController.h
//  iJPad
//
//  Created by Tommaso Piazza on 5/18/11.
//  Copyright 2011 ChalmersTH. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ClientController : NSObject <NSNetServiceBrowserDelegate, NSNetServiceDelegate> {
    
    BOOL isConnected;
    NSNetServiceBrowser *_browser;
    NSNetService *_connectedService;
    NSMutableArray *_services;

}

@property (readonly, retain) NSMutableArray *services;
@property (readonly, assign) BOOL isConnected;
@property (nonatomic, retain) NSNetServiceBrowser *browser;
@property (nonatomic, retain) NSNetService *connectedService;

+ (ClientController *) sharedClientController;
- (void) search;
- (void) connect;
-(void)dealloc;

@end
