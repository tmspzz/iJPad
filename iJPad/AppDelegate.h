//
//  AppDelegate.h
//  iJPad
//
//  Created by Tommaso Piazza on 5/18/11.
//  Copyright ChalmersTH 2011. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;

@interface AppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow			*window;
	RootViewController	*viewController;
}

@property (nonatomic, retain) UIWindow *window;

@end
