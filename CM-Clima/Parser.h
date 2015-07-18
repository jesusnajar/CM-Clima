//
//  Parser.h
//  CM-Clima
//
//  Created by 0x00 on 18/07/15.
//  Copyright (c) 2015 jesusnajar. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "Declarations.h"

@interface Parser : NSObject
+ (void)parseWeather:(NSDictionary*)json;
@end

