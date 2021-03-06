//
//  Ennemy.m
//  TUROTUNA
//
//  Created by  on 11. 11. 1..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Enemy.h"
#import "EnemyWeapon.h"
#import "Shuriken.h"
#import "Obstacle.h"
#import "MathUtils.h"
#import "GameScene.h"

@implementation Enemy

@synthesize pathList, isKilling;

- (id)init
{
    self = [super init];
    if (self) {
        
        isKilling = false;
        self.depth = 1;
        killable = YES;
        life = 10;
        attack = 100;
        //pListName = @"AnimEnemyList";
    }
    
    return self;
}

- (void)saveRotation:(NSNumber *)rot
{
    rotation = [rot intValue];
}

- (void)doSquare
{    
    NSMutableArray *actions = [[[NSMutableArray alloc] init] autorelease];
    
    for (NSArray *pos in pathList)
    {
        NSInteger rotate = [[pos objectAtIndex:2] intValue];
        [actions addObject:[CCRotateTo actionWithDuration:0 angle:rotate]];

        [actions addObject:[CCCallFuncO actionWithTarget:self selector:@selector(saveRotation:) object:[NSNumber numberWithInt:rotate]]];
        [actions addObject:[CCMoveTo actionWithDuration:2 position:ccp([[pos objectAtIndex:0] intValue], [[pos objectAtIndex:1] intValue])]];
    }
    
    CCRepeatForever *repeat = [CCRepeatForever actionWithAction:[CCSequence actionsWithArray:actions]];
    [self runAction:repeat];
    
}

- (id)initWithScene:(AScene*)screen path:(NSArray *)path
{    
    self = [super initWithFile:@"animationtest.png" rect:CGRectMake(0, 0, 39, 62) scene:screen];

    pathList = [[NSArray alloc] initWithArray:path];
    NSArray *tmpPos = [pathList objectAtIndex:[pathList count] - 1];
    self.position = ccp([[tmpPos objectAtIndex:0] intValue], [[tmpPos objectAtIndex:1] intValue]);
 
    [self doSquare];

    return self;
}

bool _CGRectContainsPoint2(CGRect r, CGPoint p)
{
    if (CGRectContainsPoint(r, p))
        return true;
    
    if ((p.x == r.origin.x || p.x == r.origin.x + r.size.width) && p.y >= r.origin.y && p.y <= r.origin.y + r.size.height)
        return true;
    if ((p.y == r.origin.y || p.y == r.origin.y + r.size.height) && p.x >= r.origin.x && p.x <= r.origin.x + r.size.width)
        return true;

    return false;
}

- (bool) pointIntersectsObstacle:(CGPoint)origin point2:(CGPoint)end point:(CGPoint*)intersection obstacle:(CGRect*)obstInt
{
    
    CGRect vectBound = CGRectMake(MIN(origin.x, end.x), MIN(origin.y, end.y), fabsf(end.x - origin.x), fabsf(end.y - origin.y));
    NSMutableArray *entities = [scene getEntities];

    for (int i = 0, itEnd = [entities count]; i < itEnd; ++i)
    {
        if ([[entities objectAtIndex:i] isMemberOfClass:[Obstacle class]])
        {
            CGRect obst = [(Obstacle*)[entities objectAtIndex:i] getHitbox];
            
            if (CGRectIntersectsRect(vectBound, obst) || _CGRectContainsPoint2(obst, end)) //contains does not work on sides of the rect ?
            {
                //NSLog(@"Bounding box collision detected");
                
                int intersects = 0;
                CGPoint p3, p4;
                
                //top right to bot right
                p3.x = obst.origin.x + obst.size.width;
                p3.y = obst.origin.y + obst.size.height;
                p4.x = p3.x;
                p4.y = p3.y - obst.size.height;
                intersects |= MathVectorIntersects(origin, end, p3, p4, intersection);
                
                //bot right to bot left
                p3.y = p4.y;
                p3.x = p4.x - obst.size.height;
                intersects |= MathVectorIntersects(origin, end, p4, p3, intersection) << 1;
                
                //bot left to top left
                p4.x = p3.x;
                p4.y = p3.y + obst.size.height;
                intersects |= MathVectorIntersects(origin, end, p3, p4, intersection) << 2;
                
                //top left to top right
                p3.y = p4.y;
                p3.x = p4.x + obst.size.width;
                intersects |= MathVectorIntersects(origin, end, p4, p3, intersection) << 3;
                
                if (intersects != 0 || _CGRectContainsPoint2(obst, end))
                    return true;
            }
        }
    }
    return false;
}

#define RADIANS_TO_DEGREES(radians) ((radians) * (180.0 / M_PI))

- (void) update:(ccTime)dt
{
    [super update:dt];
    
    if (!isKilling)
    {
        CGRect *obs;
        AEntity* p;

        p = [((GameScene*)(scene)) getPlayer];
        
        CGPoint cgp = CGPointMake(self.position.x - p.position.x,
                                  self.position.y - p.position.y);

        float viewAngle = RADIANS_TO_DEGREES(atan2f(cgp.y, cgp.x));
    
        if ([self pointIntersectsObstacle:self.position point2:p.position point:NULL obstacle:obs])
        return;
    
        int r;
        if (self.rotation == 0)
            r = 180;
        else if (self.rotation == 180)
            r = 0;

        if (ccpDistance([self position], [p position]) < 300 &&
            viewAngle <= r + 35 &&
            viewAngle >= r - 35)
        {
            NSLog(@"%f, %f", self.rotation, viewAngle);
            isKilling = true;
            [((GameScene*)(scene)) setCurrentComportment:MOVE_COMPORTMENT];
            EnemyWeapon *shuriTmp = [[EnemyWeapon alloc] initWithScene:scene startingPos:self.position endingPos:p.position];
            [scene addEntity:shuriTmp];
            [shuriTmp release];
            [self stopAllActions];
        }
    }
}

- (void)resultCollision:(AEntity *)entity
{
    if ([entity isKindOfClass:[Shuriken class]])
        life -= entity.attack;
}

- (void) dealloc
{
    [super dealloc];
    [pathList release];
}

@end
