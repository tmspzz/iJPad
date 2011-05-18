//
//  ClientController.m
//  iJPad
//
//  Created by Tommaso Piazza on 5/18/11.
//  Copyright 2011 ChalmersTH. All rights reserved.
//

#import "ClientController.h"


@implementation ClientController

@synthesize services = _services;
@synthesize isConnected;
@synthesize connectedService = _connectedService;
@synthesize browser = _browser;

static ClientController *_sharedClientController = nil;

+ (ClientController *) sharedClientController
{
    @synchronized([ClientController class])
    {
        if (!_sharedClientController)
            [[self alloc] init];
        return _sharedClientController;
    }
    // to avoid compiler warning
    return nil;
}

+(id)alloc
{
    @synchronized([ClientController class])
    {
        NSAssert(_sharedClientController == nil, @"Attempted to allocate a second instance of a singleton.");
        _sharedClientController = [super alloc];
        return _sharedClientController;
    }
    // to avoid compiler warning
    return nil;
}

- (id) init 
{
    _services = [NSMutableArray new];
    self.browser = [[NSNetServiceBrowser new] autorelease];
    self.browser.delegate = self;
    isConnected = NO;
    
    return self;

}


#pragma mark Instance Methods

-(void) connect
{
    
    NSNetService *remoteService = [_services lastObject];
    remoteService.delegate = self;
    [remoteService resolveWithTimeout:0];
    
}

-(void) search 
{
    [self.browser searchForServicesOfType:@"_tommyBros._tcp." inDomain:@""];
}

#pragma mark Memory Clean Up

-(void)dealloc {
    self.connectedService = nil;
    self.browser = nil;
    [_services release];
    [super dealloc];
}

#pragma mark Net Service Browser Delegate Methods
-(void)netServiceBrowser:(NSNetServiceBrowser *)aBrowser didFindService:(NSNetService *)aService moreComing:(BOOL)more 
{
    [_services addObject:aService];
}

-(void)netServiceBrowser:(NSNetServiceBrowser *)aBrowser didRemoveService:(NSNetService *)aService moreComing:(BOOL)more 
{
    [_services removeObject:aService];
    if ( aService == self.connectedService ) isConnected = NO;
}

#pragma mark Net Service Delegate Methods

-(void)netServiceDidResolveAddress:(NSNetService *)service 
{
    isConnected = YES;
    self.connectedService = service;
}

-(void)netService:(NSNetService *)service didNotResolve:(NSDictionary *)errorDict 
{
    NSLog(@"Could not resolve: %@", errorDict);
}


@end
