//
//  Declarations.h
//  CM-Clima
//
//  Created by 0x00 on 18/07/15.
//  Copyright (c) 2015 jesusnajar. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <Foundation/Foundation.h>
#import "SBJson.h"

//Debug
#define nDebugEnable        1
#define print(x)            if(nDebugEnable){(x);}

//Json modes
#define nGET                0
#define nPOST               1

extern NSString *mstTemp;
extern NSString *mstHumidity;
extern NSString *mstPressure;
extern NSString *mstTempMin;
extern NSString *mstTempMax;

@interface Declarations : NSObject
+ (NSDictionary *)getWeather:(float)lat and:(float)lng;
@end



//@interface Declarations : UITableViewCell

//@end
