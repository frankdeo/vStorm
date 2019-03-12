//
//  AlarmSettingsViewController.h
//  vStorm
//
//  Created by Frank Deo on 9/10/12.
//  Copyright (c) 2012 Version 40 Software, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@class AlarmSettingsViewController;

@protocol AlarmSettingsViewControllerDelegate
- (void)alarmSettingsViewDigFinish:(AlarmSettingsViewController*)alarmSettingsViewController;
@end

@interface AlarmSettingsViewController : UIViewController {
    
    AVAudioPlayer *audioPlayer;
    IBOutlet UIButton *dismissButton;
    IBOutlet UIDatePicker *alarmDatePicker;
    IBOutlet UISegmentedControl *alarmSounds;
    NSDate *alarmDate;
    NSInteger *selectedAlarmSegment;
    id<AlarmSettingsViewControllerDelegate> delegate;
    IBOutlet UIButton *testButton;
    IBOutlet UIButton *stopButton;
    IBOutlet UILabel *alarmLabel;
}

- (IBAction) dismissButtonPressed:(id)sender;
- (BOOL) deviceIsAniPad;
- (IBAction) testButtonPressed:(id)sender;
- (IBAction) alarmSoundSelected:(id)sender;
- (IBAction) dismissButtonReleased:(id)sender;
- (void)changeTime:(id)sender;

@property (retain) id<AlarmSettingsViewControllerDelegate> delegate;
@end
