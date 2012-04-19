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

@end



@implementation Puzzle

@synthesize width,height,puzzler;


- (id)init {
    self = [super init];
    if (self) {
        width = 107;
        height =104;
        puzzler = [[NSMutableArray alloc] init];
        
    }
    return self;
}

- (void) canBeMoved: (PuzzlePiece *) p : (UIView *) view {
    NSLog(@"can %d move?", [p getOrigin]);
    for(id obj in puzzler){
        int column =(int) [obj getCol]; 
        int row = [obj getRow];
        int origin = [obj getOrigin];
        if(origin == 12){                       // La view avec l'origine 12, est notre carre noir
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
    }
}





-(id) getPuzzler{
    return puzzler;
}

- (void) moveUp:(PuzzlePiece *) p:(UIView *) view{
    NSLog(@"%d is moving up",[p getOrigin]);
    [p setRow:p.row-1];
    [p setPosX:p.posX-104];
    [UIView animateWithDuration:0.5
                     animations:^{view.center = CGPointMake(view.center.x, view.center.y- view.frame.size.height);}];
    int rowOrigin = [[puzzler lastObject] getRow];
    [[puzzler lastObject] setRow:rowOrigin+1]; //On monte le view Blank d'un cran
}



- (void) moveDown:(PuzzlePiece *) p: (UIView *) view{
    NSLog(@"%d is moving down",[p getOrigin]);
    [p setRow:p.row+1];
    [p setPosX:p.posX+104];
    [UIView animateWithDuration:0.5
                     animations:^{view.center = CGPointMake(view.center.x, view.center.y+ view.frame.size.height);}];
    int rowOrigin = [[puzzler lastObject] getRow];
    [[puzzler lastObject] setRow:rowOrigin-1]; //On monte le view Blank d'un cran
}



- (void) moveLeft:(PuzzlePiece *) p:(UIView *) view {
    NSLog(@"%d is moving left",[p getOrigin]);
    [p setCol:p.col-1];
    [p setPosY:p.posY-107];
    [UIView animateWithDuration:0.5
                     animations:^{view.center = CGPointMake(view.center.x-view.frame.size.width, view.center.y);}];
    int colOrigin = [[puzzler lastObject] getCol];
    [[puzzler lastObject] setCol:colOrigin+1]; //On monte le view Blank d'un cran
}
- (void) moveRight:(PuzzlePiece *) p:(UIView *) view {
    NSLog(@"%d is moving right",[p getOrigin]);
    [p setCol:p.col+1];
    [p setPosY:p.posY+107];
    [UIView animateWithDuration:0.5
                     animations:^{view.center = CGPointMake(view.center.x+view.frame.size.width, view.center.y);}];
    int colOrigin = [[puzzler lastObject] getCol];
    [[puzzler lastObject] setCol:colOrigin-1]; //On monte le view Blank d'un cran
}


// Swapping 2 views by replacing their Location (posX,posY and col,row) but keeping their origin location as is
-(void) shuffle:(NSMutableArray *) tabView {
    NSLog(@"every day i'm shuffeling");
    for(id obj in puzzler){
        if([obj getOrigin] == 12){
            // Origin 12 is the Empty view
            NSLog(@"I'm 12!");
            
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
            ((UIView *)[tabView objectAtIndex:origin-1]).center = CGPointMake(posX2+(height/2), posY2+(width/2));
            
            
            //obj2 takes obj's values
            [obj2 setPosX:posX];
            [obj2 setPosY:posY];
            [obj2 setCol:column];
            [obj2 setRow:row];
            ((UIView *) [tabView objectAtIndex:origin2-1]).center = CGPointMake(posX +(height/2), posY+(width/2));
            
        }
        
    }
    NSLog(@"I'm done");
}

-(Boolean) puzzleIsFinished{
    for(id obj in puzzler){
        int col= [obj getCol] +1;   // Colonne de la view
        int row = [obj getRow] +1 ; // Row de la view
        int origin =[obj getOrigin];// Origin de la view
        int maxCol = 3;             // Nombre de colonne de mon puzzle
        int colMod = origin % maxCol;// origin modulo nombre de colonne max pour connaitre la colonne en fonction du nombre de colonne max
        int rowDiv = (origin / maxCol);// origin divise par le nombre de colonne max pour connaitre la row en fonction du nombre de colonne max
        
        
        NSLog(@"col = %d row = %d colMod = %d rowDiv = %d",col,row,colMod,rowDiv+1);
        if( colMod == col && (rowDiv +1)== row ){  // la view est a la bonne place
            NSLog(@"%d est à la bonne place",origin);
        }
        else if( colMod==0 && maxCol==col && rowDiv == row){   //la view est a la bonne place en fin de colonne du tableau 
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
