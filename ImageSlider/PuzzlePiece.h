//
//  PuzzlePiece.h
//  ImageSlider
//
//  Created by Marc Chamly on 4/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PuzzlePiece : NSObject {
    int *posX;
    int *posY;
    int *origin;
}

-(id)initWithPos: (int *)posX :(int *)posY :(int *) origin;


@property (nonatomic, assign) int *posX;
@property (nonatomic, assign) int *posY;
@property (nonatomic, assign) int *origin;
@end

//