//
//  AppDelegate.m
//  vStorm
//
//  Created by Frank Deo on 9/3/12.
//  Copyright (c) 2012 Version 40 Software, LLC. All rights reserved.
//

#import "AppDelegate.h"

#import "ViewController.h"

@implementation AppDelegate

@synthesize timeColor, timeoutTime, sliderValue, soundURL, selectedSoundSegment, alarmDate, alarmURL, selectedAlarmSegment;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        
        
        self.viewController = [[ViewController alloc] initWithNibName:@"ViewController_iPhone" bundle:nil];
    } else {
        self.viewController = [[ViewController alloc] initWithNibName:@"ViewController_iPad" bundle:nil];
    }
    self.window.rootViewController = self.viewController;
    
    NSUserDefaults *options = [NSUserDefaults standardUserDefaults];
    
    if([options objectForKey:@"timeOutTimeSetting"] != nil) {
        timeoutTime = [options stringForKey:@"timeOutTimeSetting"];
    } else {
        timeoutTime = @"60";
    }
    
    if([options objectForKey:@"sliderValueSetting"] != 0) {
        sliderValue = [options floatForKey:@"sliderValueSetting"];
    } else {
        sliderValue = 0.5;
    }

    if([options objectForKey:@"selectedSoundSegmentSetting"] != nil) {
        selectedSoundSegment = [options integerForKey:@"selectedSoundSegmentSetting"];
    } else {
        selectedSoundSegment = 0;
    }

    NSData *colorData = [options objectForKey:@"timeColorSetting"];
    
    if([options objectForKey:@"timeColorSetting"] != nil) {
        timeColor = [NSKeyedUnarchiver unarchiveObjectWithData:colorData];
    } else {
        timeColor = [UIColor redColor];
    }

    if([options objectForKey:@"soundURLSetting"] != nil) {
        soundURL = [options stringForKey:@"soundURLSetting"];
    } else {
        NSBundle* bundle = [NSBundle mainBundle];
        soundURL = [bundle pathForResource:@"Thunder" ofType:@"mp3"];
    }
    
    if([options objectForKey:@"alarmDateSetting"] != nil) {
        alarmDate = [options objectForKey:@"alarmDateSetting"];
    } else {
        NSDate *timeNow = [[NSDate alloc] init];
        alarmDate = timeNow;
    }
    
    if([options objectForKey:@"alarmURLSetting"] != 0) {
        alarmURL = [options stringForKey:@"alarmURLSetting"];
    } else {
        NSBundle* bundle = [NSBundle mainBundle];
        alarmURL = [bundle pathForResource:@"Beep" ofType:@"mp3"];
    }
    
    if([options objectForKey:@"selectedAlarmSegmentSetting"] != nil) {
        selectedAlarmSegment = [options integerForKey:@"selectedAlarmSegmentSetting"];
    } else {
        selectedAlarmSegment = 0;
    }

    [self.window makeKeyAndVisible];
    
    [[ UIApplication sharedApplication ] setIdleTimerDisabled: YES ];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    NSUserDefaults *options = [NSUserDefaults standardUserDefaults];
 
    [options setObject:timeoutTime forKey:@"timeOutTimeSetting"];
    [options setFloat:sliderValue forKey:@"sliderValueSetting"];
    [options setInteger:selectedSoundSegment forKey:@"selectedSoundSegmentSetting"];
    [options setObject:soundURL forKey:@"soundURLSetting"];
    
    NSData *colorData = [NSKeyedArchiver archivedDataWithRootObject:timeColor];
    [options setObject:colorData forKey:@"timeColorSetting"];
    
    [options setObject:alarmDate forKey:@"alarmDateSetting"];
    [options setObject:alarmURL forKey:@"alarmURLSetting"];
    [options setInteger:selectedAlarmSegment forKey:@"selectedAlarmSegmentSetting"];
    
    [options synchronize];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    NSUserDefaults *options = [NSUserDefaults standardUserDefaults];
    
    [options setObject:timeoutTime forKey:@"timeOutTimeSetting"];
    [options setFloat:sliderValue forKey:@"sliderValueSetting"];
    [options setInteger:selectedSoundSegment forKey:@"selectedSoundSegmentSetting"];
    [options setObject:soundURL forKey:@"soundURLSetting"];
    
    NSData *colorData = [NSKeyedArchiver archivedDataWithRootObject:timeColor];
    [options setObject:colorData forKey:@"timeColorSetting"];
    
    [options setObject:alarmDate forKey:@"alarmDateSetting"];
    [options setObject:alarmURL forKey:@"alarmURLSetting"];
    [options setInteger:selectedAlarmSegment forKey:@"selectedAlarmSegmentSetting"];
    
    [options synchronize];
}

@end
