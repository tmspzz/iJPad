//
//  PlayerSelectionScene.h
//  iJPad
//
//  Created by Tommaso Piazza on 5/19/11.
//  Copyright 2011 ChalmersTH. All rights reserved.
//

#import "cocos2d.h"


@interface PlayerSelectionLayer : CCLayerColor {
    CCLabelTTF *_label;
    
    
    CCMenu *_togglePlayerMenu;
    CCMenuItem *_player1Item;
    CCMenuItem *_player1ItemSel;
    CCMenuItem *_player2Item;
    CCMenuItem *_player2ItemSel;
    CCMenu *_controlMenu;
    CCMenuItem *_connectItem;
    
}
@property (nonatomic, retain) CCLabelTTF *label;
@property (nonatomic, retain) CCMenuItem *player1Item;
@property (nonatomic, retain) CCMenuItem *player2Item;
@property (nonatomic, retain) CCMenuItem *player1ItemSel;
@property (nonatomic, retain) CCMenuItem *player2ItemSel;
@property (nonatomic, retain) CCMenuItem *connectItem;
@property (nonatomic, retain) CCMenu *togglePlayerMenu;
@property (nonatomic, retain) CCMenu *controlMenu;


@end


@interface PlayerSelectionScene : CCScene {
    
    PlayerSelectionLayer *_layer;
}

@property (nonatomic, retain) PlayerSelectionLayer* layer;

@end
