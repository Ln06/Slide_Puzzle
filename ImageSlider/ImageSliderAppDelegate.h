//
//  ImageSliderAppDelegate.h
//  ImageSlider
//
//  Created by Marc Chamly on 3/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ImageSliderViewController;

@interface ImageSliderAppDelegate : UIResponder <UIApplicationDelegate>{
    UINavigationController *navigationController;
}

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ImageSliderViewController *viewController;

@end
