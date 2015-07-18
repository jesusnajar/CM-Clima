//
//  ViewController.h
//  CM-Clima
//
//  Created by 0x00 on 17/07/15.
//  Copyright (c) 2015 jesusnajar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Declarations.h"
#import "Parser.h"

@interface Start : UIViewController

@property (nonatomic,strong)    Declarations            *Declarations;
@property (nonatomic,strong)    Parser                  *Parser;


//Table
@property (strong, nonatomic) IBOutlet UITableView *tblMain;

//labels
@property (strong, nonatomic) IBOutlet UILabel *lblTemp;
@property (strong, nonatomic) IBOutlet UILabel *lblMax;
@property (strong, nonatomic) IBOutlet UILabel *lblMin;
@property (strong, nonatomic) IBOutlet UILabel *lblPressure;
@property (strong, nonatomic) IBOutlet UILabel *lblHumidity;

//Button
- (IBAction)btnClima:(id*)sender;

@end

