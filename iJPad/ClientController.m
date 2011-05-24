//
//  ClientController.m
//  iJPad
//
//  Created by Tommaso Piazza on 5/18/11.
//  Copyright 2011 ChalmersTH. All rights reserved.
//

#import "ClientController.h"
#import "TBMessage.h"


@implementation ClientController

@synthesize services = _services;
@synthesize isConnected;
@synthesize connectedService = _connectedService;
@synthesize browser = _browser;
@synthesize socket = _socket;
@synthesize messageBroker = _messageBroker;
@synthesize delegate = _delegate;

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

-(void) connectToService:(NSNetService *) aService
{
    
    NSNetService *remoteService = aService;
    remoteService.delegate = self;
    [remoteService resolveWithTimeout:0];
    
}

-(void) search 
{
    [self.browser searchForServicesOfType:@"_tommyBros._tcp." inDomain:@""];
}

#pragma mark TBActionPassing Protocol Delegate

-(void) willSendMessageWihActionType:(int) msgActionType forPad:(int) padNumber withAction:(int) action {
    
    TBMessage *newMessage = [TBMessage messageWithActionType: msgActionType forPad:padNumber withAction:action];
    [self.messageBroker sendMessage:newMessage];
}

#pragma mark Memory Clean Up

-(void)dealloc {
    
    self.connectedService = nil;
    self.browser = nil;
    [_services release];
    self.socket = nil;
    self.messageBroker = nil;
    [super dealloc];
}

#pragma mark AsyncSocket Delegate Methods

-(BOOL)onSocketWillConnect:(AsyncSocket *)sock {
    if ( _messageBroker == nil ) {
        [sock retain];
        return YES;
    }
    return NO;
}

-(void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port {      
    
    TBMessageBroker *newBroker = [[[TBMessageBroker alloc] initWithAsyncSocket:sock] autorelease];
    [sock release];
    newBroker.delegate = self;
    self.messageBroker = newBroker;
    isConnected = YES;
}

-(void)onSocketDidDisconnect:(AsyncSocket *)sock {
    
    isConnected = NO;
}

#pragma mark Net Service Browser Delegate Methods
-(void)netServiceBrowser:(NSNetServiceBrowser *)aBrowser didFindService:(NSNetService *)aService moreComing:(BOOL)more 
{
    [_services addObject:aService];
    
    if(_delegate && [_delegate respondsToSelector:@selector(didFindService:)]){
    
        [_delegate didFindService:aService];
    }
}

-(void)netServiceBrowser:(NSNetServiceBrowser *)aBrowser didRemoveService:(NSNetService *)aService moreComing:(BOOL)more 
{
    
    if ( aService == self.connectedService ) isConnected = NO;
    
    if(_delegate && [_delegate respondsToSelector:@selector(didRemoveService:)]){
        
        [_delegate didRemoveService:aService];
    }
    
    [_services removeObject:aService];
}

#pragma mark Net Service Delegate Methods

-(void)netServiceDidResolveAddress:(NSNetService *)service 
{
    NSError *error;
    self.connectedService = service;
    self.socket = [[[AsyncSocket alloc] initWithDelegate:self] autorelease];
    NSAssert(_socket != nil, @"Failed to allocate AsyncSocket");
    [self.socket connectToAddress:service.addresses.lastObject error:&error];
   
}

-(void)netService:(NSNetService *)service didNotResolve:(NSDictionary *)errorDict 
{
    NSLog(@"Could not resolve: %@", errorDict);
}


@end
