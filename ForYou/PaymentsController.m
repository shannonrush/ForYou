//
//  PaymentsController.m
//  ForYou
//
//  Created by Shannon Rush on 4/19/12.
//  Copyright (c) 2012 Rush Devo. All rights reserved.
//

#import "PaymentsController.h"

@interface PaymentsController ()

@end

@implementation PaymentsController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) 
        self.tabBarItem.title = @"Payments";
    return self;
}

- (void)viewDidLoad
{
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

@end
