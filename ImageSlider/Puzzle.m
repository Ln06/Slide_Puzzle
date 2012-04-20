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
@property (nonatomic, assign) int width;
@property (nonatomic,assign) int height;
@property (nonatomic,assign) int colMax;
@property (nonatomic,assign) int rowMax;

@end



@implementation Puzzle

@synthesize width,height,puzzler,colMax,rowMax;


- (id)initWithSize:(int) colMax1:(int) rowMax1 {
    self = [super init];
    if (self) {
        colMax = colMax1;
        rowMax = rowMax1;
        width = 320/colMax; //107;
        height= 460/rowMax;//104;
        puzzler = [[NSMutableArray alloc] init];
        
    }
    return self;
}
/* Version de deplacement de view 1 a 1
 *  canBeMoved a comme paramatre une view et un puzzlepiece qui vont subbire le deplacement
 */

- (void) canBeMoved: (PuzzlePiece *) p : (UIView *) view {
    NSLog(@"can %d move?", [p getOrigin]);
    PuzzlePiece *obj = [puzzler lastObject];     //la derniere view est la view vide
    int column =(int) [obj getCol]; 
    int row = [obj getRow];
    NSLog(@"black view is %d", colMax*rowMax);
        NSLog(@"kjffnlhjkkslnfjsvbhkskj:nfknvb ");
        if(column-p.col==0 && row-p.row==1){
            NSLog(@"Yes I can be moved!");
            [self moveDown:p:view];
        }
        else if(column-p.col==0 && p.row-row==1){
            NSLog(@"Yes I can be moved!");
            [self moveUp:p:view];
        }
        else if(p.col-column==1 && row-p.row==0){
            NSLog(@"Yes I can be moved!");
            [self moveLeft:p:view];
        }
        else if(column-p.col==1 && row-p.row==0){
            NSLog(@"Yes I can be moved!");
            [self moveRight:p:view];
        }
}

/* Version de deplacement de view par bloque ou 1 a 1
 * canBeMoved a comme paramatre le tableau de view et un puzzlepiece qui a recu l'action
 * toutes les views entre la puzzlepiece et la view vide vont se deplacer vers la view vide 
 */
- (void) canBeMoved2: (PuzzlePiece *) p : (NSMutableArray *) tabView {
    NSLog(@"can %d move?", [p getOrigin]);
    PuzzlePiece *obj = [puzzler lastObject];     //la derniere view est la view vide
    int column =(int) [obj getCol]; 
    int row = [obj getRow];
    NSLog(@"black view is %d", colMax*rowMax);
    /*
     * La view vide est sur la meme colonne mais en dessou de 
     * la view ayant recu l'action
     */
    if(column-p.col==0 && row-p.row>=1){
        NSLog(@"Yes I can be moved!");
        for(id obj2 in puzzler){
            NSLog(@"object number %d",[obj2 getOrigin]);
            if([obj2 getRow]<row && [obj2 getRow]>=p.row && [obj2 getCol]==column){
               UIView *view = [tabView objectAtIndex:[obj2 getOrigin]-1];
               [self moveDown:obj2:view]; 
                NSLog(@"%d is at rowNumber %d and blackhole at rowNumber %d",[obj2 getOrigin], [obj2 getRow],[obj getRow]);
            }
        }
        
    }
    /*
     * La view vide est sur la meme colonne mais au dessu de 
     * la view ayant recu l'action
     */
    if(column-p.col==0 && p.row-row>=1){
        NSLog(@"Yes I can be moved!");
        for(id obj2 in puzzler){
            NSLog(@"object number %d",[obj2 getOrigin]);
            if([obj2 getRow]>row && [obj2 getRow]<=p.row && [obj2 getCol]==column){
                UIView *view = [tabView objectAtIndex:[obj2 getOrigin]-1];
                [self moveUp:obj2:view]; 
                NSLog(@"%d is at rowNumber %d and blackhole at rowNumber %d",[obj2 getOrigin], [obj2 getRow],[obj getRow]);
            }
        }
        
    }
    /*
     * La view vide est sur la meme ligne mais a droite de 
     * la view ayant recu l'action
     */
    if(column-p.col>=1 && row-p.row==0){
        NSLog(@"Yes I can be moved!");
        for(id obj2 in puzzler){
            NSLog(@"object number %d",[obj2 getOrigin]);
            if([obj2 getCol]<column && [obj2 getCol]>=p.col && [obj2 getRow]==row){
                UIView *view = [tabView objectAtIndex:[obj2 getOrigin]-1];
                [self moveRight:obj2:view]; 
                NSLog(@"%d is at colNumber %d and blackhole at colNumber %d",[obj2 getOrigin], [obj2 getCol],[obj getCol]);
            }
        }
        
    }
    /*
     * La view vide est sur la meme ligne mais a droite de 
     * la view ayant recu l'action
     */
    if(p.col-column>=1 && row-p.row==0){
        NSLog(@"Yes I can be moved!");
        for(id obj2 in puzzler){
            NSLog(@"object number %d",[obj2 getOrigin]);
            if([obj2 getCol]>column && [obj2 getCol]<=p.col && [obj2 getRow]==row){
                UIView *view = [tabView objectAtIndex:[obj2 getOrigin]-1];
                [self moveLeft:obj2:view]; 
                NSLog(@"%d is at colNumber %d and blackhole at colNumber %d",[obj2 getOrigin], [obj2 getCol],[obj getCol]);
            }
        }
        
    }
}/*
    else if(column-p.col==0 && p.row-row==1){
        NSLog(@"Yes I can be moved!");
        [self moveUp:p:view];
    }
    else if(p.col-column==1 && row-p.row==0){
        NSLog(@"Yes I can be moved!");
        [self moveLeft:p:view];
    }
    else if(column-p.col==1 && row-p.row==0){
        NSLog(@"Yes I can be moved!");
        [self moveRight:p:view];
    }
}*/





-(id) getPuzzler{
    return puzzler;
}

- (void) moveUp:(PuzzlePiece *) p:(UIView *) view{
    NSLog(@"%d is moving up",[p getOrigin]);
    [p setRow:p.row-1];
    [p setPosX:p.posX-height];
    [UIView animateWithDuration:0.5
                     animations:^{view.center = CGPointMake(view.center.x, view.center.y- view.frame.size.height);}];
    int rowOrigin = [[puzzler lastObject] getRow];
    [[puzzler lastObject] setRow:rowOrigin+1]; //On monte le view Blank d'un cran
}



- (void) moveDown:(PuzzlePiece *) p: (UIView *) view{
    NSLog(@"%d is moving down",[p getOrigin]);
    [p setRow:p.row+1];
    [p setPosX:p.posX+height];
    [UIView animateWithDuration:0.5
                     animations:^{view.center = CGPointMake(view.center.x, view.center.y+ view.frame.size.height);}];
    int rowOrigin = [[puzzler lastObject] getRow];
    [[puzzler lastObject] setRow:rowOrigin-1]; //On monte le view Blank d'un cran
}



- (void) moveLeft:(PuzzlePiece *) p:(UIView *) view {
    NSLog(@"%d is moving left",[p getOrigin]);
    [p setCol:p.col-1];
    [p setPosY:p.posY-width];
    [UIView animateWithDuration:0.5
                     animations:^{view.center = CGPointMake(view.center.x-view.frame.size.width, view.center.y);}];
    int colOrigin = [[puzzler lastObject] getCol];
    [[puzzler lastObject] setCol:colOrigin+1]; //On monte le view Blank d'un cran
}
- (void) moveRight:(PuzzlePiece *) p:(UIView *) view {
    NSLog(@"%d is moving right",[p getOrigin]);
    [p setCol:p.col+1];
    [p setPosY:p.posY+width];
    [UIView animateWithDuration:0.5
                     animations:^{view.center = CGPointMake(view.center.x+view.frame.size.width, view.center.y);}];
    int colOrigin = [[puzzler lastObject] getCol];
    [[puzzler lastObject] setCol:colOrigin-1]; //On monte le view Blank d'un cran
}


// Swapping 2 views by replacing their Location (posX,posY and col,row) but keeping their origin location as is
-(void) shuffle:(NSMutableArray *) tabView {
    NSLog(@"every day i'm shuffeling");
    for(id obj in puzzler){
        if([obj getOrigin] == colMax*rowMax){
            // Origin 12 is the Empty view
            NSLog(@"I'm the blank!");
        }
        else{
            //obj is the Object we want to swap
            
            //here are obj's details
            int column =(int) [obj getCol]; 
            int row = [obj getRow];
            int posX = [obj getPosX]; 
            int posY = [obj getPosY];
            int origin = [obj getOrigin];    
            
            //obj2 is the object we are swapping with
            int numberTotal = ([puzzler count] -2); 
            int n = (arc4random() % numberTotal);
            id obj2 = [puzzler objectAtIndex:n];
            
            
            //here are obj2's details
            int column2 =(int) [obj2 getCol]; 
            int row2 = [obj2 getRow];
            int posX2 = [obj2 getPosX]; 
            int posY2 = [obj2 getPosY];
            int origin2 = [obj2 getOrigin];
            
            NSLog(@"Switching %d with %d",[obj getOrigin],[obj2 getOrigin]);
            //obj takes obj2's values
            [obj setPosX:posX2];
            [obj setPosY:posY2];
            [obj setCol:column2];
            [obj setRow:row2];
            CGPoint center2 = ((UIView *)[tabView objectAtIndex:origin2-1]).center;
            CGPoint center = ((UIView *)[tabView objectAtIndex:origin-1]).center;
            
            ((UIView *)[tabView objectAtIndex:origin-1]).center = center2;
            
            //obj2 takes obj's values
            [obj2 setPosX:posX];
            [obj2 setPosY:posY];
            [obj2 setCol:column];
            [obj2 setRow:row];
            
            ((UIView *) [tabView objectAtIndex:origin2-1]).center = center;
            
        }
        
    }
    NSLog(@"I'm done");
}

-(Boolean) puzzleIsFinished{
    for(id obj in puzzler){
        int col= [obj getCol] +1;   // Colonne de la view
        int row = [obj getRow] +1 ; // Row de la view
        int origin =[obj getOrigin];// Origin de la view
        //int maxCol = 3;             // Nombre de colonne de mon puzzle
        int colMod = origin % colMax;// origin modulo nombre de colonne max pour connaitre la colonne en fonction du nombre de colonne max
        int rowDiv = (origin / colMax);// origin divise par le nombre de colonne max pour connaitre la row en fonction du nombre de colonne max
        
        
        NSLog(@"col = %d row = %d colMod = %d rowDiv = %d",col,row,colMod,rowDiv+1);
        if( colMod == col && (rowDiv +1)== row ){  // la view est a la bonne place
            NSLog(@"%d est à la bonne place",origin);
        }
        else if( colMod==0 && colMax==col && rowDiv == row){   //la view est a la bonne place en fin de colonne du tableau 
            NSLog(@"%d est à la bonne place",origin);
        }
        else{                                       // la view n'est pas a la bonne place
            NSLog(@"%d n'est pas à la bonne place",origin);
            return false;
        }
    }
    return true;
}

- (void)addViews: (PuzzlePiece *) p {
    [self.puzzler addObject:p];
}

- (void)dealloc {
    [puzzler release];
    [super dealloc];
}

@end
