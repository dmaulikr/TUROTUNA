//
//  AEntity.h
//  TUROTUNA
//
//  Created by  on 11. 9. 29..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"
#import "AScene.h"

#define CGPOINTEQUALS(lh, rh) lh.x == rh.x && lh.y == rh.y

@interface AEntity : CCSprite
{
    @protected
    AScene *scene;
}

@property (nonatomic) CGRect hitBox;

- (id)initWithScene:(AScene*)screen;
- (id)initWithFile:(NSString *)name rect:(CGRect)rect scene:(AScene *)screen;
- (id)initWithTexture:(CCTexture2D *)texture rect:(CGRect)rect scene:(AScene *)screen;

- (void)update:(ccTime)dt;

@end
