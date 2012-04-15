//
//  SettingsController.m
//  ForYou
//
//  Created by Shannon Rush on 4/14/12.
//  Copyright (c) 2012 Rush Devo. All rights reserved.
//

#import "SettingsController.h"

@interface SettingsController ()

@end

@implementation SettingsController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(IBAction)checkStatus {
    [self asynchRequest:@"info/json" withMethod:@"GET" withContentType:@"application/x-www-form-urlencoded" withData:nil];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
