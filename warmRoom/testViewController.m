//
//  testViewController.m
//  warmRoom
//
//  Created by mao ke on 2017/7/21.
//  Copyright © 2017年 mao ke. All rights reserved.
//

#import "testViewController.h"

@interface testViewController ()

@end

@implementation testViewController
- (IBAction)yuanc:(id)sender {
    NSLog(@"lalalalahahahaha");
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    CGRect rect = [[UIScreen mainScreen] bounds];
//    CGSize size = rect.size;
//    CGFloat height = size.height;
    //    NSLog(@"%@", [NSString stringWithFormat:@"%f",height]);
    CGRect rect = [[UIScreen mainScreen] bounds];
    CGSize size = rect.size;
    CGFloat height = size.height;
    CGFloat width = size.width;
    NSLog(@"%@*%@", [NSString stringWithFormat:@"%f",height],[NSString stringWithFormat:@"%f",width]);
    if (height<569) {
        _yuancheng.hidden = YES;
        _autowater.hidden = YES;
        _realplay.hidden = YES;
        _backplay.hidden = YES;
        _yuanchenglable.hidden = YES;
        _autolable.hidden = YES;
        _realplaylable.hidden = YES;
        _backplaylable.hidden = YES;
        UIButton *yc = [[UIButton alloc]initWithFrame:CGRectMake(15, 425,50,50)];
        [yc setBackgroundImage:[UIImage imageNamed:@"remotecontrol"] forState:UIControlStateNormal];
        [yc addTarget:self action:@selector(yuanc:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:yc];
        UIButton *aw = [[UIButton alloc]initWithFrame:CGRectMake(90, 420,60,60)];
        [aw setBackgroundImage:[UIImage imageNamed:@"control"] forState:UIControlStateNormal];
        [self.view addSubview:aw];
        UIButton *rp = [[UIButton alloc]initWithFrame:CGRectMake(172.5, 422.5,55,55)];
        [rp setBackgroundImage:[UIImage imageNamed:@"realplay"] forState:UIControlStateNormal];
        [self.view addSubview:rp];
        UIButton *bp = [[UIButton alloc]initWithFrame:CGRectMake(250, 420,60,60)];
        [bp setBackgroundImage:[UIImage imageNamed:@"backplay"] forState:UIControlStateNormal];
        [self.view addSubview:bp];
        UILabel *ycl = [[UILabel alloc]initWithFrame:CGRectMake(10, 490, 60, 20)];
        ycl.text = @"远程浇水";
        ycl.font = [UIFont fontWithName:@"Helvetica" size:15];
        [self.view addSubview:ycl];
        UILabel *awl = [[UILabel alloc]initWithFrame:CGRectMake(90, 490, 60, 20)];
        awl.text = @"自动浇水";
        awl.font = [UIFont fontWithName:@"Helvetica" size:15];
        [self.view addSubview:awl];
        UILabel *rpl = [[UILabel alloc]initWithFrame:CGRectMake(170, 490, 60, 20)];
        rpl.text = @"实时视频";
        rpl.font = [UIFont fontWithName:@"Helvetica" size:15];
        [self.view addSubview:rpl];
        UILabel *bpl = [[UILabel alloc]initWithFrame:CGRectMake(250, 490, 60, 20)];
        bpl.text = @"视频回放";
        bpl.font = [UIFont fontWithName:@"Helvetica" size:15];
        [self.view addSubview:bpl];
    }
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
