//
//  SettingsViewController.h
//  vStorm
//
//  Created by Frank Deo on 9/9/12.
//  Copyright (c) 2012 Version 40 Software, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SettingsViewController;

@protocol SettingsViewControllerDelegate
- (void)settingsViewDigFinish:(SettingsViewController*)settingsViewController;
@end

@interface SettingsViewController : UIViewController <UITextFieldDelegate> {

    IBOutlet UIButton *dismissButton;
    IBOutlet UITextField *stopTextField;
    IBOutlet UISegmentedControl *soundsSegmentedControl;
    IBOutlet UISlider *brightnessSlider;
    UIColor *timeColor;
    NSInteger *selectedSoundSegment;
    NSString *timeoutTime;
    float sliderValue;
    IBOutlet UIImageView *textColorImageView;
    id<SettingsViewControllerDelegate> delegate;
    
}

- (IBAction) dismissButtonPressed:(id)sender;
- (BOOL) deviceIsAniPad;
- (IBAction) buttonRed:(id)sender;
- (IBAction) buttonGreen:(id)sender;
- (IBAction) buttonBlue:(id)sender;
- (IBAction) buttonYellow:(id)sender;
- (IBAction) buttonOrange:(id)sender;
- (IBAction) buttonPurple:(id)sender;
- (IBAction) sliderValue:(id)sender;
- (IBAction) segmentValue:(id)sender;

@property (retain) id<SettingsViewControllerDelegate> delegate;

@end
