//
//  PuzzlePiece.m
//  ImageSlider
//
//  Created by Marc Chamly on 4/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PuzzlePiece.h"

@implementation PuzzlePiece

@synthesize posX, posY,origin;


-(id)initWithPos: (int *) positionX :(int *) positionY :(int *) origine{
    self.posX = positionX;
    [self setPosY: positionY];
    [self setOrigin: origine];
    
    return self;
}

@end