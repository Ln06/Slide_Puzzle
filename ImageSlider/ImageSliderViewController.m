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
@property (nonatomic,retain) NSObject *source;


@end


@implementation ImageSliderViewController

@synthesize puzzle;
@synthesize tabView;
@synthesize source;

- (id)init
{
    self = [super initWithNibName:@"ImageSliderViewController" bundle:nil];
    if (self) {
        puzzle = [[Puzzle alloc] init];
        tabView =[[NSMutableArray alloc] init];
        NSLog(@"aaaaaaa");
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
    int position = 0;
    
    /*Get the source image from file
    NSImage *source = [[NSImage alloc]initWithContentsOfFile:@"/Users/daniele/Pictures/lda/lodevalm02.jpg";
    
    //Init target image
    NSImage *target = [[NSImage alloc]initWithSize:NSMakeSize(128,128)];
    
    //start drawing on target
    [target lockFocus];
    //draw the portion of the source image on target image
    [source drawInRect:NSMakeRect(0,0,128,128)
              fromRect:NSMakeRect(0,0,128,128)
             operation:NSCompositeCopy
              fraction:1.0];
    //end drawing
    [target unlockFocus];
    
    //create a NSBitmapImageRep
    NSBitmapImageRep *bmpImageRep = [[NSBitmapImageRep alloc]initWithData:[target TIFFRepresentation]];
    //add the NSBitmapImage to the representation list of the target
    [target addRepresentation:bmpImageRep];
    
    //get the data from the representation
    NSData *data = [bmpImageRep representationUsingType: NSPNGFileType
                                             properties: nil];
    
    //write the data to a file
    [data writeToFile: @"/Users/daniele/Pictures/lda/lodevalm01_crop.png"
           atomically: NO];
    
    */
    
    
    
    
    
    
    
    
    
    
    
    
    
    for(int j=0; j<4; j=j+1){
        for (int i=0; i<3; i=i+1) {
            position +=1;       //position de l'image (1,2,3,...,3+2)
           
            if(j!=3 || i!=2){  
                
                UIView *view1 = [[[UIView alloc] initWithFrame:CGRectMake(ox, oy, width, height)] autorelease];  // creation de la view
                view1.backgroundColor = [UIColor colorWithRed:(arc4random() % 255)/255.0 green:(arc4random() % 255)/255.0 blue:(arc4random() % 255)/255.0 alpha:1];
                NSString* pathToImageFile = [[NSBundle mainBundle] pathForResource:@"testing" ofType:@"jpg" inDirectory:@"image"];
                UIImage *image = [[UIImage alloc] initWithContentsOfFile:pathToImageFile];
                UIImageView *iView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
                iView.image = image;
                [iView setImage:image];
                [view1 addSubview:iView];
                
                
                UILabel *myLabel = [[[UILabel alloc] initWithFrame:CGRectMake(0,0, 25, 25)] autorelease];
                [myLabel setText:[NSString stringWithFormat:@"%d",position]];
                 
                //Creation du TapGestureRecognizer
                UITapGestureRecognizer *singleFingerTap = 
                [[UITapGestureRecognizer alloc] initWithTarget:self 
                                                        action:@selector(handleSingleTap:)];
                [view1 addGestureRecognizer:singleFingerTap];
                [view1 addSubview:myLabel];
                [singleFingerTap release];

                
                PuzzlePiece *p = [[[PuzzlePiece alloc] initWithPos:(int)ox :(int)oy :position:i:j] autorelease]; //on créer l'objet qui contiendra les infos
                
                //un petit println
                NSLog(@"%d",position);
                
                
                //un petit test pour voir si l'animation fonctionne
                /*if(position == 9){   
                   [UIView animateWithDuration:1.0
                                     animations:^{view1.center = CGPointMake(view1.center.x, view1.center.y+ view1.frame.size.height);}];
                
                }*/
                //fin de teste
                
                
                [self.view addSubview:view1]; //on rajjoute l'image à notre viewPrincipale
                [tabView addObject:view1];    //on rajjoute l'image à notre tableau d'image
                [puzzle addViews: p];         //on rajjoute l'objet contenant les infos a notre tableau d'info
                ox+=width;                    //on deplace l'origine sur l'abscisse
                [view1 release];
            }
            else if ((j==3 && i==2)){ // cet objet correspont à l'objet "vide" reconnaissable grâce a ça position d'origine = 12
                PuzzlePiece *p = [[[PuzzlePiece alloc] initWithPos:(int)ox :(int)oy :position:i:j] autorelease]; //on créer l'objet qui contiendra les infos
                //[tabView addObject: p];
                [puzzle addViews: p];
            }
            
        }
        
        ox=0;               //on réinitialise l'origine de l'abscisse
        oy+=height;         //on deplace l'origine de l'ordonnée 
    }
    [puzzle shuffle:tabView];
    
    
}

-(void)animateView:(int) origine:(int) x:(int) y{
    UIView *view1 =[tabView objectAtIndex:origine];
    for(id obj in tabView){
        if([obj getOrigin] == origine){
            [UIView animateWithDuration:1.0
                             animations:^{view1.center = CGPointMake(view1.center.x, view1.center.y+ view1.frame.size.height);}];
        }
    }
    
}
- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer {
    
    //NSLog(@"%d",[tabView indexOfObject:recognizer.view]);
    int pos = [tabView indexOfObject:recognizer.view]+1;
    PuzzlePiece *p;
    for(id obj in [puzzle getPuzzler]){
        if([obj getOrigin] == pos){
            p = obj;
            //NSLog(@"%d",[obj getOrigin]);
        }
    }
    [puzzle canBeMoved:p:recognizer.view];
    Boolean finished = [puzzle puzzleIsFinished];
    if(finished){
        NSLog(@"J'ai finiiiiiiiiiiiiii gros GGGGGGGGGGGGGGGGGGGG");
        /*NSString* pathToImageFile = [[NSBundle mainBundle] pathForResource:@"testing" ofType:@"jpg" inDirectory:@"image"];
        UIImage *image = [[UIImage alloc] initWithContentsOfFile:pathToImageFile];
        UIImageView *iView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, , )];
        iView.image = image;
        [iView setImage:image];*/
    }
    
    //UIView *totoView = [tabView objectAtIndex:9];
    //[puzzle canBeMoved:[tabView objectAtIndex:9]];
    
    /*[UIView animateWithDuration:1.0
                       animations:^{recognizer.view.center = CGPointMake(recognizer.view.center.x, recognizer.view.center.y+ recognizer.view.frame.size.height);}];
    [recognizer.view setNeedsDisplay];
    */
}



- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    //[puzzle shuffle];
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
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
