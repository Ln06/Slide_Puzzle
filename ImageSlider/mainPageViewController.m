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

@end

@implementation mainPageViewController
@synthesize colNumber;
@synthesize rowNumber;

@synthesize restart, gameMusic,colMax,rowMax;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [colNumber setText:[NSString stringWithFormat:@"%g", colMax]];
        [rowNumber setText:[NSString stringWithFormat:@"%g", rowMax]];
    }
    return self;
}



-(IBAction)startButtonPressed:(UIButton *)sender{
    AudioServicesPlaySystemSound(gameMusic);
    restart = false;
    [self.navigationController pushViewController: self.imageSliderViewController animated:YES];
    
}
-(IBAction)restartButtonPressed:(UIButton *)sender{
    restart = true;
    [self.navigationController pushViewController: self.imageSliderViewController animated:YES];
}

-(IBAction)changeColumnNumber:(UIStepper *)sender{
    colMax = [sender value];
    [colNumber setText:[NSString stringWithFormat:@"%d", colMax]];
    
}
-(IBAction)changeRowNumber:(UIStepper *)sender{
    rowMax =  [sender value];
    [rowNumber setText:[NSString stringWithFormat:@"%d", rowMax]];
}

- (ImageSliderViewController *) imageSliderViewController{
    if(restart==false && !imageSliderViewController){
        NSLog(@"je start");   
        imageSliderViewController = [[ImageSliderViewController alloc] initWithSize:colMax :rowMax];
        return imageSliderViewController;
    }
    else if(restart ==true){
        NSLog(@"je restart");
        imageSliderViewController = [[ImageSliderViewController alloc] initWithSize:colMax :rowMax];
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
    */self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"puzzleBack11.png"]];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setColNumber:nil];
    [self setRowNumber:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [colNumber release];
    [rowNumber release];
    [super dealloc];
}
@end
