//
//  ImageSliderViewController.m
//  ImageSlider
//
//  Created by Marc Chamly on 3/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ImageSliderViewController.h"
#import "Puzzle.h"
#import "PuzzlePiece.h"

@interface ImageSliderViewController (){

    NSMutableArray *tabView;
}

@property (nonatomic, retain) Puzzle *puzzle;
@property (nonatomic,retain) NSMutableArray *tabView;//=[[[NSMutableArray alloc] init] autorelease];

@end


@implementation ImageSliderViewController

@synthesize puzzle;
@synthesize tabView;

- (id)init
{
    self = [super initWithNibName:@"ImageSliderViewController" bundle:nil];
    if (self) {
        puzzle = [[Puzzle alloc] init];
        tabView =[[NSMutableArray alloc] init];
    }
    return self;
}

- (void)dealloc {
    [puzzle release];
    [super dealloc];
}

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
                int position = i + j;   //position de l'image (1,2,3,...,3+2)
                UIView *view1 = [[[UIView alloc] initWithFrame:CGRectMake(ox, oy, width, height)] autorelease];
                view1.backgroundColor = [UIColor colorWithRed:(arc4random() % 255)/255.0 green:(arc4random() % 255)/255.0 blue:(arc4random() % 255)/255.0 alpha:1];
                //PuzzlePiece *p = [[[PuzzlePiece alloc] initWithPos:ox :oy :position ] autorelease]; //on créer l'objet qui contiendra les infos
                [self.view addSubview:view1]; //on rajjoute l'image à notre view
                [tabView addObject:view1];    //on rajjoute l'image à notre tableau d'image
                //[puzzle addView: p];          // on rajjoute l'objet contenant les infos a notre tableau d'info
                ox+=width;
                [view1 release];
            }
        }
        ox=0;
        oy+=height;
    }
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
    
    /*[UIView animateWithDuration:1.0
                     animations:^{
                         self.totoView.center = CGPointMake(self.totoView.center.x + self.totoView.frame.size.width , self.totoView.center.y);
                     }];*/
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
