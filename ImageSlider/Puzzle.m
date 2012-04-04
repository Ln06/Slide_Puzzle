//
//  Puzzle.m
//  ImageSlider
//
//  Created by Marc Chamly on 4/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Puzzle.h"
#import "PuzzlePiece.h"



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

- (void) canBeMoved {
}

- (void) MoveView {
}

- (void)addViews: (PuzzlePiece *) p {
    [self.puzzler addObject:p];
}

- (void)dealloc {
    [puzzler release];
    [super dealloc];
}

@end
