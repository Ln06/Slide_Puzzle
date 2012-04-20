//
//  mainPageViewController.h
//  ImageSlider
//
//  Created by Hélène Laffineur on 4/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import "ImageSliderViewController.h"

@interface mainPageViewController : UIViewController{
    ImageSliderViewController *imageSliderViewController;
    Boolean restart;
}
-(IBAction)startButtonPressed:(UIButton *)sender;
-(IBAction)restartButtonPressed:(UIButton *)sender;
-(IBAction)changeColumnNumber:(UIStepper *) sender;
-(IBAction)changeRowNumber:(UIStepper *) sender;
@property (retain, nonatomic) IBOutlet UILabel *colNumber;
@property (retain, nonatomic) IBOutlet UILabel *rowNumber;

- (ImageSliderViewController *) imageSliderViewController;
@end
