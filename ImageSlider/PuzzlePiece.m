//
//  PuzzlePiece.m
//  ImageSlider
//
//  Created by Marc Chamly on 4/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PuzzlePiece.h"

@implementation PuzzlePiece

@synthesize posX, posY,origin,col,row;


-(id)initWithPos: (int) positionX :(int) positionY :(int) origine:(int) colnum:(int) rownum{
    self.posX = positionX;
    self.col = colnum;
    self.row = rownum;
    [self setPosY: positionY];
    [self setOrigin: origine];
    
    return self;
}

-(int) getCol{
    return col;
}
-(int) getRow{
    return row;
}
-(int) getPosX{
    return posX;
}
-(int) getOrigin{
    return origin;
}

-(void) setCol:(int) col1{
    col = col1;
}
-(void) setRow:(int) row1{
    row=row1;
}
-(void) setPosX:(int) posX1{
    posX= posX1;
}
-(void) getOrigin:(int) origin1{
    origin = origin1;
}

@end