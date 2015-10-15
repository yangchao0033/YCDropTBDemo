//
//  YCDropTB.m
//  YCDropTBDemo
//
//  Created by 超杨 on 15/10/15.
//  Copyright (c) 2015年 超杨. All rights reserved.
//

#import "YCDropTB.h"
#import "UIView+Frame.h"
#define KEY_WINDOW [UIApplication sharedApplication].keyWindow
#define SCREEN_HEIGHT   ([UIScreen mainScreen].bounds.size.height)          //界面高
#define SCREEN_WIDTH    ([UIScreen mainScreen].bounds.size.width)           //界面宽

static  NSString  * const kCellID = @"FZLDropTBViewCell";

@interface YCDropTB ()<UITableViewDelegate, UITableViewDataSource>

/** 蒙版view */
@property (nonatomic, strong) UIButton *bgView;

/** 列表需要显示在这个blewView下 */
@property (nonatomic, strong) UIView *blewView;

@property (weak, nonatomic) IBOutlet UITableView *tableView;



@end

@implementation YCDropTB


#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.autoresizingMask = UIViewAutoresizingNone;
    self.view.autoresizesSubviews = NO;
    
    // 注册cell
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCellID];
    
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)])
    {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)])
    {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
    
    if (self.dataSource == nil) {
        self.dataSource = @[].mutableCopy;
    }
}

#pragma mark - ControllerDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellID];
    
    cell.textLabel.text = self.dataSource[indexPath.row];
    UIView *view = [[UIView alloc] initWithFrame:cell.contentView.frame];
    view.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.2];
    cell.backgroundView = view;
    
    return cell;
    
}
#pragma mark - ControllerDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.backIndexOfDataSource) {
        self.backIndexOfDataSource(indexPath.row, self.blewView);
    }
    [self dismiss];
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)])
    {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)])
    {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}
#pragma mark - CustomDelegate
#pragma mark - private methods
+ (nonnull instancetype )YCDropTBWithDataSource:(NSMutableArray  * __nonnull)dataSource
{
    YCDropTB *vc = [[self alloc] init];
    vc.dataSource = dataSource;
    vc.view.layer.cornerRadius = 5;
    //    vc.view.layer.masksToBounds = YES;
    vc.view.layer.borderColor = [UIColor colorWithRed:188/255.0 green:186/255.0 blue:193/255.0 alpha:1.0].CGColor;
    //    vc.view.layer.borderWidth = 0.5;
    
    //    vc.view.layer.shadowPath = [UIBezierPath bezierPathWithRect:vc.view.frame].CGPath;
    vc.view.layer.shadowColor = [UIColor blackColor].CGColor;
    vc.view.layer.masksToBounds = NO;
    vc.view.layer.shadowOffset = CGSizeMake(3, 3);
    vc.view.layer.shadowRadius = 6;
    vc.view.layer.shadowOpacity = 0.8;
    UIView *view = [[UIView alloc] initWithFrame:vc.tableView.frame];
    view.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.2];
    vc.tableView.backgroundView = view;
    
    return vc;
}

+ (nonnull instancetype)YCDropTBWithDataSource:(NSMutableArray * __nonnull)dataSource backIndexOfDataSource:(void (^ __nullable)(NSInteger index, UIView * __nullable blewView))backIndex
{
    YCDropTB *vc = [self YCDropTBWithDataSource:dataSource];
    vc.backIndexOfDataSource = backIndex;
    return vc;
}

- (void)showBlowView:(UIView * __nonnull)view
{
    /** 注销所有键盘 */
    [KEY_WINDOW endEditing:YES];
    
    self.blewView = view;
    self.bgView = [[UIButton alloc] init];
    self.bgView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    
    self.bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
    
    [self.bgView addTarget:self action:@selector(dismiss) forControlEvents:(UIControlEventTouchDown)];
    
    [KEY_WINDOW addSubview:self.bgView];
    
    CGRect frameToScreen = [view convertRect:self.view.bounds toView:nil];
    
    frameToScreen.origin.y += view.height + 1;
    
    if (_Size.width == 0 && _Size.height == 0) {
        
        frameToScreen.size.width = view.width;
        
        frameToScreen.size.height = SCREEN_HEIGHT * 0.5;
        
    } else {
        
        frameToScreen.size = _Size;
    }
    
    
    if (CGRectGetMaxY(frameToScreen) > SCREEN_HEIGHT) {
        frameToScreen.origin.y -= (view.height + 1 + frameToScreen.size.height + 1);
    }
    
    self.view.frame = frameToScreen;
    
    [self.bgView addSubview:self.view];
    
    self.view.alpha = 0.0f;
    
    [UIView animateWithDuration:0.2 animations:^{
        
        self.view.alpha = 1.0f;
        
    } completion:^(BOOL finished) {
        
    }];
    
}



- (void)dismiss
{
    
    [UIView animateWithDuration:0.2 animations:^{
        
        self.view.alpha = 0.0f;
        
    } completion:^(BOOL finished) {
        
        [self.bgView removeFromSuperview];
        self.bgView = nil;
    }];
}

#pragma mark - getter and setter

- (void)setSize:(CGSize)Size
{
    _Size = Size;
    self.view.size = Size;
    [self.view setNeedsDisplay];

}

- (void)setDataSource:(NSMutableArray * __nonnull)dataSource
{
    _dataSource = dataSource;
    
    [self.tableView reloadData];
}

@end
