//
//  HelloWorldLayer.m
//  iJPad
//
//  Created by Tommaso Piazza on 5/18/11.
//  Copyright ChalmersTH 2011. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"
#import "HUD.h"
#import "GameConfig.h"

// HelloWorldLayer implementation
@implementation HelloWorldLayer

@synthesize hud = _hud;
@synthesize delegate = _delegate;

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
    
    HUD *hud = [HUD sharedHUD];
    
	[scene addChild:hud z:10];
	
	// 'layer' is an autorelease object.
	HelloWorldLayer *layer = [HelloWorldLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
    
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) {
        
        CGSize winSize = [[CCDirector sharedDirector] winSize];
		
        self.hud = [HUD sharedHUD];
        _hud.delegate = self;
        
        _hud.pad.position = ccp(128-16, 128+32);
        _hud.jumpButton.position = ccp(192, 0);
        _hud.coins.position = ccp(128, winSize.height-32);
        _hud.attempts.position = ccp(winSize.width-128, winSize.height-32);

	}
	return self;
}

#pragma mark HUD Protocol

- (void) jumpActionForPad:(const int)padNumber{
    
    if(_delegate && [_delegate respondsToSelector:@selector(willSendMessageWihActionType: forPad: withAction:)]){
        
        [_delegate willSendMessageWihActionType:kActionTypeButton forPad:padNumber withAction:kActionJump];
        
    }

    
}

-(void) direction:(const int)direction forPad:(const int)pad{
    
    if(_delegate && [_delegate respondsToSelector:@selector(willSendMessageWihActionType: forPad: withAction:)]){
        
        [_delegate willSendMessageWihActionType:kActionTypeButton forPad:pad withAction:direction];
        
    }

}


// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
    
    self.hud = nil;
	
	// don't forget to call "super dealloc"
	[super dealloc];
}
@end
