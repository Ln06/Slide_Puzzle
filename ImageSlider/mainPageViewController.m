//
//  mainPageViewController.m
//  ImageSlider
//
//  Created by Hélène Laffineur on 4/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
#import "mainPageViewController.h"
#import "ImageSliderViewController.h"

@interface mainPageViewController(){
    SystemSoundID gameMusic;
}
@property (nonatomic,assign) Boolean restart;
@property (nonatomic) SystemSoundID gameMusic;
@property (nonatomic,assign) int colMax;
@property (nonatomic,assign) int rowMax;
@property (nonatomic,assign) UIImage *photo;

@property (nonatomic, retain) UIImagePickerController *imagePickerController;

@end

@implementation mainPageViewController
@synthesize loading;
@synthesize photo;
@synthesize imagePickerController;
@synthesize start,continue1,restartBut;
@synthesize colNumber,rowNumber;
@synthesize restart, gameMusic,colMax,rowMax;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self.continue1 setHidden:true];
        [self.restartBut setHidden:true];
        colMax = 3;
        rowMax = 4;
        [colNumber setText:[NSString stringWithFormat:@"%d", colMax]];
        [rowNumber setText:[NSString stringWithFormat:@"%d", rowMax]];
    }
    return self;
}
- (void)dealloc {
    [colNumber release];
    [rowNumber release];
    [start release];
    [continue1 release];
    [restartBut release];
    [loading release];
    [super dealloc];
}

/*
 *Code pour Selectionner une image de notre library
 *
- (void)imagePickerController:(UIImagePickerController *)imagePicker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self dismissModalViewControllerAnimated:YES];
    [imagePickerController release];
    //UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    photo= [info objectForKey:UIImagePickerControllerOriginalImage];
    [start sendActionsForControlEvents:UIControlEventTouchUpInside];   //déclanche le debut apres selection de l'image
}
*/
//Marche pas!
- (void)imagePickerController:(UIImagePickerController *)imagePicker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo{

    [self dismissModalViewControllerAnimated:YES];
    //[imagePicker release];
    [imagePickerController release];
    //UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    photo= image;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry!" 
                                                    message:@"This function is not available on free version, purchase full version for more options"
                                                   delegate:nil 
                                          cancelButtonTitle:@"OK" 
                                          otherButtonTitles: nil];
    [alert show];
    //[start sendActionsForControlEvents:UIControlEventTouchUpInside];   //déclanche le debut apres selection de l'image
}

/*
 * Start with Image Button qui renvoie a la selection d'image de notre livrary
 */
-(IBAction)startWithImage:(UIButton *) sender{
    restart = true;
    self.imagePickerController = [[UIImagePickerController alloc] init];
    self.imagePickerController.allowsEditing = NO;
    self.imagePickerController.delegate = self;
    self.imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentModalViewController:self.imagePickerController animated:YES];
}

/*
 *Start button
 */
-(IBAction)startButton:(UIButton *)sender{
    [self.start setHidden:true];
    [self.loading setHidden:false];
    [self.continue1 setHidden:false];
    [self.restartBut setHidden:false];
    photo = [UIImage imageNamed:@"burj.jpg"];
    restart = false;
    [self.navigationController pushViewController: self.imageSliderViewController animated:YES];
    
}

/*
 *  Continue Button pressed
 */
-(IBAction)continueButtonPressed:(UIButton *)sender{
    photo = [UIImage imageNamed:@"burj.jpg"];
    restart = false;
    [self.navigationController pushViewController: self.imageSliderViewController animated:YES];
    
}
/*
 *Restart pressed
 */
-(IBAction)restartButtonPressed:(UIButton *)sender{
    restart = true;
    [self.navigationController pushViewController: self.imageSliderViewController animated:YES];
}

/*
 *  Change column Number
 */
-(IBAction)changeColumnNumber:(UIStepper *)sender{
    colMax = [sender value];
    [colNumber setText:[NSString stringWithFormat:@"%d", colMax]];
    
}

/*
 *  Change row Number
 */
-(IBAction)changeRowNumber:(UIStepper *)sender{
    rowMax =  [sender value];
    [rowNumber setText:[NSString stringWithFormat:@"%d", rowMax]];
}


/*
 * passe la main a ImageSliderViewController soit en commencant une nouvelle parti si aucune existe deja
 * soit en recommencant une nouvelle parti, 
 * soit en continuant celle deja existante
 */

- (ImageSliderViewController *) imageSliderViewController{
    if(restart==false && !imageSliderViewController){
        imageSliderViewController = [[ImageSliderViewController alloc] initWithSize:colMax :rowMax:photo];
        [self.loading setHidden:true];
        return imageSliderViewController;
    }
    else if(restart ==true){
        imageSliderViewController = [[ImageSliderViewController alloc] initWithSize:colMax :rowMax:photo];
        return imageSliderViewController;
    }
    return imageSliderViewController;
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
    /*NSString *musicPath = [[NSBundle mainBundle] pathForResource:@"mario" ofType:@"mp3"];
    CFURLRef musicURL = (CFURLRef) [NSURL fileURLWithPath:musicPath];
    AudioServicesCreateSystemSoundID(musicURL, &gameMusic);
    AudioServicesPlaySystemSound(gameMusic);
    */
    
    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"puzzleBack11.png"]];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setColNumber:nil];
    [self setRowNumber:nil];
    [self setStart:nil];
    [self setContinue1:nil];
    [self setRestartBut:nil];
    [self setLoading:nil];
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
