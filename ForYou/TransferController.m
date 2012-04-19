//
//  TransferController.m
//  ForYou
//
//  Created by Shannon Rush on 4/16/12.
//  Copyright (c) 2012 Rush Devo. All rights reserved.
//

#import "TransferController.h"

@implementation TransferController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabBarItem.title = @"Transfer";
    }
    return self;
}

-(IBAction)transfer:(id)sender {
    // set sender and receiver
    [AppDelegate setSenderID:[NSString stringWithFormat:@"131000000000%@",[fromControl titleForSegmentAtIndex:[fromControl selectedSegmentIndex]]]];
    int toIndex = abs([fromControl selectedSegmentIndex]-1);
    NSString *receiverID = [NSString stringWithFormat:@"131000000000%@",[fromControl titleForSegmentAtIndex:toIndex]];
    
    // create the transfer record 
    
    // make the transfer request
    AsynchRequest *request = [[AsynchRequest alloc]init];
    request.controller = self;
    request.requestType = @"transfer";
    // POST /mintchip/payments/{payeeid}/{currencycode}/{amountincents}
    int amount = [amountField.text intValue]*100;
    NSString *path = [NSString stringWithFormat:@"payments/%@/1/%i",receiverID,amount];
    [request asynchRequest:path withMethod:@"POST" withContentType:@"application/x-www-form-urlencoded" withData:nil];
}

-(void)handleAsynchResponse:(NSDictionary *)data {
    // if response is 200 delete record
}

@end
