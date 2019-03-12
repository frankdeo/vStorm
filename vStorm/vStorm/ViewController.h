//
//  ViewController.h
//  vStorm
//
//  Created by Frank Deo on 9/3/12.
//  Copyright (c) 2012 Version 40 Software, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "SettingsViewController.h"
#import "AlarmSettingsViewController.h"

@interface ViewController : UIViewController <UIPopoverControllerDelegate, SettingsViewControllerDelegate, UIPopoverControllerDelegate, AlarmSettingsViewControllerDelegate> {
    
    AVAudioPlayer *audioPlayer;
    AVAudioPlayer *alarmPlayer;
    NSURL *url;
    UIPopoverController *popoverController;
    UIPopoverController *alarmPopoeverController;
    UIPopoverController *aboutHelpPopoverController;
    IBOutlet UILabel *timeLabel;
    NSTimer *myTicker;
    NSTimer *flashTicker;
    NSTimer *myAlarm;
    IBOutlet UIBarButtonItem *lightningButton;
    IBOutlet UIBarButtonItem *soundsButton;
    IBOutlet UIBarButtonItem *alarmButton;
    UIColor *timeColor;
    NSDate *currentTime;
    NSTimer *alarmTicker;
    IBOutlet UIButton *stopAlarmButton;
    NSTimer *stopEverythingTimer;
    
}

- (void) flashScreen;
- (void) displayWhite;
- (void) displayBlack;
- (void) runTimer;
- (void) showTime;
- (void) runFlashTimer;
- (IBAction) settingsButtonPressed:(id)sender;
- (IBAction) alarmSettingsButtonPressed:(id)sender;
- (IBAction) aboutButtonPressed:(id)sender;
- (BOOL) deviceIsAniPad;
- (IBAction) lightningButton:(id)sender;
- (IBAction) soundsButton:(id)sender;
- (IBAction) alarmButton:(id)sender;
- (void) setLightning:(BOOL) state;
- (void) setSounds:(BOOL) state;
- (void) setAlarm:(BOOL) state;
- (void) fireAlarm;
- (void) runAlarm;
- (IBAction) stopAlarm:(id)sender;
- (void) stopEverything;
- (void) stopEverythingTimer;


@property (nonatomic, retain) UIPopoverController *popoverController;
@property (nonatomic, retain) UIPopoverController *alarmPopoverController;
@property (nonatomic, retain) UIPopoverController *aboutHelpPopoverController;
@end
