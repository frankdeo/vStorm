//
//  SettingsViewController.m
//  vStorm
//
//  Created by Frank Deo on 9/9/12.
//  Copyright (c) 2012 Version 40 Software, LLC. All rights reserved.
//

#import "SettingsViewController.h"
#import "ViewController.h"
#import "AppDelegate.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController
@class ViewController;

@synthesize delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    if (self.deviceIsAniPad == YES) {
        dismissButton.hidden = TRUE;
    }
    
    stopTextField.delegate = self;
    
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    stopTextField.text = appDelegate.timeoutTime;
    sliderValue = appDelegate.sliderValue;
    brightnessSlider.value = sliderValue;
    soundsSegmentedControl.selectedSegmentIndex = appDelegate.selectedSoundSegment;
    
    if (appDelegate.timeColor == [UIColor redColor]) {
        UIImage *image = [UIImage imageNamed: @"Red.png"];
        [textColorImageView setImage:image];
        
    } else if (appDelegate.timeColor == [UIColor greenColor]) {
        UIImage *image = [UIImage imageNamed: @"Green.png"];
        [textColorImageView setImage:image];
    } else if (appDelegate.timeColor == [UIColor blueColor]) {
        UIImage *image = [UIImage imageNamed: @"Blue.png"];
        [textColorImageView setImage:image];
    } else if (appDelegate.timeColor == [UIColor yellowColor]) {
        UIImage *image = [UIImage imageNamed: @"Yellow.png"];
        [textColorImageView setImage:image];
    } else if (appDelegate.timeColor == [UIColor orangeColor]) {
        UIImage *image = [UIImage imageNamed: @"Orange.png"];
        [textColorImageView setImage:image];
    } else if (appDelegate.timeColor == [UIColor purpleColor]) {
        UIImage *image = [UIImage imageNamed: @"Purple.png"];
        [textColorImageView setImage:image];
    }
    
    [super viewDidLoad];
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
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
 

    return NO;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    appDelegate.timeoutTime = stopTextField.text;
    
    return YES;
}

- (IBAction) dismissButtonPressed:(id)sender {
    
    [self.delegate settingsViewDigFinish:self];

}

- (BOOL)deviceIsAniPad {
    if ([[UIDevice currentDevice] respondsToSelector:@selector(userInterfaceIdiom)])
        //We can test if it's an iPad. Running iOS3.2+
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
            return YES; //is an iPad
        else
            return NO; //is an iPhone
        else
            return NO; //does not respond to selector, therefore must be < iOS3.2, therefore is an iPhone
}

- (IBAction) buttonRed:(id)sender {
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    appDelegate.timeColor = [UIColor redColor];
    
    UIImage *image = [UIImage imageNamed: @"Red.png"];
    [textColorImageView setImage:image];
}

- (IBAction) buttonGreen:(id)sender {
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    appDelegate.timeColor = [UIColor greenColor];
    
    UIImage *image = [UIImage imageNamed: @"Green.png"];
    [textColorImageView setImage:image];
}

- (IBAction) buttonBlue:(id)sender {
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    appDelegate.timeColor = [UIColor blueColor];
    
    UIImage *image = [UIImage imageNamed: @"Blue.png"];
    [textColorImageView setImage:image];
}

- (IBAction) buttonYellow:(id)sender {
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    appDelegate.timeColor = [UIColor yellowColor];
    
    UIImage *image = [UIImage imageNamed: @"Yellow.png"];
    [textColorImageView setImage:image];
}

- (IBAction) buttonOrange:(id)sender {
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    appDelegate.timeColor = [UIColor orangeColor];
    
    UIImage *image = [UIImage imageNamed: @"Orange.png"];
    [textColorImageView setImage:image];
}

- (IBAction) buttonPurple:(id)sender {
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    appDelegate.timeColor = [UIColor purpleColor];
    
    UIImage *image = [UIImage imageNamed: @"Purple.png"];
    [textColorImageView setImage:image];
}

- (IBAction) sliderValue:(id)sender {
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    appDelegate.sliderValue = brightnessSlider.value;
    
}

- (IBAction) segmentValue:(id)sender {
    
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSBundle* bundle = [NSBundle mainBundle];
    
    NSInteger index = ((UISegmentedControl*)sender).selectedSegmentIndex;
    
    if (index == 0) {
        appDelegate.soundURL = [bundle pathForResource:@"Thunder" ofType:@"mp3"];
        appDelegate.selectedSoundSegment = index;
    }
    else if (index == 1) {
        appDelegate.soundURL = [bundle pathForResource:@"Rain" ofType:@"mp3"];
        appDelegate.selectedSoundSegment = index;
    }
    else if (index == 2) {
        appDelegate.soundURL = [bundle pathForResource:@"Storm" ofType:@"mp3"];
        appDelegate.selectedSoundSegment = index;
    }
}

@end
