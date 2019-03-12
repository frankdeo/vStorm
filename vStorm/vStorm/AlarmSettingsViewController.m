//
//  AlarmSettingsViewController.m
//  vStorm
//
//  Created by Frank Deo on 9/10/12.
//  Copyright (c) 2012 Version 40 Software, LLC. All rights reserved.
//

#import "AlarmSettingsViewController.h"
#import "ViewController.h"
#import "AppDelegate.h"

@interface AlarmSettingsViewController ()

@end

@implementation AlarmSettingsViewController
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
    
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    alarmDate = appDelegate.alarmDate;
    alarmDatePicker.Date = alarmDate;
    alarmSounds.selectedSegmentIndex = appDelegate.selectedAlarmSegment;
    
    appDelegate.alarmDate = alarmDatePicker.date;
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
	[df setTimeStyle:NSDateFormatterShortStyle];
	NSString *alarmSetTime = [NSString stringWithFormat:@"%@", [df stringFromDate:appDelegate.alarmDate]];
    alarmLabel.text = [NSString stringWithFormat:@"%@%@", @"Alarm Time: ", alarmSetTime];
    
    stopButton.hidden = TRUE;
    
    [alarmDatePicker addTarget:self action:@selector(changeTime:) forControlEvents:UIControlEventValueChanged];
    
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

- (IBAction) dismissButtonPressed:(id)sender {
    
    [self.delegate alarmSettingsViewDigFinish:self];
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

- (IBAction) testButtonPressed:(id)sender {
    
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:appDelegate.alarmURL] error:NULL];
    [audioPlayer prepareToPlay];
    audioPlayer.numberOfLoops = -1;
    audioPlayer.currentTime = 0;
    [audioPlayer play];
    stopButton.hidden = FALSE;
    testButton.hidden = TRUE;
}

- (IBAction) dismissButtonReleased:(id)sender {
    audioPlayer.currentTime = 0;
    [audioPlayer stop];
    stopButton.hidden = TRUE;
    testButton.hidden = FALSE;
    
}

- (IBAction) alarmSoundSelected:(id)sender {

    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSBundle* bundle = [NSBundle mainBundle];
    
    NSInteger index = ((UISegmentedControl*)sender).selectedSegmentIndex;
    
    if (index == 0) {
        
        appDelegate.alarmURL = [bundle pathForResource:@"Beep" ofType:@"mp3"];
        appDelegate.selectedAlarmSegment = index;
    }
    else if (index == 1) {
        appDelegate.alarmURL = [bundle pathForResource:@"Rooster" ofType:@"mp3"];
        appDelegate.selectedAlarmSegment = index;
    }
    else if (index == 2) {
        appDelegate.alarmURL = [bundle pathForResource:@"Siren" ofType:@"mp3"];
        appDelegate.selectedAlarmSegment = index;
    }

}

- (void)changeTime:(id)sender{
    
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    appDelegate.alarmDate = alarmDatePicker.date;
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
	[df setTimeStyle:NSDateFormatterShortStyle];
	NSString *alarmSetTime = [NSString stringWithFormat:@"%@", [df stringFromDate:alarmDatePicker.date]];
    alarmLabel.text = [NSString stringWithFormat:@"%@%@", @"Alarm Time: ", alarmSetTime];
    
}

@end
