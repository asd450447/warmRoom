//
//  ViewController.m
//  warmRoom
//
//  Created by mao ke on 2017/6/22.
//  Copyright © 2017年 mao ke. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property NSString *judge;
@property NSString *mac;
@property NSInteger i;
@end

@implementation ViewController

- (IBAction)refreshData:(id)sender {
    [DKProgressHUD showLoadingToView:self.view];
    _judge = @"refrush";
    [[openfileRequest sharedNewtWorkTool]sendMessage:@"GETALL" Mac:_mac];
}

//手动遮阳开关
- (IBAction)downTempClick:(id)sender {
    _judge = @"Timer";
    NSArray *percente = [NSArray arrayWithObjects:@"开启",@"关闭",@"10",@"30",@"60", nil];
    [ActionSheetStringPicker showPickerWithTitle:@"选择开启时间"
                                            rows:percente
                                initialSelection:0
                                       doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                           if ([selectedValue isEqualToString:@"开启"]) {
                                               [[openfileRequest sharedNewtWorkTool]sendMessage:@"Manual#1,0" Mac:_mac];
                                           }
                                           else if ([selectedValue isEqualToString:@"关闭"]) {
                                               [[openfileRequest sharedNewtWorkTool]sendMessage:@"Manual#1,1" Mac:_mac];
                                               _judge = @"Manual#1,1";
                                           }
                                           else{
                                               [[openfileRequest sharedNewtWorkTool]sendMessage:[NSString stringWithFormat:@"Timer#%@",selectedValue] Mac:_mac];
                                           }
                                           
                                           dispatch_async(dispatch_get_main_queue(), ^{
                                               [DKProgressHUD showLoading];
                                           });
                                       }
                                     cancelBlock:^(ActionSheetStringPicker *picker) {
                                         NSLog(@"Block Picker Canceled");
                                     }
                                          origin:sender];
}

//手动浇灌
- (IBAction)waterClick:(id)sender {
    _judge = @"Manual#4";
    NSArray *percente = [NSArray arrayWithObjects:@"开启",@"关闭",@"1",@"5",@"10",@"15", nil];
    [ActionSheetStringPicker showPickerWithTitle:@"选择浇灌时间"
                                            rows:percente
                                initialSelection:0
                                       doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                           if ([selectedValue isEqualToString:@"开启"]) {
                                               [[openfileRequest sharedNewtWorkTool]sendMessage:@"Manual#4,0" Mac:_mac];
                                           }
                                           else if ([selectedValue isEqualToString:@"关闭"]) {
                                               [[openfileRequest sharedNewtWorkTool]sendMessage:@"Manual#4,1" Mac:_mac];
                                               _judge = @"Manual#4,1";
                                           }else{
                                               [[openfileRequest sharedNewtWorkTool]sendMessage:[NSString stringWithFormat:@"set#%@",selectedValue] Mac:_mac];
                                           }
                                           dispatch_async(dispatch_get_main_queue(), ^{
                                               [DKProgressHUD showLoading];
                                           });
                                       }
                                     cancelBlock:^(ActionSheetStringPicker *picker) {
                                         NSLog(@"Block Picker Canceled");
                                     }
                                          origin:sender];
}

//手动遮阳开关
- (IBAction)controlSunClick:(id)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"遮阳控制" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"开启" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [DKProgressHUD showLoading];
            _judge = @"Manual#3,1";
            [[openfileRequest sharedNewtWorkTool]sendMessage:@"Manual#3,1" Mac:_mac];
        });
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [DKProgressHUD showLoading];
        _judge = @"Manual#3,0";
        [[openfileRequest sharedNewtWorkTool]sendMessage:@"Manual#3,0" Mac:_mac];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"停止" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [DKProgressHUD showLoading];
        _judge = @"Manual#3,2";
//        [[openfileRequest sharedNewtWorkTool]sendMessage:@"Manual#3,2" Mac:_mac];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }]];
    [self presentViewController:alert animated:YES completion:nil];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _mac = @"F0FE6B4B4E84";
//    _mac = @"accf234b88f2";
    _i = 0;
    [DKProgressHUD showLoadingToView:self.view];
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    [def setObject:@"18852866235" forKey:@"userName"];
    [def setObject:@"123456" forKey:@"passWord"];
    [def synchronize];
    
    [_refrushBtn.layer setBorderColor:[UIColor whiteColor].CGColor];
    [_refrushBtn.layer setBorderWidth:1];
    [_refrushBtn.layer setMasksToBounds:YES];
    _refrushBtn.layer.cornerRadius = 5.0f;
    _refrushBtn.layer.masksToBounds = YES;
    [_refrushBtn setTitle:@"点击刷新" forState:UIControlStateNormal];
    
    [[openfileRequest sharedNewtWorkTool]connectToHost];
    _judge = @"refrush";
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refrushLable) name:@"receiveMessage" object:nil];
}


//自动控制开关按钮
- (IBAction)switchClick:(id)sender {
    if (_autoSwitch.on == YES) {
        dispatch_async(dispatch_get_main_queue(), ^{
            _zheyangLable.hidden = false;
            _autoZheyang.hidden = false;
            _soilHum.hidden = false;
            _autoFengji.hidden = false;
            _lable1.hidden = NO;
            _lable2.hidden = NO;
        });
    }else{
        dispatch_async(dispatch_get_main_queue(), ^{
            _zheyangLable.hidden = YES;
            _autoZheyang.hidden = YES;
            _soilHum.hidden = YES;
            _autoFengji.hidden = YES;
            _lable1.hidden = YES;
            _lable2.hidden = YES;
            _judge = @"Autorunclose";
            [[openfileRequest sharedNewtWorkTool]sendMessage:@"Runclose" Mac:_mac];
        });
    }
}

//自动控制遮阳温度
- (IBAction)zheyangClick:(id)sender {
    _judge = @"OpenAutoRun";
    NSArray *percente = [NSArray arrayWithObjects:@"20",@"25", @"30",@"35",@"40",@"45", nil];
    [ActionSheetStringPicker showPickerWithTitle:@"选择温度℃"
                                            rows:percente
                                initialSelection:0
                                       doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                           [_autoZheyang setTitle:[NSString stringWithFormat:@"%@%@",selectedValue,@"℃"] forState:UIControlStateNormal];
                                           [[openfileRequest sharedNewtWorkTool]sendMessage:[NSString stringWithFormat:@"Autorun#%@",selectedValue] Mac:_mac];
                                       }
                                     cancelBlock:^(ActionSheetStringPicker *picker) {
                                         NSLog(@"Block Picker Canceled");
                                     }
                                          origin:sender];
}
//自动控制风机温度
- (IBAction)fengjiClick:(id)sender {
    _judge = @"OpenAutoRun";
    NSArray *percente = [NSArray arrayWithObjects:@"20",@"25", @"30",@"35",@"40",@"45", nil];
    [ActionSheetStringPicker showPickerWithTitle:@"选择湿度%"
                                            rows:percente
                                initialSelection:0
                                       doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                           [_autoZheyang setTitle:[NSString stringWithFormat:@"%@%@",selectedValue,@"%"] forState:UIControlStateNormal];
                                           [[openfileRequest sharedNewtWorkTool]sendMessage:[NSString stringWithFormat:@"Autorun#%@",selectedValue] Mac:_mac];
                                       }
                                     cancelBlock:^(ActionSheetStringPicker *picker) {
                                         NSLog(@"Block Picker Canceled");
                                     }
                                          origin:sender];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
//    [[openfileRequest sharedNewtWorkTool]sendMessage:@"" Mac:_mac];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)refrushLable{
    NSString *mes = [[openfileRequest sharedNewtWorkTool]reciveMessage];
    if ([_judge isEqualToString:@"refrush"]) {
        NSArray *arr = [mes componentsSeparatedByString:@","];
        NSLog(@"%@", arr);
        if (arr.count >6) {
            dispatch_async(dispatch_get_main_queue(), ^{
                _sunLable.text = [NSString stringWithFormat:@"%@%@",arr[1],@"lux"];
                _tempLable.text = [NSString stringWithFormat:@"%@%@",arr[2],@"℃"];
                _humLable.text = [NSString stringWithFormat:@"%@%@",arr[3],@"%"];
                _soildHumLable.text = [NSString stringWithFormat:@"%@%@",arr[0],@"%"];
                _co2Lable.text = [NSString stringWithFormat:@"%@%@",arr[4],@""];
                if ([arr[6] isEqualToString:@"0"]) {
                    _autoSwitch.on = false;
                    _autoZheyang.hidden = YES;
                    _lable1.hidden = YES;
                    _lable2.hidden = YES;
                    _zheyangLable.hidden = YES;
                }else{
                    _autoSwitch.on = YES;
                    _autoZheyang.hidden = NO;
                    _lable1.hidden = NO;
                    _lable2.hidden = NO;
                    _zheyangLable.hidden = NO;
                    [_autoZheyang setTitle:[NSString stringWithFormat:@"%@%@",arr[5],@"℃"] forState:UIControlStateNormal];
                }
                if (_i == 0) {
                    [self getWeather];
                }else{
                    [DKProgressHUD dismissForView:self.view];
                    [DKProgressHUD showSuccessWithStatus:@"数据刷新成功！" toView:self.view];
                }
                _i++;
            });
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                [DKProgressHUD showErrorWithStatus:@"获取环境数据失败" toView:self.view];
            });
        }
    }
    if ([_judge isEqualToString:@"Timer"]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [DKProgressHUD dismiss ];
            if ([mes isEqualToString:@"Timer_Exist!"]) {
                [DKProgressHUD showInfoWithStatus:@"风机正在运行" toView:self.view];
            }else{
                [DKProgressHUD showSuccessWithStatus:@"风机开启成功" toView:self.view];
            }
        });
    }
    if ([_judge isEqualToString:@"Manual#4"]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [DKProgressHUD dismiss];
            [DKProgressHUD showSuccessWithStatus:@"开启浇灌" toView:self.view];
        });
    }
    if ([_judge isEqualToString:@"Manual#1,1"]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [DKProgressHUD dismiss];
            [DKProgressHUD showSuccessWithStatus:@"风机关闭成功" toView:self.view];
        });
    }
    if ([_judge isEqualToString:@"Manual#4,1"]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [DKProgressHUD dismiss];
            [DKProgressHUD showSuccessWithStatus:@"浇灌关闭成功" toView:self.view];
        });
    }
    if ([_judge isEqualToString:@"Manual#3,0"]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [DKProgressHUD dismiss ];
            if ([mes isEqualToString:@"zheyang close"]) {
                [DKProgressHUD showInfoWithStatus:@"遮阳已关闭" toView:self.view];
            }else{
                [DKProgressHUD showSuccessWithStatus:@"遮阳关闭成功" toView:self.view];
            }
        });
    }
    if ([_judge isEqualToString:@"Manual#3,1"]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [DKProgressHUD dismiss ];
            if ([mes isEqualToString:@"zheyang open"]) {
                [DKProgressHUD showInfoWithStatus:@"遮阳已开启" toView:self.view];
            }else{
                [DKProgressHUD showSuccessWithStatus:@"遮阳开启成功" toView:self.view];
            }
        });
    }
    if ([_judge isEqualToString:@"Autorunclose"]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [DKProgressHUD showSuccessWithStatus:@"自动控制关闭成功" toView:self.view];
        });
    }
    if ([_judge isEqualToString:@"OpenAutoRun"]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [DKProgressHUD showSuccessWithStatus:@"自动控制开启成功" toView:self.view];
        });
    }
    _judge = @"";
}

-(void)getWeather{
    //    NSString *strURL =@"";
    //    NSURL *url = [NSURL URLWithString:strURL];
    
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    NSDictionary *params = @{
                             @"cityname" : @"镇江",
                             @"key" : @"8a9fcef45a44b211652af449a28f494c",
                             };
    
    [sessionManager POST:@"https://op.juhe.cn/onebox/weather/query" parameters:params constructingBodyWithBlock:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        _weather = responseObject[@"result"][@"data"][@"realtime"][@"weather"][@"info"];
        NSLog(@"%@", _weather);
        dispatch_async(dispatch_get_main_queue(), ^{
            _weatherImage.image = [UIImage imageNamed:[self judgeWeather:_weather]];
            _weatherLable.text = _weather;
            [DKProgressHUD dismissForView:self.view];
            [DKProgressHUD dismiss];
        });
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"post failure:%@",error);
    }];
}

-(id)judgeWeather:(NSString *)weather{
    if ([weather isEqualToString:@"晴"]) {
        return @"ic_sunny_big";
    }
    else if ([weather isEqualToString:@"多云"]) {
        return @"ic_cloudy_big";
    }
    else if ([weather isEqualToString:@"阴"]) {
        return @"ic_overcast_big";
    }
    else if ([weather isEqualToString:@"雾"]) {
        return @"cloud";
    }
    else if ([weather isEqualToString:@"暴风雨"]) {
        return @"ic_nightrain_big";
    }
    else if ([weather isEqualToString:@"阵雨"]) {
        return @"ic_shower_big";
    }
    else if ([weather isEqualToString:@"大雨"]) {
        return @"ic_heavyrain_big";
    }
    else if ([weather isEqualToString:@"中雨"]) {
        return @"ic_moderraterain_big";
    }
    else if ([weather isEqualToString:@"小雨"]) {
        return @"ic_lightrain_big";
    }
    else if ([weather isEqualToString:@"雨夹雪"]) {
        return @"ic_sleet_big";
    }
    else if ([weather isEqualToString:@"暴雪"]) {
        return @"ic_snow_big";
    }
    else if ([weather isEqualToString:@"阵雪"]) {
        return @"ic_snow_big";
    }
    else if ([weather isEqualToString:@"大雪"]) {
        return @"ic_heavysnow_big";
    }
    else if ([weather isEqualToString:@"中雪"]) {
        return @"ic_snow_big";
    }
    else if ([weather isEqualToString:@"小雪"]) {
        return @"ic_snow_big";
    }
    else if ([weather isEqualToString:@"霾"]) {
        return @"ic_haze_big";
    }
    else if ([weather isEqualToString:@"冰雹"]) {
        return @"freezing_rain_day_night";
    }else{
        return @"sunny";
    }
}

@end
