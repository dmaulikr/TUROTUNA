//
//  HelloWorldLayer.m
//  TUROTUNA
//
//  Created by mobile6 on 11. 9. 20..
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//


// Import the interfaces
#import "SplashScreen.h"

// HelloWorldLayer implementation
@implementation SplashScreen

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	SplashScreen *layer = [SplashScreen node];
	
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
	if( (self=[super initWithColor:ccc4(255, 255, 255, 255)])) {

        self.isTouchEnabled = YES;

		// create and initialize a Label
		CCLabelTTF *label = [CCLabelTTF labelWithString:@"Hello World" fontName:@"Marker Felt" fontSize:64];
		// ask director the the window size
		CGSize size = [[CCDirector sharedDirector] winSize];
		// position the label on the center of the screen
		label.position =  ccp( size.width /2 , size.height/2 );
		// add the label as a child to this Layer
		[self addChild: label];
        
        
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        CCSprite *player = [CCSprite spriteWithFile:@"Player.png" rect:CGRectMake(0, 0, 27, 40)];
        player.position = ccp(player.contentSize.width / 2, winSize.height / 2);
        [self addChild:player];
	}
	return self;
}

-(void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
}


// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}
@end