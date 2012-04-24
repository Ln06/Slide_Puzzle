//
//  FullImage.m
//  ImageSlider
//
//  Created by Marc Chamly on 4/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FullImage.h"

@interface FullImage(){
    
}
@property (nonatomic,retain) UIImage *photo;
@end

@implementation FullImage
@synthesize photo;

- (id)initWithImage:(UIImage *)image
{
    self = [super initWithNibName:@"FullImage" bundle:nil];
    if (self) {
        photo = image;
    }
    return self;
}

- (void)dealloc {
    [photo release];
    [super dealloc];
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIImageView *iView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,320,460)]  ;
    iView.image = photo;
    [self.view addSubview:iView];
    [iView release];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
