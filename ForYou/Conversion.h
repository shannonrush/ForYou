//
//  Conversion.h
//  ForYou
//
//  Created by Shannon Rush on 4/18/12.
//  Copyright (c) 2012 Rush Devo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Conversion : NSObject

+(unsigned int)convertHexStringToIntegerValue:(NSString *)string;
+(NSString *)convertIntegerToBinaryString:(unsigned int)integer;
+(NSString *)convertHexToBinary:(NSString *)string;
+(UInt8)convertBinaryStringToUInt8:(NSString *)binaryString;

@end
