//
//  Player.h
//  TUROTUNA
//
//  Created by  on 11. 9. 29..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"
#import "AEntity.h"
#import "AScene.h"
#import "PathManager.h"



@interface Player : AEntity 
{
    @private
    PathManager *playerPath;
}

- (id)initWithFile:(NSString *)filename rect:(CGRect)rect scene:(AScene *)screen;

- (PathManager *) getPath;
- (CGPoint) getPosition;
- (void)update:(ccTime)dt;

@end
