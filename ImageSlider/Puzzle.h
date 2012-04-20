//
//  Puzzle.h
//  ImageSlider
//
//  Created by Marc Chamly on 4/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Puzzle : NSObject

//@property (nonatomic, retain) NSMutableArray *puzzler;



-(void) addViews: (NSObject *) p;
-(void) shuffle:(NSMutableArray *) tabV;
- (void) moveUp:(NSObject *) p:(UIView *) view;
- (void) moveDown:(NSObject *) p:(UIView *) view;
- (void) moveRight:(NSObject *) p:(UIView *) view;
- (void) moveLeft:(NSObject *) p:(UIView *) view;
-(void) canBeMoved: (NSObject *) p:(UIView *) view;
-(void) canBeMoved2: (NSObject *) p:(NSMutableArray *) tabView;
-(id) getPuzzler;
-(Boolean) puzzleIsFinished;
-(id) initWithSize:(int) col:(int)row;
//-(void)handleSingleTap:(UITapGestureRecognizer *)recognizer;

@end