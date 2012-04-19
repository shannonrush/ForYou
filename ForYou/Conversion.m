//
//  Conversion.m
//  ForYou
//
//  Created by Shannon Rush on 4/18/12.
//  Copyright (c) 2012 Rush Devo. All rights reserved.
//

#import "Conversion.h"

@implementation Conversion

+ (unsigned int)convertHexStringToIntegerValue:(NSString *)string {
	NSScanner *scanner = [[NSScanner alloc] initWithString:string];
	unsigned int retval;
	if (![scanner scanHexInt:&retval]) {
		NSLog(@"Invalid hex string");
		return 0;
	}
	return retval;
}

+(NSString *)convertIntegerToBinaryString:(unsigned int)integer {
	NSMutableString *str = [NSMutableString stringWithString:@""];
	for(NSInteger numberCopy = integer; numberCopy > 0; numberCopy >>= 1) {
		[str insertString:((numberCopy & 1) ? @"1" : @"0") atIndex:0];
	}
	return str;
}

+(NSString *)convertHexToBinary:(NSString *)string {
	unsigned int integer = [self convertHexStringToIntegerValue:string];
	return [self convertIntegerToBinaryString:integer];
}

+(UInt8)convertBinaryStringToUInt8:(NSString *)binaryString {
	const char *binary = [binaryString UTF8String];
	unsigned long ul = strtoul(binary, NULL, 2);
	return (UInt8)ul;
}


@end
