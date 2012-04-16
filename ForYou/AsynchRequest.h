//
//  AsynchRequest.h
//  ForYou
//
//  Created by Shannon Rush on 4/14/12.
//  Copyright (c) 2012 Rush Devo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Security/Security.h>
#import "AppDelegate.h"

@interface AsynchRequest : UIViewController <NSURLConnectionDelegate> {
	NSMutableData *responseData;
    UIViewController *controller;
}

@property(nonatomic) UIViewController *controller;

-(void) noConnectionAlert;
-(NSURL *) constructURL:(NSString *)path;
-(void) asynchRequest:(NSString *)path withMethod:(NSString *)method withContentType:(NSString *)contentType withData:(NSString *)data;


@end

@interface UIViewController (Asynch)

-(void) handleAsynchResponse:(NSDictionary *)data;

@end
