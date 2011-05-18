//
//  HUD.h
//  tommyBros
//
//  Created by Tommaso Piazza on 5/11/11.
//  Copyright 2011 ChalmersTH. All rights reserved.
//

#import "cocos2d.h"
#import "Pad.h"
#import "HUDProtocolDelegate.h"

@interface HUD : CCLayer <PadProtocolDelegate> {
    
    CCLabelTTF *_attempts;
    CCLabelTTF *_coins;
    Pad *_pad;
    CCMenu *_buttonsMenu;
    CCMenuItem *_jumpButton;
    id <HUDProtocolDelegate> delegate;
}

@property (nonatomic, retain) CCLabelTTF *attempts;
@property (nonatomic, retain) CCLabelTTF *coins;
@property (nonatomic, retain) Pad *pad;
@property (nonatomic, retain) CCMenu *buttonsMenu;
@property (nonatomic, retain) CCMenuItem *jumpButton;
@property (nonatomic, assign) id delegate;

+ (HUD *) sharedHUD;
+(id) alloc;
- (void) jumpAction;



@end
