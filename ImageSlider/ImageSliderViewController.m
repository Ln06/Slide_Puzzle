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
#import "FullImage.h"
@interface ImageSliderViewController (){
    
    NSMutableArray *tabView;
}

@property (nonatomic, retain) Puzzle *puzzle;
@property (nonatomic,retain) NSMutableArray *tabView;//=[[[NSMutableArray alloc] init] autorelease];
//@property (nonatomic,retain) NSObject *source;
@property (nonatomic,assign) Boolean displayed;
@property (nonatomic,assign) SystemSoundID audioEffect;
@property (nonatomic,assign) int colMax;
@property (nonatomic,assign) int rowMax;
@property (nonatomic,retain) UIImage *photo;

@end


@implementation ImageSliderViewController

@synthesize puzzle,displayed,audioEffect;
@synthesize tabView,colMax,rowMax,photo;

//@synthesize source;

- (id)initWithSize:(int) colMax1:(int) rowMax1:(UIImage *) img
{
    self = [super initWithNibName:@"ImageSliderViewController" bundle:nil];
    if (self) {
        photo = img;
        colMax = colMax1;
        rowMax = rowMax1;
        puzzle = [[Puzzle alloc] initWithSize:colMax :rowMax];
        tabView =[[NSMutableArray alloc] init];
        NSLog(@"aaaaaaa");
        
    }
    return self;
}

- (void)dealloc {
    [puzzle release];
    [tabView release];
    [photo release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    int ox = 0;
    int oy =0;
    int width = 320/colMax; //(320)
    int height = 416/rowMax; //(416)
    int position = 0;
    self.view.backgroundColor = [UIColor blackColor];
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithTitle:@"Show image" style:UIBarButtonItemStylePlain target:self action:@selector(showFullImage)];          
    self.navigationItem.rightBarButtonItem = anotherButton;
    [anotherButton release];
    
    
    /*
     *   Decoupage d'une photo en plein de petites views
     *
     *
     */
    for(int j=0; j<rowMax; j=j+1){
        for (int i=0; i<colMax; i=i+1) {
            position +=1;       //position de l'image (1,2,3,...,rowMax+colMax)
            
            if(j!=rowMax-1 || i!=colMax-1){  
                /*
                 * recupere un morceau de l'image
                 */
                CGImageRef cgImg = CGImageCreateWithImageInRect(photo.CGImage, CGRectMake(ox, oy, width-1, height-1));//-1 pour avoir un effet de block
                UIImage* part = [UIImage imageWithCGImage:cgImg];
                UIImageView* iv = [[UIImageView alloc] initWithImage:part];
                
                /*
                 * transforme l'image en view
                 */
                UIView* view1 = [[UIView alloc] initWithFrame:CGRectMake(ox, oy, width, height)];
                [view1 addSubview:iv];
                [iv release];
                
                /*
                 * rajoute une petite numerotation a la view
                 */
                UILabel *myLabel = [[[UILabel alloc] initWithFrame:CGRectMake(0,0, 25, 25)] autorelease];
                [myLabel setText:[NSString stringWithFormat:@"%d",position]];
                
                /*
                 *Creation du TapGestureRecognizer
                 */
                
                UITapGestureRecognizer *singleFingerTap = 
                [[UITapGestureRecognizer alloc] initWithTarget:self 
                                                        action:@selector(handleSingleTap:)];
                [view1 addGestureRecognizer:singleFingerTap];
                [view1 addSubview:myLabel];
                [singleFingerTap release];
                
                /*
                 * on creer l'objet qui contiendra les infos
                 */ 
                PuzzlePiece *p = [[[PuzzlePiece alloc] initWithPos:(int)ox :(int)oy :position:i:j] autorelease]; 
                
                
                [self.view addSubview:view1]; //on rajjoute l'image à notre viewPrincipale
                [tabView addObject:view1];    //on rajjoute l'image à notre tableau d'image
                [puzzle addViews: p];         //on rajjoute l'objet contenant les infos a notre tableau d'info
                ox+=width;                    //on deplace l'origine sur l'abscisse
                [view1 release];
                CGImageRelease(cgImg);
            }
            /*
             * cet objet correspont à l'objet "vide" reconnaissable grâce a ça position d'origine (derniere ranger derniere colonne)
             * on créer l'objet qui contiendra les infos mais on ne cree pas de view
             */
            else if ((j==rowMax-1 && i==colMax-1)){ 
                PuzzlePiece *p = [[[PuzzlePiece alloc] initWithPos:(int)ox :(int)oy :position:i:j] autorelease]; 
                [puzzle addViews: p];
            }
            
        }
        
        ox=0;               //on réinitialise l'origine de l'abscisse
        oy+=height;         //on deplace l'origine de l'ordonnée 
    }
    
    /*
     * On shuffle les views
     */
   // [self shuffle];
    
    
}

/*
 * Methode pour afficher un apercu de l'image
 */

-(void) showFullImage{
    [self.navigationController pushViewController: self.fullImage animated:YES];
}

- (FullImage *) fullImage{
    if(!fullImage){
        fullImage = [[FullImage alloc] initWithImage:photo];
        return fullImage;
    }
    return fullImage;
}



/*
 * Singletap recognizer afin de deplacer les views
 */
- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer {
    int pos = [tabView indexOfObject:recognizer.view];  // on recupere la position de la view clickee (attention la vrai position est pos +1)
    PuzzlePiece *p =[[puzzle getPuzzler] objectAtIndex:pos]; // on recupere l'objet (attention l'objet et a la position pos -1) (1-1 = 0!)
    
    
    [self moveViews:[puzzle canBeMoved2:p]];                  // On demande le deplacement de l'objet ainsi que de la view
    Boolean finished =[puzzle puzzleIsFinished];     // On verifie si le puzzle est resolu
    if(finished && !displayed){                      // si le puzzle est resolu et que l'image n'est pas deja affiche on afficher l'image
        UIImageView *iView = [[UIImageView alloc] initWithFrame:CGRectMake(0,460,320,460)]  ;
        iView.image = photo;
        [self.view addSubview:iView];
        [iView release];
        [UIView animateWithDuration:2.5
                         animations:^{iView.center = CGPointMake(160,230);}];
        displayed = true;
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Info" 
														message:@"Congratulation! You have resolved the puzzle"
													   delegate:nil 
											  cancelButtonTitle:@"OK" 
											  otherButtonTitles: nil];
		[alert show];
		[alert release];
    }
    else if(finished && displayed){
        //[self restartGame];
    }
}

/*
 * Methode qui recommence une nouvelle partie
 */
-(void) restartGame{
    displayed =false;
    NSLog(@"restarting");
    //[tabView release];
    //[puzzle release];
    
    [self release];
    self.view = nil;
    //[self removeFromSuperview];
    [self init];
    [self viewDidLoad];
}



-(void) moveViews:(NSMutableArray *) tab{
    NSLog(@"I'm in moveViews");
    if(tab != nil){
        NSLog(@"tab is not nil");
        for(int i = 0;i<tab.count-1; i++){
            NSLog(@"view bug");
            int number = [[tab objectAtIndex:i+1] intValue];//NSInteger *vie = (NSInteger) [tab objectAtIndex:i+1];
            UIView *view = [tabView objectAtIndex:number];
            
            if([tab objectAtIndex:i] == @"Up"){
                [self moveUp:view];
            }
            else if([tab objectAtIndex:i] == @"Down"){
                NSLog(@"I'm in move views move down");
                [self moveDown:view];
            }
            else if([tab objectAtIndex:i] == @"Left"){
                [self moveLeft:view];
            }
            else if([tab objectAtIndex:i] == @"Right"){
                [self moveRight:view];
            }
            else{
                NSLog(@"je sais pas quoi faire");
            }
        }
    }
    NSLog(@"tab is nil");
}
/*
 * Deplacement vers le haut
 */
- (void) moveUp:(UIView *) view{
    [UIView animateWithDuration:0.5
                     animations:^{view.center = CGPointMake(view.center.x, view.center.y- view.frame.size.height);}];
}

/*
 * Deplacement vers le bas
 */

- (void) moveDown:(UIView *) view{
    [UIView animateWithDuration:0.5
                     animations:^{view.center = CGPointMake(view.center.x, view.center.y+ view.frame.size.height);}];
}

/*
 * Deplacement vers la gauche
 */

- (void) moveLeft:(UIView *) view {
    [UIView animateWithDuration:0.5
                     animations:^{view.center = CGPointMake(view.center.x-view.frame.size.width, view.center.y);}];
}

/*
 * Deplacement vers la droite
 */

- (void) moveRight:(UIView *) view {
    [UIView animateWithDuration:0.5
                     animations:^{view.center = CGPointMake(view.center.x+view.frame.size.width, view.center.y);}];
}



-(void) shuffle{
    int numberTotal = ([[puzzle getPuzzler] count] -2); 
    for(int x=0;x<100; x++){
        // on prend un puzzle piece au hazard
        int n = (arc4random() % numberTotal);
        id obj1 = [[puzzle getPuzzler] objectAtIndex:n];
        // on lui demande de se deplacer (si il peut) 
        [puzzle canBeMoved2:obj1];
        
        // on prend un puzzle piece au hazard
        int n2 = (arc4random() % numberTotal);
        id obj2 = [[puzzle getPuzzler] objectAtIndex:n2];
        // on lui demande de se deplacer (si il peut) 
        [puzzle canBeMoved2:obj2];
        
        // on prend un puzzle piece au hazard
        int n3 = (arc4random() % numberTotal);
        id obj3 = [[puzzle getPuzzler] objectAtIndex:n3];
        // on lui demande de se deplacer (si il peut) 
        [self moveViews:[puzzle canBeMoved2:obj3]];
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
