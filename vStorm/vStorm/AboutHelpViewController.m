//
//  AboutHelpViewController.m
//  vStorm
//
//  Created by Frank Deo on 9/10/12.
//  Copyright (c) 2012 Version 40 Software, LLC. All rights reserved.
//

#import "AboutHelpViewController.h"

@interface AboutHelpViewController ()

@end

@implementation AboutHelpViewController

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
    
    [self dismissModalViewControllerAnimated:YES];
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

@end
