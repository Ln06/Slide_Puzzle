//
//  ImageSliderViewController.h
//  ImageSlider
//
//  Created by Marc Chamly on 3/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>

@interface ImageSliderViewController : UIViewController


- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer;
-(void)animateView:(int) origine:(int)x:(int) y; 
-(void) restartGame;
-(id) initWithSize:(int) x:(int) y:(UIImage *) img;

@end
