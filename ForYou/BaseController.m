//
//  BaseController.m
//  ForYou
//
//  Created by Shannon Rush on 4/14/12.
//  Copyright (c) 2012 Rush Devo. All rights reserved.
//

#import "BaseController.h"

@implementation BaseController

- (void)viewDidLoad {
	responseData = [NSMutableData data];
    [super viewDidLoad];
}

-(void) errorAlert:(NSArray *)errors {
    NSString *alertErrors = [errors componentsJoinedByString:@"\n"];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Unable To Save" message:alertErrors delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

-(NSURL *) constructURL:(NSString *)path {
    NSString *urlString=[NSString stringWithFormat:@"%@%@",@"https://remote.mintchipchallenge.com/mintchip/", path];
    return [NSURL URLWithString:urlString];
}

-(void) noConnectionAlert {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Unable to Connect" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

-(void)connection:(NSURLConnection *)connection willSendRequestForAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
    NSLog(@"in will send request");
    NSString *thePath = [[NSBundle mainBundle] pathForResource:@"1310000000004997" ofType:@"p12"];
    NSData *PKCS12Data = [[NSData alloc] initWithContentsOfFile:thePath];
    CFDataRef inPKCS12Data = (__bridge_retained CFDataRef)PKCS12Data; 
    OSStatus status = noErr;
    SecIdentityRef myIdentity;
    SecTrustRef myTrust;
    status = extractIdentityAndTrust(inPKCS12Data,&myIdentity,&myTrust); 
    // status should be 0
    SecTrustResultType trustResult;
    if (status == noErr) {                                      // 3
        status = SecTrustEvaluate(myTrust, &trustResult);
    }
    NSURLCredential *credential = [NSURLCredential credentialWithIdentity:myIdentity certificates:<#(NSArray *)#> persistence:<#(NSURLCredentialPersistence)#>
    //    [challenge.sender useCredential:credential forAuthenticationChallenge:challenge];
}

OSStatus extractIdentityAndTrust(CFDataRef inPKCS12Data,SecIdentityRef *outIdentity,SecTrustRef *outTrust) {
    OSStatus securityError = errSecSuccess;
    CFStringRef password = CFSTR("9MAEyq3B");
    const void *keys[] =   { kSecImportExportPassphrase };
    const void *values[] = { password };
    CFDictionaryRef optionsDictionary = CFDictionaryCreate(NULL, keys, values, 1, NULL, NULL);  
    CFArrayRef items = CFArrayCreate(NULL, 0, 0, NULL);
    securityError = SecPKCS12Import(inPKCS12Data,optionsDictionary,&items);
    if (securityError == 0) {                                   // 8
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


- (void)useCredential:(NSURLCredential *)credential forAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
    NSLog(@"in use credential");
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
    NSLog(@"did receive auth challenge");
}

-(void) asynchRequest:(NSString *)path withMethod:(NSString *)method withContentType:(NSString *)contentType withData:(NSString *)dataString {
    NSURL *url = [self constructURL:path]; 
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];

    if (dataString != nil && [dataString length] > 0) {
        [request setHTTPBody:[dataString dataUsingEncoding:NSISOLatin1StringEncoding]];
    }
    [request setHTTPMethod:method];
    [request setValue:contentType forHTTPHeaderField:@"content-type"];
    [[NSURLConnection alloc] initWithRequest:request delegate:self]; 
}

-(void) handleAsynchResponse:(NSDictionary *)data {
    //Override in subclasses unless your response is a no-op for some reason
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
    NSError *jsonParsingError = nil;
    NSDictionary *data = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:&jsonParsingError];        
    NSLog(@"%@", data);
    [self handleAsynchResponse:data];
}

@end
