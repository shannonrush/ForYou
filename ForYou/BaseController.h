//
//  BaseController.h
//  ForYou
//
//  Created by Shannon Rush on 4/14/12.
//  Copyright (c) 2012 Rush Devo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Security/Security.h>

@interface BaseController : UIViewController <NSURLConnectionDelegate> {
	NSMutableData *responseData;
}

-(void) noConnectionAlert;
-(void) errorAlert:(NSArray *)errors;
-(NSURL *) constructURL:(NSString *)path;
-(void) asynchRequest:(NSString *)path withMethod:(NSString *)method withContentType:(NSString *)contentType withData:(NSString *)data;
-(void) handleAsynchResponse:(NSDictionary *)data;

@end
