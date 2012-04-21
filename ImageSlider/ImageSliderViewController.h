//
//  ImageSliderViewController.h
//  ImageSlider
//
//  Created by Marc Chamly on 3/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import "FullImage.h"

@interface ImageSliderViewController : UIViewController{
    FullImage *fullImage;
}


- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer;
-(void)animateView:(int) origine:(int)x:(int) y; 
-(void) restartGame;
-(id) initWithSize:(int) x:(int) y:(UIImage *) img;
- (FullImage *) fullImage;
-(void)showFullImage;
@end
