//
//  ViewController.h
//  warmRoom
//
//  Created by mao ke on 2017/6/22.
//  Copyright © 2017年 mao ke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DKProgressHUD.h"
#import "openfileRequest.h"
#import "AFNetworking.h"
#import "ActionSheetPicker.h"

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *weatherLable;
@property (weak, nonatomic) IBOutlet UILabel *sunLable;
@property (weak, nonatomic) IBOutlet UILabel *co2Lable;
@property (weak, nonatomic) IBOutlet UILabel *tempLable;
@property (weak, nonatomic) IBOutlet UILabel *humLable;
@property (weak, nonatomic) IBOutlet UILabel *soildHumLable;
@property NSString *weather;
@property (weak, nonatomic) IBOutlet UIImageView *weatherImage;
@property (weak, nonatomic) IBOutlet UIButton *downTemp;
@property (weak, nonatomic) IBOutlet UIButton *controlSun;
@property (weak, nonatomic) IBOutlet UIButton *autoZheyang;
@property (weak, nonatomic) IBOutlet UIButton *autoFengji;
@property (weak, nonatomic) IBOutlet UISwitch *autoSwitch;
@property (weak, nonatomic) IBOutlet UILabel *zheyangLable;
@property (weak, nonatomic) IBOutlet UILabel *soilHum;
@property (weak, nonatomic) IBOutlet UILabel *lable1;
@property (weak, nonatomic) IBOutlet UILabel *lable2;
@property (weak, nonatomic) IBOutlet UIButton *refrushBtn;
@end

