//
//  SettingsController.m
//  ForYou
//
//  Created by Shannon Rush on 4/14/12.
//  Copyright (c) 2012 Rush Devo. All rights reserved.
//

#import "SettingsController.h"
#import "AsynchRequest.h"

@interface SettingsController ()

@end

@implementation SettingsController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabBarItem.title = @" My MintChip";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(IBAction)checkStatus:(id)sender {
    [AppDelegate setSenderID:[[sender titleLabel]text]];
    AsynchRequest *request = [[AsynchRequest alloc]init];
    request.controller = self;
    [request asynchRequest:@"info/json" withMethod:@"GET" withContentType:@"application/x-www-form-urlencoded" withData:nil];
    
    // tmp log request
    //    GET /mintchip/payments/{startindex}/{stopindex}/{responseformat}
//    [request asynchRequest:@"payments/0/20/json" withMethod:@"GET" withContentType:@"application/x-www-form-urlencoded" withData:nil];
    
    // tmp receipts request
//    GET /mintchip/receipts/{startindex}/{stopindex}/{responseformat}
//   [request asynchRequest:@"receipts/0/20/json" withMethod:@"GET" withContentType:@"application/x-www-form-urlencoded" withData:nil];
}

-(void) handleAsynchResponse:(NSDictionary *)data {
    if ([[data allKeys]containsObject:@"balance"])
        [self displayBalance:data];
}

-(void)displayBalance:(NSDictionary *)data {
    idLabel.text = [NSString stringWithFormat:@"MintChip ID: %@",[data valueForKey:@"id"]];
    balanceLabel.text = [NSString stringWithFormat:@"Balance: %@",[data valueForKey:@"balance"]];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
