//
//  ViewController.m
//  vStorm
//
//  Created by Frank Deo on 9/3/12.
//  Copyright (c) 2012 Version 40 Software, LLC. All rights reserved.
//

#import "ViewController.h"
#import "SettingsViewController.h"
#import "AlarmSettingsViewController.h"
#import "AboutHelpViewController.h"
#import "AppDelegate.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize popoverController, alarmPopoverController, aboutHelpPopoverController;

- (void)viewDidLoad
{
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [self runTimer];
	
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:appDelegate.soundURL] error:NULL];
    
    [audioPlayer prepareToPlay];
    
    [timeLabel setTextColor:appDelegate.timeColor];
    [timeLabel setAlpha:appDelegate.sliderValue];

    stopAlarmButton.hidden = TRUE;
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

- (void)flashScreen {
    
    if(arc4random() % 15 == 1)
    {
    
    [NSTimer scheduledTimerWithTimeInterval:0.1 target:self
                                   selector:@selector(displayWhite) userInfo:nil repeats:NO];
    [NSTimer scheduledTimerWithTimeInterval:0.2 target:self
                                   selector:@selector(displayBlack) userInfo:nil repeats:NO];
    }

}

- (void)displayWhite {
    [self.view setBackgroundColor:[UIColor whiteColor]];
}

- (void)displayBlack {
    [self.view setBackgroundColor:[UIColor blackColor]];
}

- (void)runFlashTimer {
    
    flashTicker = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(flashScreen) userInfo:nil repeats:YES];
    
}
- (void)runTimer {

	myTicker = [NSTimer scheduledTimerWithTimeInterval: 0.5 target: self selector: @selector(showTime) userInfo: nil repeats: YES];
    
}

- (void) fireAlarm {
    
    stopAlarmButton.hidden = FALSE;

    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
 	
    alarmPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:appDelegate.alarmURL] error:NULL];
    alarmPlayer.numberOfLoops = 0;
    alarmPlayer.currentTime = 0;
    [alarmPlayer play];
}

- (IBAction) stopAlarm:(id)sender {
    
    stopAlarmButton.hidden = TRUE;
    alarmButton.style = UIBarButtonItemStyleBordered;
    [self setAlarm:FALSE];
    [alarmPlayer stop];
}

- (void) runAlarm {
    
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger calendarUnits = NSEraCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit;
    NSDateComponents *dateComps = [calendar components:calendarUnits fromDate:appDelegate.alarmDate];
    [dateComps setSecond:0];
    NSDate *todayNowNoSeconds = [calendar dateFromComponents:dateComps];
    
    alarmTicker = [[NSTimer alloc] initWithFireDate: todayNowNoSeconds interval: 1 target: self selector:@selector(fireAlarm) userInfo:nil repeats:NO];
    NSRunLoop *runner = [NSRunLoop currentRunLoop];
    [runner addTimer:alarmTicker forMode: NSDefaultRunLoopMode];
}

- (void)showTime {
	
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    currentTime = [NSDate date];
	
	[formatter setDateFormat:@"h:mm:ss"];
	
    [timeLabel setText:[formatter stringFromDate:currentTime]];

}

- (void) stopEverything {
    
    [self setLightning:FALSE];
    [self setSounds:FALSE];
    [stopEverythingTimer invalidate];
    lightningButton.style = UIBarButtonItemStyleBordered;
    soundsButton.style = UIBarButtonItemStyleBordered;
    
}

- (void) stopEverythingTimer {
    
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSInteger timeoutSeconds = ([appDelegate.timeoutTime intValue] * 60);

    stopEverythingTimer = [NSTimer scheduledTimerWithTimeInterval: timeoutSeconds target: self selector: @selector(stopEverything) userInfo: nil repeats: NO];
    
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

- (IBAction) settingsButtonPressed:(id)sender {
        
    if (self.deviceIsAniPad == YES)
    {
        [alarmPopoverController dismissPopoverAnimated:YES];
        [popoverController dismissPopoverAnimated:YES];
        
        SettingsViewController *content = [[SettingsViewController alloc] init];
        popoverController = [[UIPopoverController alloc] initWithContentViewController:content];
        popoverController.popoverContentSize = CGSizeMake(320, 460);
        popoverController.delegate = self;

        if (![popoverController isPopoverVisible]) {
            [popoverController presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
        }
        else {
            [popoverController dismissPopoverAnimated:YES];
        }
    }
    else
    {
        SettingsViewController *settingsViewController = [[SettingsViewController alloc]initWithNibName:@"SettingsViewController" bundle:nil];
        settingsViewController.delegate = self;
        settingsViewController.modalPresentationStyle =  UIModalTransitionStyleCrossDissolve;
        [self presentModalViewController:settingsViewController animated:YES];
    }
}

- (IBAction) alarmSettingsButtonPressed:(id)sender {
    
    if (self.deviceIsAniPad == YES)
    {
        [popoverController dismissPopoverAnimated:YES];
        [alarmPopoverController dismissPopoverAnimated:YES];
        
        AlarmSettingsViewController *content = [[AlarmSettingsViewController alloc] init];
        alarmPopoverController = [[UIPopoverController alloc] initWithContentViewController:content];
        alarmPopoverController.popoverContentSize = CGSizeMake(320, 460);
        alarmPopoverController.delegate = self;
        
        if (![alarmPopoverController isPopoverVisible]) {
            [alarmPopoverController presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
        }
        else {
            [alarmPopoverController dismissPopoverAnimated:YES];
        }
    }
    else
    {
        AlarmSettingsViewController *alarmSettingsViewController = [[AlarmSettingsViewController alloc]initWithNibName:@"AlarmSettingsViewController" bundle:nil];
        alarmSettingsViewController.delegate = self;
        alarmSettingsViewController.modalPresentationStyle =  UIModalTransitionStyleCrossDissolve;
        [self presentModalViewController:alarmSettingsViewController animated:YES];
    }

}

- (IBAction) aboutButtonPressed:(id)sender {
    
    if (self.deviceIsAniPad == YES)
    {
        [popoverController dismissPopoverAnimated:YES];
        [alarmPopoverController dismissPopoverAnimated:YES];
        [aboutHelpPopoverController dismissPopoverAnimated:YES];
        
        AboutHelpViewController *content = [[AboutHelpViewController alloc] init];
        aboutHelpPopoverController = [[UIPopoverController alloc] initWithContentViewController:content];
        aboutHelpPopoverController.popoverContentSize = CGSizeMake(320, 460);
        aboutHelpPopoverController.delegate = self;
        
        if (![aboutHelpPopoverController isPopoverVisible]) {
            [aboutHelpPopoverController presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
        }
        else {
            [aboutHelpPopoverController dismissPopoverAnimated:YES];
        }
    }
    else
    {
        AboutHelpViewController *aboutHelpViewController = [[AboutHelpViewController alloc]init];
        [self presentModalViewController:aboutHelpViewController animated:YES];
    }

}

- (IBAction) lightningButton:(id)sender {
    
    if (lightningButton.style != UIBarButtonItemStyleDone) {
        lightningButton.style = UIBarButtonItemStyleDone;
        [self setLightning:TRUE];
        [self stopEverythingTimer];
    } else {
        lightningButton.style = UIBarButtonItemStyleBordered;
        [stopEverythingTimer invalidate];
        [self setLightning:FALSE];
    }
}

- (void) setLightning:(BOOL) state {
    
    if (state == TRUE) {
        [self runFlashTimer];
    } else {
        [flashTicker invalidate];
    }
}

- (IBAction) soundsButton:(id)sender {
    
    if (soundsButton.style != UIBarButtonItemStyleDone) {
        soundsButton.style = UIBarButtonItemStyleDone;
        [self setSounds:TRUE];
        [self stopEverythingTimer];
    } else {
        soundsButton.style = UIBarButtonItemStyleBordered;
        [stopEverythingTimer invalidate];
        [self setSounds:FALSE];
    }

}

- (void) setSounds:(BOOL) state {
    
    if (state == TRUE) {
        
        audioPlayer.numberOfLoops = -1;
        
        audioPlayer.currentTime = 0;
        [audioPlayer play];
    } else {
        audioPlayer.currentTime = 0;
        [audioPlayer stop];
    }
}

- (IBAction) alarmButton:(id)sender {
    
    if (alarmButton.style != UIBarButtonItemStyleDone) {
        alarmButton.style = UIBarButtonItemStyleDone;
        [self setAlarm:TRUE];
        
    } else {
        alarmButton.style = UIBarButtonItemStyleBordered;
        [self setAlarm:FALSE];
    }

}

- (void) setAlarm:(BOOL) state {
    
    if (state == TRUE) {
        [self runAlarm];
    } else {
        [alarmTicker invalidate];
    }
}

- (void)settingsViewDigFinish:(SettingsViewController*)settingsViewController {
    
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    UIColor *labelColor = appDelegate.timeColor;
    
    [timeLabel setTextColor:labelColor];
    [timeLabel setAlpha:appDelegate.sliderValue];
    
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:appDelegate.soundURL] error:NULL];
    
    [self dismissModalViewControllerAnimated:YES];
}


- (void)alarmSettingsViewDigFinish:(AlarmSettingsViewController*)alarmSettingsViewController {
    
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    alarmPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:appDelegate.alarmURL] error:NULL];
    
    [self dismissModalViewControllerAnimated:YES];
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController {
    
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    UIColor *labelColor = appDelegate.timeColor;
    
    [timeLabel setTextColor:labelColor];
    [timeLabel setAlpha:appDelegate.sliderValue];
    
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:appDelegate.soundURL] error:NULL];
    alarmPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:appDelegate.alarmURL] error:NULL];
    
}

@end
