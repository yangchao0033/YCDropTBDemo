//
//  ViewController.m
//  YCDropTBDemo
//
//  Created by 超杨 on 15/10/15.
//  Copyright (c) 2015年 超杨. All rights reserved.
//

#import "ViewController.h"
#import "YCDropTB.h"


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UIButton *btn3;


@property (weak, nonatomic) IBOutlet UILabel *lbl;

@property (weak, nonatomic) IBOutlet UITextField *tf;

/** 下拉列表 */
@property (nonatomic, strong) YCDropTB *dropVC;

@property (nonatomic, strong) NSMutableArray *testData1;

@property (nonatomic, strong) NSMutableArray *testData2;

@property (nonatomic, strong) NSMutableArray *testData3;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _testData1 = @[].mutableCopy;
    _testData2 = @[].mutableCopy;
    _testData3 = @[].mutableCopy;
    
    for (int i = 0; i < 10; ++i) {
        NSString *str1 = [NSString stringWithFormat:@"%d", i];
        NSString *str2 = [NSString stringWithFormat:@"%d", i + 20];
        NSString *str3 = [NSString stringWithFormat:@"%d", i + 30];
        [_testData1 addObject:str1];
        [_testData2 addObject:str2];
        [_testData3 addObject:str3];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)showDropTB:(UIButton *)sender {
    
    if (sender == _btn1) {
        
        self.dropVC.dataSource = self.testData1;
        
    }else if (sender == _btn2) {
        
        
        self.dropVC.dataSource = self.testData2;
        
    }else {
        
        self.dropVC.dataSource = self.testData3;
    }
    
    [self.dropVC showBlowView:sender];
}


- (YCDropTB *)dropVC
{
    if (_dropVC == nil) {
        // 将model数据转换为能用的数组
        NSMutableArray *ma = @[].mutableCopy;
        
        _dropVC = [YCDropTB YCDropTBWithDataSource:ma backIndexOfDataSource:^(NSInteger index, UIView * __nullable blewView) {

            NSLog(@"选中索引为%tu", index);
            
            if (blewView == _btn1) {
            
                _lbl.text = _tf.text = _testData1[index];
                
                
                /** 设置参数 */
            } else  if( blewView == _btn2 ){
                _lbl.text = _tf.text = _testData2[index];
                

                /** 设置参数 */
            } else {
                
                _lbl.text = _tf.text = _testData3[index];
            
            }
            
        }];
    }
#warning 提示
    /** 可以手动设置尺寸 */
//    _dropVC.Size = CGSizeMake(100, 100);
    
    return _dropVC;
}


@end
