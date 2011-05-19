//
//  PlayerSelectionScene.m
//  iJPad
//
//  Created by Tommaso Piazza on 5/19/11.
//  Copyright 2011 ChalmersTH. All rights reserved.
//

#import "PlayerSelectionScene.h"


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
@synthesize connectItem = _connectItem;
@synthesize togglePlayerMenu = _togglePlayerMenu;
@synthesize controlMenu = _controlMenu;

@synthesize label = _label;

- (id) init {
    
    if( (self=[super initWithColor:ccc4(0,0,0,255)] )) {
        
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        self.label = [CCLabelTTF labelWithString:@"Select Player" fontName:@"Arial" fontSize:32];
        _label.color = ccc3(255,255,255);
        _label.position = ccp(winSize.width/2, winSize.height/2);
        [self addChild:_label];
        
        self.player1Item = [CCMenuItemImage itemFromNormalImage:@"Player1.png" 
                                                  selectedImage:@"Player1.png" target:nil selector:nil];
        self.player1ItemSel = [CCMenuItemImage itemFromNormalImage:@"PlayerSel.png" 
                                                     selectedImage:@"PlayerSel.png" target:nil selector:nil];
        self.player2Item = [CCMenuItemImage itemFromNormalImage:@"Player2.png" 
                                                  selectedImage:@"Player2.png" target:nil selector:nil];
        self.player2ItemSel = [CCMenuItemImage itemFromNormalImage:@"PlayerSel.png" 
                                                      selectedImage:@"PlayerSel.png" target:nil selector:nil];
        CCMenuItemToggle *toggleItemP1 = [CCMenuItemToggle itemWithTarget:self 
                                                               selector:nil items:_player1Item, _player1ItemSel, nil];
        CCMenuItemToggle *toggleItemP2 = [CCMenuItemToggle itemWithTarget:self 
                                                                 selector:nil items:_player2Item, _player2ItemSel, nil];
        CCMenu *toggleMenu = [CCMenu menuWithItems:toggleItemP1, toggleItemP2, nil];
        //toggleMenu.position = ccp(60, 120);
        toggleItemP1.position = ccp(-188, 0);
        toggleItemP2.position = ccp(188, 0);
        [self addChild:toggleMenu];
        
        
        
    }	
    return self;
    
}

- (void) dealloc {
    
    self.player1Item = nil;
    self.player2Item = nil;
    self.player1ItemSel = nil;
    self.player2ItemSel = nil;
    self.connectItem = nil;
    self.togglePlayerMenu = nil;
    self.controlMenu = nil;
    
    self.label = nil;
    [super dealloc];
}


@end

