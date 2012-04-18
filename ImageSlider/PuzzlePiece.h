//
//  PuzzlePiece.h
//  ImageSlider
//
//  Created by Marc Chamly on 4/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PuzzlePiece : NSObject {
    int posX;
    int posY;
    int col;
    int row;
    int origin;
}

-(id)initWithPos: (int)posX :(int)posY :(int) origin:(int) col :(int) row ;
-(int) getCol;
-(int) getRow;
-(int) getOrigin;
-(int) getPosX;
-(void) setCol:(int) col1;
-(void) setPosX:(int) posX1;
-(void) setPosY:(int) posY1;
-(void) setOrigin:(int) origin1;
-(void) setRow:(int) row1;

@property (nonatomic, assign) int posX;
@property (nonatomic, assign) int posY;
@property (nonatomic, assign) int col;
@property (nonatomic, assign) int row;
@property (nonatomic, assign) int origin;
@end
