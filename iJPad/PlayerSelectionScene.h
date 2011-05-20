//
//  PlayerSelectionScene.h
//  iJPad
//
//  Created by Tommaso Piazza on 5/19/11.
//  Copyright 2011 ChalmersTH. All rights reserved.
//

#import "cocos2d.h"
#import "GameConfig.h"
#import "ClientControllerProtocolDelegate.h"

@interface PlayerSelectionLayer : CCLayerColor <ClientControllerProtocolDelegate>{
    CCLabelTTF *_label;
    
    
    CCMenu *_togglePlayerMenu;
    CCMenuItem *_player1Item;
    CCMenuItem *_player1ItemSel;
    CCMenuItem *_player2Item;
    CCMenuItem *_player2ItemSel;
    CCMenu *_controlMenu;
    CCMenu *_gameListMenu;
    CCMenuItem *_searchItem;
    CCMenuItemToggle *_toggleItemP1;
    CCMenuItemToggle *_toggleItemP2;
    short int selectedPlayer;
    
}
@property (nonatomic, retain) CCLabelTTF *label;
@property (nonatomic, retain) CCMenuItem *player1Item;
@property (nonatomic, retain) CCMenuItem *player2Item;
@property (nonatomic, retain) CCMenuItem *player1ItemSel;
@property (nonatomic, retain) CCMenuItem *player2ItemSel;
@property (nonatomic, retain) CCMenuItemToggle *toggleItemP1;
@property (nonatomic, retain) CCMenuItemToggle *toggleItemP2;
@property (nonatomic, retain) CCMenuItem *searchItem;
@property (nonatomic, retain) CCMenu *togglePlayerMenu;
@property (nonatomic, retain) CCMenu *controlMenu;
@property (nonatomic, retain) CCMenu *gameListMenu;


- (void) toggleButtonP1;
- (void) toggleButtonP2;
- (void) connectToGame:(id) sender;
- (void) searchForGame;
- (void) update;


@end


@interface PlayerSelectionScene : CCScene {
    
    PlayerSelectionLayer *_layer;
}

@property (nonatomic, retain) PlayerSelectionLayer* layer;

@end
