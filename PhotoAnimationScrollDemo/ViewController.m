//
//  ViewController.m
//  PhotoAnimationScrollDemo
//
//  Created by MKJING on 16/8/9.
//  Copyright © 2016年 MKJING. All rights reserved.
//

#import "ViewController.h"
#import "MKJMainPopoutView.h"
#import "MKJConstant.h"
#import "MKJItemModel.h"
#import <Masonry.h>

@interface ViewController () <MKJMainPopoutViewDelegate>

@property (nonatomic,strong) UIButton *showButton;
@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) NSMutableArray *dataSource;
@property (nonatomic,strong) MKJMainPopoutView *popView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.showButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.showButton.backgroundColor = [UIColor blueColor];
    [self.showButton setTitle:@"showPhoto" forState:UIControlStateNormal];
    [self.showButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.showButton.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    [self.showButton addTarget:self action:@selector(clickShowPhoto:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.showButton];
    [self.showButton mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).with.offset(60);
        make.size.mas_equalTo(CGSizeMake(200, 80));
        
    }];
    
    
    self.imageView = [[UIImageView alloc] init];
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.image = [UIImage imageNamed:@"0"];
    [self.view addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.showButton.mas_bottom).with.offset(50);
        make.size.mas_equalTo(CGSizeMake(200, 200));
        
    }];
}

// 点击加载popView到self.view上面
- (void)clickShowPhoto:(UIButton *)button
{
    [self.popView showInSuperView:self.view];
    
}
// 弹窗内部collectionView item的点击回调
- (void)closePopView
{
    [self.popView removeFromSuperview];
}

- (void)selectedHero:(MKJItemModel *)item
{
    [self closePopView];
    self.imageView.image = [UIImage imageNamed:item.imageName];
}

#pragma mark - 懒加载数据
- (MKJMainPopoutView *)popView
{
    if (_popView == nil) {
        _popView = [[MKJMainPopoutView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _popView.dataSource = self.dataSource;
        _popView.delegate = self;
    }
    return _popView;
}

- (NSMutableArray *)dataSource
{
    if (_dataSource == nil) {
        _dataSource = [[NSMutableArray alloc] init];
        for (NSInteger i = 0; i < 11; i ++) {
            MKJItemModel *model = [[MKJItemModel alloc] init];
            model.imageName = [NSString stringWithFormat:@"%zd",i];
            model.titleName = [NSString stringWithFormat:@"第%zd张",i];
            [_dataSource addObject:model];
        }
    }
    return _dataSource;
}







- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
