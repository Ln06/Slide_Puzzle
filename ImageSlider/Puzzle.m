//
//  Puzzle.m
//  ImageSlider
//
//  Created by Marc Chamly on 4/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Puzzle.h"
#import "PuzzlePiece.h"
#import "ImageSliderViewController.h"



@interface Puzzle()

@property (nonatomic, retain) NSMutableArray *puzzler;


@end



@implementation Puzzle

@synthesize puzzler;


- (id)init {
    self = [super init];
    if (self) {
        puzzler = [[NSMutableArray alloc] init];
        
    }
    return self;
}

- (void) canBeMoved: (PuzzlePiece *) p : (UIView *) view {
    for(id obj in puzzler){
        int column =(int) [obj getCol]; 
        int row = [obj getRow];
        int origin = [obj getOrigin];
        NSLog(@"should move");
        NSLog(@"%d",origin);
        if(origin == 12){                       // La view avec l'origine 12, est notre carre noir
            NSLog(@"origine ==12");
            if(column-p.col==0 && row-p.row==1){
                [self moveDown:p:view];
                NSLog(@"i'm in bitch");
            }
            else if(column-p.col==0 && p.row-row==1){
                [self moveUp:p:view];
            }
            else if(p.col-column==1 && row-p.row==0){
                [self moveLeft:p:view];
            }
            else if(column-p.col==1 && row-p.row==0){
                [self moveRight:p:view];
            }
            
        }
    }
}





-(id) getPuzzler{
    return puzzler;
}
- (void) moveUp:(PuzzlePiece *) p:(UIView *) view{
    NSLog(@"is moving down");
    [p setRow:p.row-1];
    [p setPosX:p.posX-104];
    [UIView animateWithDuration:1.0
                     animations:^{view.center = CGPointMake(view.center.x, view.center.y- view.frame.size.height);}];
    int rowOrigin = [[puzzler lastObject] getRow];
    [[puzzler lastObject] setRow:rowOrigin+1]; //On monte le view Blank d'un cran
}
- (void) moveDown:(PuzzlePiece *) p: (UIView *) view{
    NSLog(@"is moving down");
    [p setRow:p.row+1];
    [p setPosX:p.posX+104];
    [UIView animateWithDuration:1.0
                     animations:^{view.center = CGPointMake(view.center.x, view.center.y+ view.frame.size.height);}];
    int rowOrigin = [[puzzler lastObject] getRow];
    [[puzzler lastObject] setRow:rowOrigin-1]; //On monte le view Blank d'un cran
}
- (void) moveLeft:(PuzzlePiece *) p:(UIView *) view {
    NSLog(@"is moving down");
    [p setCol:p.col-1];
    [p setPosY:p.posY-107];
    [UIView animateWithDuration:1.0
                     animations:^{view.center = CGPointMake(view.center.x-view.frame.size.width, view.center.y);}];
    int colOrigin = [[puzzler lastObject] getCol];
    [[puzzler lastObject] setCol:colOrigin+1]; //On monte le view Blank d'un cran
}
- (void) moveRight:(PuzzlePiece *) p:(UIView *) view {
    NSLog(@"is moving down");
    [p setCol:p.col+1];
    [p setPosY:p.posY+107];
    [UIView animateWithDuration:1.0
                     animations:^{view.center = CGPointMake(view.center.x+view.frame.size.width, view.center.y);}];
    int colOrigin = [[puzzler lastObject] getCol];
    [[puzzler lastObject] setCol:colOrigin-1]; //On monte le view Blank d'un cran
}

- (void)addViews: (PuzzlePiece *) p {
    [self.puzzler addObject:p];
}

- (void)dealloc {
    [puzzler release];
    [super dealloc];
}

@end
