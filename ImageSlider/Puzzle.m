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

- (void)dealloc {
    [puzzler release];
    [super dealloc];
}



/* Deplacement de view par bloc ou 1 a 1
 * canBeMoved a comme paramatre le tableau de view et un puzzlepiece qui a recu l'action
 * toutes les views entre la puzzlepiece et la view vide vont se deplacer vers la view vide 
 */
- (NSMutableArray *) canBeMoved2: (PuzzlePiece *) p{
    NSMutableArray *tabViews = [[[NSMutableArray alloc]init ]autorelease];
    PuzzlePiece *obj = [puzzler lastObject];     //la derniere view est la view vide
    int column =(int) [obj getCol]; 
    int row = [obj getRow];
    NSLog(@"black view is %d", colMax*rowMax);
    
    /*
     * La view vide est sur la meme colonne mais en dessou de 
     * la view ayant recu l'action
     */
    if(column-p.col==0 && row-p.row>=1){   // permet de verifié qu'on doit se deplacer vers le bas
        NSLog(@"Yes I can be moved!");
        for(id obj2 in puzzler){
            NSLog(@"object number %d",[obj2 getOrigin]);
            if([obj2 getRow]<row && [obj2 getRow]>=p.row && [obj2 getCol]==column){  //permet d'identifier toute les views a deplacer sur le chemin
              // UIView *view = [tabView objectAtIndex:[obj2 getOrigin]-1];
                NSNumber *loc = [[NSNumber alloc] initWithInt:[obj2 getOrigin]-1];
                NSString *mov = [[NSString alloc] initWithString:@"Down"];
                [tabViews  addObject:mov];
                [tabViews addObject:loc];
                [loc release];
                [mov release];
                [self moveDown:obj2]; 
                NSLog(@"%d is at rowNumber %d and blackhole at rowNumber %d",[obj2 getOrigin], [obj2 getRow],[obj getRow]);
                
            }
        }
        return tabViews;
    }
    /*
     * La view vide est sur la meme colonne mais au dessu de 
     * la view ayant recu l'action
     */
    if(column-p.col==0 && p.row-row>=1){ // permet de verifié qu'on doit se deplacer vers le haut
        NSLog(@"Yes I can be moved!");
        for(id obj2 in puzzler){
            NSLog(@"object number %d",[obj2 getOrigin]);
            if([obj2 getRow]>row && [obj2 getRow]<=p.row && [obj2 getCol]==column){  //permet d'identifier toute les views a deplacer sur le chemin
                //UIView *view = [tabView objectAtIndex:[obj2 getOrigin]-1];
                NSNumber *loc = [[[NSNumber alloc] initWithInt:[obj2 getOrigin]-1] autorelease];
                NSString *mov = @"Up";
                [tabViews addObject:mov];
                [tabViews addObject:loc];
                [self moveUp:obj2]; 
                NSLog(@"%d is at rowNumber %d and blackhole at rowNumber %d",[obj2 getOrigin], [obj2 getRow],[obj getRow]);
            }
        }
        return tabViews;
        
    }
    /*
     * La view vide est sur la meme ligne mais a droite de 
     * la view ayant recu l'action
     */
    if(column-p.col>=1 && row-p.row==0){    // permet de verifié qu'on doit se deplacer vers la droite
        NSLog(@"Yes I can be moved!");
        for(id obj2 in puzzler){
            NSLog(@"object number %d",[obj2 getOrigin]);
            if([obj2 getCol]<column && [obj2 getCol]>=p.col && [obj2 getRow]==row){ //permet d'identifier toute les views a deplacer sur le chemin
                //UIView *view = [tabView objectAtIndex:[obj2 getOrigin]-1];
                NSNumber *loc = [[[NSNumber alloc] initWithInt:[obj2 getOrigin]-1] autorelease];
                NSString *mov = @"Right";
                [tabViews addObject:mov];
                [tabViews addObject:loc];
                [self moveRight:obj2]; 
                NSLog(@"%d is at colNumber %d and blackhole at colNumber %d",[obj2 getOrigin], [obj2 getCol],[obj getCol]);
            }
        }
        return tabViews;
        
    }
    /*
     * La view vide est sur la meme ligne mais a droite de 
     * la view ayant recu l'action
     */
    if(p.col-column>=1 && row-p.row==0){    // permet de verifié qu'on doit se deplacer vers la gauche
        NSLog(@"Yes I can be moved!");
        for(id obj2 in puzzler){
            NSLog(@"object number %d",[obj2 getOrigin]);
            if([obj2 getCol]>column && [obj2 getCol]<=p.col && [obj2 getRow]==row){ //permet d'identifier toute les views a deplacer sur le chemin
                //UIView *view = [tabView objectAtIndex:[obj2 getOrigin]-1];
                NSNumber *loc = [[[NSNumber alloc] initWithInt:[obj2 getOrigin]-1] autorelease];
                NSString *mov = @"Left";
                [tabViews addObject:mov];
                [tabViews addObject:loc];
                [self moveLeft:obj2]; 
                NSLog(@"%d is at colNumber %d and blackhole at colNumber %d",[obj2 getOrigin], [obj2 getCol],[obj getCol]);
                
            }
        }
        return tabViews;
        
    }
    return nil;
}





-(id) getPuzzler{
    return puzzler;
}

/*
 * Deplacement vers le haut
 */
- (void) moveUp:(PuzzlePiece *) p{
    NSLog(@"%d is moving up",[p getOrigin]);
    [p setRow:p.row-1];
    [p setPosX:p.posX-height];
    int rowOrigin = [[puzzler lastObject] getRow];
    [[puzzler lastObject] setRow:rowOrigin+1]; //On monte le view Blank d'un cran
}

/*
 * Deplacement vers le bas
 */

- (void) moveDown:(PuzzlePiece *) p{
    NSLog(@"%d is moving down",[p getOrigin]);
    [p setRow:p.row+1];
    [p setPosX:p.posX+height];
    int rowOrigin = [[puzzler lastObject] getRow];
    [[puzzler lastObject] setRow:rowOrigin-1]; //On monte le view Blank d'un cran
}

/*
 * Deplacement vers la gauche
 */

- (void) moveLeft:(PuzzlePiece *) p {
    NSLog(@"%d is moving left",[p getOrigin]);
    [p setCol:p.col-1];
    [p setPosY:p.posY-width];
    int colOrigin = [[puzzler lastObject] getCol];
    [[puzzler lastObject] setCol:colOrigin+1]; //On monte le view Blank d'un cran
}

/*
 * Deplacement vers la droite
 */

- (void) moveRight:(PuzzlePiece *) p{
    NSLog(@"%d is moving right",[p getOrigin]);
    [p setCol:p.col+1];
    [p setPosY:p.posY+width];
    int colOrigin = [[puzzler lastObject] getCol];
    [[puzzler lastObject] setCol:colOrigin-1]; //On monte le view Blank d'un cran
}



/*
 * Methode qui verifie si le puzzle est resolu
 */
-(Boolean) puzzleIsFinished{
    for(id obj in puzzler){
        int col= [obj getCol] +1;   // Colonne de la view
        int row = [obj getRow] +1 ; // Row de la view
        int origin =[obj getOrigin];// Origin de la view
        int colMod = origin % colMax;// origin modulo nombre de colonne max pour connaitre la colonne en fonction du nombre de colonne max
        int rowDiv = (origin / colMax);// origin divise par le nombre de colonne max pour connaitre la row en fonction du nombre de colonne max
        
        
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


@end
