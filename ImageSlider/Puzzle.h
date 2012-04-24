//
//  Puzzle.h
//  ImageSlider
//
//  Created by Marc Chamly on 4/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Puzzle : NSObject


-(id) initWithSize:(int) col:(int)row;

//@property (nonatomic, retain) NSMutableArray *puzzler;
-(void) addViews: (NSObject *) p;


- (void) moveUp:(NSObject *) p;
- (void) moveDown:(NSObject *) p;
- (void) moveRight:(NSObject *) p;
- (void) moveLeft:(NSObject *) p;

-(NSMutableArray *) canBeMoved2: (NSObject *) p;

-(id) getPuzzler;

-(Boolean) puzzleIsFinished;


@end