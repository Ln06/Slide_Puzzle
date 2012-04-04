//
//  ImageSliderViewController.m
//  ImageSlider
//
//  Created by Marc Chamly on 3/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ImageSliderViewController.h"



@implementation ImageSliderViewController

@synthesize totoView;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle



- (void)viewDidLoad
{
    [super viewDidLoad];
     
    int ox = 0;
    int oy =0;
    int width = 107;
    int height = 104;
    for(int j=0; j<4; j=j+1){
        for (int i=0; i<3; i=i+1) {
            //if(!(j==3 && i==2)){
            if(j!=3 || i!=2){  
            UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(ox, oy, width, height)];
            view1.backgroundColor = [UIColor colorWithRed:(arc4random() % 255)/255.0 green:(arc4random() % 255)/255.0 blue:(arc4random() % 255)/255.0 alpha:1];
            [self.view addSubview:view1];
            ox+=width;
            [view1 release];
            }
        }
        ox=0;
        oy+=height;
    }
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [UIView animateWithDuration:1.0
                     animations:^{
                         self.totoView.center = CGPointMake(self.totoView.center.x + self.totoView.frame.size.width , self.totoView.center.y);
                     }];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
