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

@interface mainPageViewController : UIViewController<UINavigationControllerDelegate, UIImagePickerControllerDelegate>{
    ImageSliderViewController *imageSliderViewController;
    UIImagePickerController *imagePickerController;
    Boolean restart;
    NSString *imageKey;
}
-(IBAction)continueButtonPressed:(UIButton *)sender;
-(IBAction)startButton:(UIButton *)sender;
-(IBAction)restartButtonPressed:(UIButton *)sender;
-(IBAction)changeColumnNumber:(UIStepper *) sender;
-(IBAction)changeRowNumber:(UIStepper *) sender;
@property (retain, nonatomic) IBOutlet UILabel *colNumber;
@property (retain, nonatomic) IBOutlet UILabel *rowNumber;
@property (retain, nonatomic) IBOutlet UIButton *start;
@property (retain, nonatomic) IBOutlet UIButton *continue1;
@property (retain, nonatomic) IBOutlet UIButton *restartBut;
@property (retain, nonatomic) IBOutlet UILabel *loading;
- (ImageSliderViewController *) imageSliderViewController;
@end
