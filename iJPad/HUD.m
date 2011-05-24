//
//  HUD.m
//  tommyBros
//
//  Created by Tommaso Piazza on 5/11/11.
//  Copyright 2011 ChalmersTH. All rights reserved.
//

#import "HUD.h"
#import "GameConfig.h"


@implementation HUD

@synthesize attempts = _attempts;
@synthesize coins = _coins;
@synthesize pad = _pad;
@synthesize buttonsMenu = _buttonsMenu;
@synthesize jumpButton = _jumpButton;
@synthesize delegate;

static HUD *_sharedHUD = nil;

+ (HUD *)sharedHUD
{
    @synchronized([HUD class])
    {
        if (!_sharedHUD)
            [[self alloc] init];
        return _sharedHUD;
    }
    // to avoid compiler warning
    return nil;
}

+(id)alloc
{
    @synchronized([HUD class])
    {
        NSAssert(_sharedHUD == nil, @"Attempted to allocate a second instance of a singleton.");
        _sharedHUD = [super alloc];
        return _sharedHUD;
    }
    // to avoid compiler warning
    return nil;
}

-(id) init {
    
    if((self = [super init])){
    
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        self.attempts = [CCLabelTTF labelWithString:@"Attempts: 0" fontName:@"Verdana-Bold" fontSize:32];
        _attempts.position = ccp(winSize.width - _attempts.contentSize.width, winSize.height - _attempts.contentSize.height/2);
        self.coins = [CCLabelTTF labelWithString:@"Coins: 0" fontName:@"Verdana-Bold" fontSize:32];
        _coins.position = ccp(_coins.contentSize.width, winSize.height - _coins.contentSize.height/2);
        
        self.pad = [Pad padWithFile:@"padP1.png" tag:KPadNONE];
        
        self.jumpButton = [CCMenuItemImage itemFromNormalImage:@"jumpButtonN.png" selectedImage:@"jumpButtonS.png" target:self selector:@selector(jumpAction)];

        
        self.buttonsMenu = [CCMenu menuWithItems:_jumpButton, nil];
        
        _pad.delegate = self;

                
        [self addChild:_attempts];
        [self addChild:_coins];
        [self addChild:_pad];
        [self addChild:_buttonsMenu];
        
    }
    
    return self;
}

- (void) jumpAction{

    if(delegate && [delegate respondsToSelector:@selector(jumpActionForPad:)]){
        
        [delegate jumpActionForPad:kPadP1];
        
    }

}

- (void) setPadNumber:(int) padNumber {
    
    if(padNumber != KPadNONE){

    self.pad.tag = padNumber;
    
    }

}

#pragma mark PadProtocol

- (void) touchAtLocation:(CGPoint) location forPad:(Pad *)pad{
    
//    NSLog(@"Touch in Pad:%d at location X:%f Y:%f", pad.tag, location.x, location.y);
    
    if(sqrt((location.x * location.x) + (location.y * location.y)) <= kCenterTollerance) return;
    
    int dir = kDirCenter;
    
    if(location.x > 0){
        
        float ratio = (location.y/location.x);
        float atan = atanf(ratio);
        
        if( atan > M_PI/3) dir = kDirUp;
        if( atan < -M_PI/3 ) dir = kDirDown;
        if( atan >= M_PI/6 && atan <=  M_PI/3 ) dir = kDirDiagRightUp;
        if( atan <= -M_PI/6 && atan >= -M_PI/3 ) dir = kDirDiagRightDown;
        if( atan < M_PI/6 && atan > -M_PI/6 ) dir = kDirRight;
        
//        NSLog(@"Dir is: %d, atan is %f ratio is:%f", dir, atan, ratio);
        
    }
    
    if(location.x < 0){
        
        float ratio = (location.y/-location.x);
        float atan = atanf(ratio);
        
        if( atan > M_PI/3) dir = kDirUp;
        if( atan < -M_PI/3 ) dir = kDirDown;
        if( atan >= M_PI/6 && atan <=  M_PI/3 ) dir = kDirDiagLeftUp;
        if( atan <= -M_PI/6 && atan >= -M_PI/3 ) dir = kDirDiagLeftDown;
        if( atan < M_PI/6 && atan > -M_PI/6 ) dir = kDirLeft;
        
//        NSLog(@"Dir is: %d, atan is %f ratio is:%f", dir, atan, ratio);
        
    }
    

    if(delegate && [delegate respondsToSelector:@selector(direction: forPad:)]){
            
        [delegate direction:dir forPad:pad.tag];
    
    }
        
 
    
}

- (void) touchLiftedForPad:(Pad *) pad {
    
    
    if(delegate && [delegate respondsToSelector:@selector(direction: forPad:)]){
        
        [delegate direction:kDirCenter forPad:pad.tag];
        
    }

    
}


- (void) dealloc {

    self.attempts = nil;
    self.coins = nil;
    self.pad = nil;
    self.buttonsMenu = nil;
    self.jumpButton = nil;
    
    [super dealloc];

}

@end
