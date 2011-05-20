//
//  PlayerSelectionScene.m
//  iJPad
//
//  Created by Tommaso Piazza on 5/19/11.
//  Copyright 2011 ChalmersTH. All rights reserved.
//

#import "PlayerSelectionScene.h"
#import "ClientController.h"


@implementation PlayerSelectionScene

@synthesize layer = _layer;

- (id) init {
    
    if ((self = [super init])) {
        self.layer = [PlayerSelectionLayer node];
        [self addChild:_layer];
    }
    return self;

}

- (void)dealloc {
    
    self.layer = nil;
    [super dealloc];
}


@end


@implementation PlayerSelectionLayer

@synthesize player1Item = _player1Item;
@synthesize player2Item = _player2Item;
@synthesize player1ItemSel = _player1ItemSel;
@synthesize player2ItemSel = _player2ItemSel;
@synthesize searchItem = _searchItem;
@synthesize togglePlayerMenu = _togglePlayerMenu;
@synthesize controlMenu = _controlMenu;
@synthesize toggleItemP1 = _toggleItemP1;
@synthesize toggleItemP2 = _toggleItemP2;
@synthesize gameListMenu = _gameListMenu;

@synthesize label = _label;

- (id) init {
    
    if( (self=[super initWithColor:ccc4(0,0,0,255)] )) {
        
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        self.label = [CCLabelTTF labelWithString:@"Select Player" fontName:@"Arial" fontSize:32];
        _label.color = ccc3(255,255,255);
        _label.position = ccp(winSize.width/2, winSize.height/2);
        [self addChild:_label];
        
        selectedPlayer = 0;
        
        self.player1Item = [CCMenuItemImage itemFromNormalImage:@"Player1.png" 
                                                  selectedImage:@"Player1.png" target:nil selector:nil];
        self.player1ItemSel = [CCMenuItemImage itemFromNormalImage:@"PlayerSel.png" 
                                                     selectedImage:@"PlayerSel.png" target:nil selector:nil];
        self.player2Item = [CCMenuItemImage itemFromNormalImage:@"Player2.png" 
                                                  selectedImage:@"Player2.png" target:nil selector:nil];
        self.player2ItemSel = [CCMenuItemImage itemFromNormalImage:@"PlayerSel.png" 
                                                      selectedImage:@"PlayerSel.png" target:nil selector:nil];
        self.toggleItemP1 = [CCMenuItemToggle itemWithTarget:self 
                                                               selector:@selector(toggleButtonP1) items:_player1Item, _player1ItemSel, nil];
        self.toggleItemP2 = [CCMenuItemToggle itemWithTarget:self 
                                                                 selector:@selector(toggleButtonP2) items:_player2Item, _player2ItemSel, nil];
        self.togglePlayerMenu = [CCMenu menuWithItems:_toggleItemP1, _toggleItemP2, nil];
        //toggleMenu.position = ccp(60, 120);
        _toggleItemP1.position = ccp(-188, 0);
        _toggleItemP2.position = ccp(188, 0);
        [self addChild:_togglePlayerMenu];
        
        CCLabelTTF *searchLabel = [CCLabelTTF labelWithString:@"Search For Game" fontName:@"Arial" fontSize:22];
        searchLabel.color = ccc3(255,255,255);
        self.searchItem = [CCMenuItemLabel itemWithLabel:searchLabel target:self selector:@selector(searchForGame)];
        
        self.controlMenu = [CCMenu menuWithItems:_searchItem, nil];
        _searchItem.position = ccp(0, -64);
        
        [self addChild:_controlMenu];
        
        self.gameListMenu =  [CCMenu menuWithItems: nil];
        
        [self addChild:_gameListMenu];
    }	
    return self;
    
}

- (void) update{

    
}

#pragma mark Buttons Methods

- (void) toggleButtonP1 {

    if(_toggleItemP1.selectedItem == _player1Item){
    
        [_toggleItemP2 setIsEnabled:YES];
        
        selectedPlayer = 0; 
        _label.color = ccc3(255,0,0);
    }
    else if(_toggleItemP1.selectedItem == _player1ItemSel){
    
        [_toggleItemP2 setIsEnabled:NO];
        
        selectedPlayer = kPadP1;
        _label.color = ccc3(255,255,255);
    
    }

}

- (void) toggleButtonP2 {
    
    if(_toggleItemP2.selectedItem == _player2Item){
        
        [_toggleItemP1 setIsEnabled:YES];
        
        selectedPlayer = 0;
        _label.color = ccc3(255,0,0);
    }
    else if(_toggleItemP2.selectedItem == _player2ItemSel){
        
        [_toggleItemP1 setIsEnabled:NO];
        
        selectedPlayer = kPadP2; 
        _label.color = ccc3(255,255,255);
    }
    
}

- (void) searchForGame {
    
    [[ClientController  sharedClientController] search];
    
}


- (void) connectToGame:(id) sender {
    
    CCMenuItem *menuItem = (CCMenuItem *) sender;

    if(selectedPlayer == 0 ){
    
    _label.color = ccc3(255,0,0);
    
    } else{
        
        NSMutableArray * services = [[ClientController sharedClientController] services];
        
        [[ClientController sharedClientController] connectToService:[services objectAtIndex:menuItem.tag]];
        
    }
}

#pragma mark ClientController Delegate Methods

- (void) didFindService:(NSNetService *)aService{
    
    NSMutableArray * services = [[ClientController sharedClientController] services];
    
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    
    for(int i = 0; i < [services count] ; i++){
        
        if([[services objectAtIndex:i] isEqual:aService]){
            
            CCLabelTTF *serviceLabel = [CCLabelTTF labelWithString:aService.name fontName:@"Arial" fontSize:12];
            serviceLabel.color = ccc3(255,255,255);
        
            [_gameListMenu addChild:[CCMenuItemLabel itemWithLabel:serviceLabel target:self selector:@selector(connectToGame:)] z:0 tag:i];
            _gameListMenu.position = ccp(winSize.width/2, (winSize.height/2)-100);
        }
    
    }

}
- (void) didRemoveService:(NSNetService *)aService{
    
    
    NSMutableArray * services = [[ClientController sharedClientController] services];
    
    for(int i = 0; i < [services count] ; i++){
        
        if([[services objectAtIndex:i] isEqual:aService]){
            
            [_gameListMenu removeChildByTag:i cleanup:YES];

        }
    }
}

#pragma mark Memory Clean Up

- (void) dealloc {
    
    self.player1Item = nil;
    self.player2Item = nil;
    self.player1ItemSel = nil;
    self.player2ItemSel = nil;
    self.toggleItemP1 = nil;
    self.toggleItemP2 = nil;
    self.searchItem = nil;
    self.togglePlayerMenu = nil;
    self.controlMenu = nil;
    self.gameListMenu = nil;
    
    self.label = nil;
    [super dealloc];
}


@end

