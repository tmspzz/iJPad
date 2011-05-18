//
//  HelloWorldLayer.h
//  iJPad
//
//  Created by Tommaso Piazza on 5/18/11.
//  Copyright ChalmersTH 2011. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "HUDProtocolDelegate.h"
#import "HUD.h"

// HelloWorldLayer
@interface HelloWorldLayer : CCLayer <HUDProtocolDelegate>
{
    HUD *_hud;
}

@property (nonatomic, retain) HUD *hud;

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end
