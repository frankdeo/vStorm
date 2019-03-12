//
//  AppDelegate.h
//  vStorm
//
//  Created by Frank Deo on 9/3/12.
//  Copyright (c) 2012 Version 40 Software, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
    
    UIColor *timeColor;
    NSString *soundURL;
    NSString *timeoutTime;
    float sliderValue;
    NSInteger selectedSoundSegment;
    
    NSDate *alarmDate;
    NSInteger selectedAlarmSegment;
    NSString *alarmURL;

}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) ViewController *viewController;
@property (nonatomic, retain) UIColor *timeColor;
@property (nonatomic, retain) NSString *timeoutTime;
@property (nonatomic) float sliderValue;
@property (nonatomic, retain) NSString *soundURL;
@property (nonatomic) NSInteger selectedSoundSegment;
@property (nonatomic, retain) NSDate *alarmDate;
@property (nonatomic) NSInteger selectedAlarmSegment;
@property (nonatomic, retain) NSString *alarmURL;
@end
