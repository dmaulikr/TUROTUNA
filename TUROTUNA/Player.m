//
//  Player.m
//  TUROTUNA
//
//  Created by  on 11. 9. 29..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Player.h"
#import "AEntity.h"
#import "ActionGameComportment.h"
#import "MoveGameComportment.h"

@implementation Player

@synthesize speed;

- (id)init
{
    pListName = @"AnimPlayerList";
    self = [super init];
    if (self) {
        playerPath = [[PathManager alloc] init];
        speed = 200.f;
        self.depth = 1;
    }
    
    return self;
}

- (id)initWithFile:(NSString *)filename rect:(CGRect)rect scene:(AScene*)screen
{
    self = [super initWithFile:filename rect:rect scene:screen];
    if (self)
    {
        playerPath = [[PathManager alloc]initWithScene:scene Player:self];
        [self setPosition:CGPointMake(0, 0)];
    }
    return self;
}

- (void)setSpeedByPercent:(float)percent
{	
	speed = percent;
	if (speed > 450.f)
		speed = 450.f;
	else if (speed < 50.f)
	{
		speed = 50.f;
	}
}

- (void) update:(ccTime)dt
{
    [super update:dt];
}

- (PathManager *)getPath
{
    return playerPath;
}

- (void) dealloc
{
    [playerPath release];
    [super dealloc];
}

@end
