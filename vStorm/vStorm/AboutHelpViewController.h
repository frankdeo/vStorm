//
//  AboutHelpViewController.h
//  vStorm
//
//  Created by Frank Deo on 9/10/12.
//  Copyright (c) 2012 Version 40 Software, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutHelpViewController : UIViewController {
    
    IBOutlet UIButton *dismissButton;
}

- (IBAction) dismissButtonPressed:(id)sender;
- (BOOL) deviceIsAniPad;

@end
