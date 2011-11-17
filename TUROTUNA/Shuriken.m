//
//  Shuriken.m
//  TUROTUNA
//
//  Created by  on 11. 11. 15..
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Shuriken.h"

@implementation Shuriken

- (id)initWithScene:(AScene*)screen startingPos:(CGPoint)start endingPos:(CGPoint)end
{
    self = [super initWithFile:@"shuriken.png" scene:screen];
    self.position = start;
    self.scale = 2;
    [self runAction:[CCRepeatForever actionWithAction:[CCRotateBy actionWithDuration:0.025 angle:30]]];
    
    return self;
}

@end
