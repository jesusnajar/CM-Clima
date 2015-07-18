//
//  CustomizedCell.h
//  CM-Clima
//
//  Created by 0x00 on 18/07/15.
//  Copyright (c) 2015 jesusnajar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomizedCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *lblTemp;
@property (strong, nonatomic) IBOutlet UILabel *lblPresion;
@property (strong, nonatomic) IBOutlet UILabel *lblHumedad;

@end
