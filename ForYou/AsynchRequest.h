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
#import "NSData+Additions.h"
#import "Conversion.h"

@interface AsynchRequest : UIViewController <NSURLConnectionDelegate> {
	NSMutableData *responseData;
    NSHTTPURLResponse *httpResponse;
}

@property(nonatomic) UIViewController *controller;
@property(nonatomic) NSString *requestType;

-(void) noConnectionAlert;
-(NSURL *) constructURL:(NSString *)path;
-(void) asynchRequest:(NSString *)path withMethod:(NSString *)method withContentType:(NSString *)contentType withData:(NSString *)data;
-(void) responseRequest:(NSData *)data;



@end

@interface UIViewController (Asynch)

-(void) handleAsynchResponse:(NSDictionary *)data;

@end
