//
//  AsynchRequest.m
//  ForYou
//
//  Created by Shannon Rush on 4/14/12.
//  Copyright (c) 2012 Rush Devo. All rights reserved.
//
#import "AsynchRequest.h"

@implementation AsynchRequest

@synthesize controller,requestType;

-(void) responseRequest:(NSData *)data {
    responseData = [NSMutableData data];
    NSURL *url = [self constructURL:@"receipts"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPBody:data];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/vnd.scg.ecn-message" forHTTPHeaderField:@"content-type"];
    [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

-(void) asynchRequest:(NSString *)path withMethod:(NSString *)method withContentType:(NSString *)contentType withData:(NSString *)dataString {
    responseData = [NSMutableData data];
    NSURL *url = [self constructURL:path]; 
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    if (dataString != nil && [dataString length] > 0) {
        [request setHTTPBody:[dataString dataUsingEncoding:NSISOLatin1StringEncoding]];
    }
    [request setHTTPMethod:method];
    [request setValue:contentType forHTTPHeaderField:@"content-type"];
    [[NSURLConnection alloc] initWithRequest:request delegate:self]; 
}

-(NSURL *) constructURL:(NSString *)path {
    NSString *urlString=[NSString stringWithFormat:@"%@%@",@"https://remote.mintchipchallenge.com/mintchip/", path];
    return [NSURL URLWithString:urlString];
}

-(void) noConnectionAlert {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Unable to Connect" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

-(BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace {
    NSLog(@"in can auth against protection space");
    return YES;
}

-(void)connection:(NSURLConnection *)connection willSendRequestForAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
    NSLog(@"in will send request");
    NSString *thePath = [[NSBundle mainBundle] pathForResource:[AppDelegate senderID] ofType:@"p12"];
    NSData *PKCS12Data = [[NSData alloc] initWithContentsOfFile:thePath];
    CFDataRef inPKCS12Data = (__bridge_retained CFDataRef)PKCS12Data; 
    OSStatus status = noErr;
    SecIdentityRef myIdentity;
    SecTrustRef myTrust;
    status = extractIdentityAndTrust(inPKCS12Data,&myIdentity,&myTrust); 
    SecTrustResultType trustResult;
    if (status == noErr) {                                      
        status = SecTrustEvaluate(myTrust, &trustResult);
    }
    NSMutableArray *myCerts = [NSMutableArray array];
    int numTrusts = SecTrustGetCertificateCount(myTrust);
	for (int i=0; i<numTrusts; i++) {
		[myCerts addObject:(__bridge id)SecTrustGetCertificateAtIndex(myTrust, i)];
	}
    NSURLCredential *credential = [NSURLCredential credentialWithIdentity:myIdentity certificates:myCerts persistence:NSURLCredentialPersistencePermanent];
    [challenge.sender useCredential:credential forAuthenticationChallenge:challenge];
}

OSStatus extractIdentityAndTrust(CFDataRef inPKCS12Data,SecIdentityRef *outIdentity,SecTrustRef *outTrust) {
    NSString *p12PListPath = [[NSBundle mainBundle] pathForResource:@"p12" ofType:@"plist"];
    NSDictionary *p12Dict = [NSDictionary dictionaryWithContentsOfFile:p12PListPath];
    CFStringRef password = (__bridge CFStringRef)[p12Dict valueForKey:[AppDelegate senderID]];
    OSStatus securityError = errSecSuccess;
    const void *keys[] =   { kSecImportExportPassphrase };
    const void *values[] = { password };
    CFDictionaryRef optionsDictionary = CFDictionaryCreate(NULL, keys, values, 1, NULL, NULL);  
    CFArrayRef items = CFArrayCreate(NULL, 0, 0, NULL);
    securityError = SecPKCS12Import(inPKCS12Data,optionsDictionary,&items);
    if (securityError == 0) {                                   
        CFDictionaryRef myIdentityAndTrust = CFArrayGetValueAtIndex (items, 0);
        const void *tempIdentity = NULL;
        tempIdentity = CFDictionaryGetValue (myIdentityAndTrust,kSecImportItemIdentity);
        *outIdentity = (SecIdentityRef)tempIdentity;
        const void *tempTrust = NULL;
        tempTrust = CFDictionaryGetValue (myIdentityAndTrust, kSecImportItemTrust);
        *outTrust = (SecTrustRef)tempTrust;
    }
    
    if (optionsDictionary)
        CFRelease(optionsDictionary);
}


- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
    NSLog(@"did receive auth challenge");
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    NSLog(@"Received response");
    [responseData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    NSLog(@"Received data");
    [responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    [self noConnectionAlert];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    if ([self.requestType isEqualToString:@"transfer"]) {
        [AppDelegate setSenderID:@"1310000000004997"];
        AsynchRequest *request = [[AsynchRequest alloc]init];
        self.requestType = @"response";
        [request responseRequest:responseData];
    } else if ([self.requestType isEqualToString:@"response"]) {
        NSLog(@"in response finished");
    }else {
        NSError *jsonParsingError = nil;
        NSDictionary *data = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:&jsonParsingError];    
        NSLog(@"%@", data);
        [self.controller handleAsynchResponse:data];
    }
}


@end
