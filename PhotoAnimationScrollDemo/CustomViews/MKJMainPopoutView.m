//
//  MKJMainPopoutView.m
//  PhotoAnimationScrollDemo
//
//  Created by MKJING on 16/8/9.
//  Copyright © 2016年 MKJING. All rights reserved.
//

#import "MKJMainPopoutView.h"
#import "MKJConstant.h"
#import "NSArray+Extension.h"
#import "UIView+Extension.h"
#import <Masonry.h>
#import "MKJCollectionViewCell.h"
#import "MKJCollectionViewFlowLayout.h"
#import "MKJItemModel.h"
#import <UIImageView+WebCache.h>
#import "MKJCircleLayout.h"
#import "MKJOverLayLayout.h"

@interface MKJMainPopoutView () <UICollectionViewDelegate,UICollectionViewDataSource,MKJCollectionViewFlowLayoutDelegate>

@property (nonatomic,strong) UIView *underBackView;
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UIButton *selectedButton;
@property (nonatomic,strong) UIButton *closeButton;
@property (nonatomic,assign) NSInteger selectedIndex; // 选择了哪个


@property (nonatomic,strong) UIButton *transformLayoutButton;

@property (nonatomic,strong) NSMutableArray *datas;
@end

static NSString *indentify = @"MKJCollectionViewCell";

@implementation MKJMainPopoutView
{
    NSInteger _selectedIndex;
}

// self是继承于UIView的，给上面的第一个View容器加个动画
- (void)showInSuperView:(UIView *)superView
{
    CAKeyframeAnimation *popAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    popAnimation.duration = 0.25;
    popAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1f, 0.1f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0f, 1.0f, 1.0f)]];
    popAnimation.keyTimes = @[@0.2f, @1.0f];
    popAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [superView addSubview:self];
    [self.underBackView.layer addAnimation:popAnimation forKey:nil];
    
    
}

// 初始化 设置背景颜色透明点，然后加载子视图
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame])
    {
        _selectedIndex = 0;
        self.backgroundColor = RGB(51, 51, 51, 0.5);
        [self addsubviews];
    }
    return self;
}

// 加载子视图
- (void)addsubviews
{
    [self addSubview:self.underBackView];
    [self.underBackView addSubview:self.collectionView];
    [self.underBackView addSubview:self.transformLayoutButton];
    [self.underBackView addSubview:self.nameLabel];
    [self.underBackView addSubview:self.selectedButton];
    [self.underBackView addSubview:self.closeButton];
    [self.closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(self.underBackView.mas_right).with.offset(-5);
        make.top.equalTo(self.underBackView.mas_top).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(30, 30));
        
    }];
    
    [self.selectedButton mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.equalTo(self.underBackView);
        make.bottom.equalTo(self.underBackView.mas_bottom).with.offset(-10);
        make.size.mas_equalTo(CGSizeMake(200, 30));
        
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.equalTo(self.selectedButton);
        make.bottom.equalTo(self.selectedButton.mas_top).with.offset(-10);
        make.size.mas_equalTo(CGSizeMake(200, 45));
    }];
    
    [self.transformLayoutButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.selectedButton);
        make.bottom.equalTo(self.nameLabel.mas_top).with.offset(-20);
        make.size.mas_equalTo(CGSizeMake(100, 30));
    }];
    
}

#pragma makr - collectionView delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.datas.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MKJItemModel *model = self.datas[indexPath.item];
    MKJCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:indentify forIndexPath:indexPath];
    cell.heroImageVIew.image = [UIImage imageNamed:model.imageName];
    return cell;
}

// 点击item的时候
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%@",indexPath);
    if ([self.collectionView.collectionViewLayout isKindOfClass:[MKJCollectionViewFlowLayout class]]) {
        CGPoint pInUnderView = [self.underBackView convertPoint:collectionView.center toView:collectionView];
        
        // 获取中间的indexpath
        NSIndexPath *indexpathNew = [collectionView indexPathForItemAtPoint:pInUnderView];
        
        if (indexPath.row == indexpathNew.row)
        {
            NSLog(@"点击了同一个");
            return;
        }
        else
        {
            [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
        }
    }
    else if ([self.collectionView.collectionViewLayout isKindOfClass:[MKJCircleLayout class]])
    {
        _selectedIndex = 0;
        [self labelText:_selectedIndex];
        [self.datas removeObjectAtIndex:indexPath.item];
        [self.collectionView deleteItemsAtIndexPaths:@[indexPath]];
    }
    else
    {
        
    }
}


#pragma mark - 懒加载
- (UIView *)underBackView
{
    if (_underBackView == nil) {
        _underBackView = [[UIView alloc] init];
        _underBackView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
        _underBackView.originX = 30;
        _underBackView.originY = 60;
        _underBackView.width = SCREEN_WIDTH - 2 * _underBackView.originX;
        _underBackView.height = SCREEN_HEIGHT - 2 * _underBackView.originY;
        _underBackView.layer.cornerRadius = 5;
        _underBackView.layer.borderColor = [UIColor redColor].CGColor;
        _underBackView.layer.borderWidth = 2.0f;
    }
    return _underBackView;
}

- (UILabel *)nameLabel
{
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.backgroundColor = [UIColor whiteColor];
        _nameLabel.font = [UIFont boldSystemFontOfSize:20];
        _nameLabel.textColor = [UIColor blueColor];
        _nameLabel.layer.cornerRadius = 5.0f;
        _nameLabel.layer.borderColor = [UIColor blackColor].CGColor;
        _nameLabel.layer.borderWidth = 2.0f;
    }
    return _nameLabel;
}

- (UIButton *)transformLayoutButton
{
    if (_transformLayoutButton == nil) {
        _transformLayoutButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_transformLayoutButton setTitle:@"变身" forState:UIControlStateNormal];
        [_transformLayoutButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        _transformLayoutButton.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        [_transformLayoutButton addTarget:self action:@selector(transformLayout) forControlEvents:UIControlEventTouchUpInside];
        _transformLayoutButton.layer.cornerRadius = 10;
        _transformLayoutButton.layer.borderColor = [UIColor whiteColor].CGColor;
        _transformLayoutButton.layer.borderWidth = 2.0f;
    }
    return _transformLayoutButton;
}

- (void)transformLayout
{
    if ([self.collectionView.collectionViewLayout isKindOfClass:[MKJCollectionViewFlowLayout class]]) {
        [self.collectionView setCollectionViewLayout:[[MKJCircleLayout alloc]init] animated:YES];
        
    }else if ([self.collectionView.collectionViewLayout isKindOfClass:[MKJCircleLayout class]])
    {
        [self.collectionView setCollectionViewLayout:[[MKJOverLayLayout alloc]init] animated:YES];
        
    }else
    {
        MKJCollectionViewFlowLayout *flow = [[MKJCollectionViewFlowLayout alloc] init];
        flow.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flow.itemSize = CGSizeMake(self.underBackView.width / 2, self.underBackView.width - 100);
        flow.minimumLineSpacing = 30;
        flow.minimumInteritemSpacing = 30;
        flow.needAlpha = YES;
        flow.delegate = self;
        CGFloat oneX =self.underBackView.width / 4;
        flow.sectionInset = UIEdgeInsetsMake(0, oneX, 0, oneX);
        [self.collectionView setCollectionViewLayout:flow animated:YES];
        [self.collectionView selectItemAtIndexPath:[NSIndexPath indexPathForItem:_selectedIndex inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
    }
    
}

- (UIButton *)selectedButton
{
    if (_selectedButton == nil) {
        _selectedButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _selectedButton.backgroundColor = [UIColor blackColor];
        [_selectedButton setTitle:@"选这个" forState:UIControlStateNormal];
        [_selectedButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_selectedButton addTarget:self action:@selector(chooseDone:) forControlEvents:UIControlEventTouchUpInside];
        _selectedButton.layer.cornerRadius = 20.0f;
        _selectedButton.layer.borderWidth = 2.0f;
        _selectedButton.layer.borderColor = [UIColor whiteColor].CGColor;
    }
    return _selectedButton;
}
- (void)chooseDone:(UIButton *)button
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectedHero:)]) {
        [self.delegate selectedHero:self.datas[_selectedIndex]];
    }
}

- (UIButton *)closeButton
{
    if (_closeButton == nil) {
        _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _closeButton.backgroundColor = [UIColor redColor];
        [_closeButton setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
        [_closeButton addTarget:self action:@selector(close:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeButton;
}

- (void)close:(UIButton *)button
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(closePopView)]) {
        [self.delegate closePopView];
    }
}

- (UICollectionView *)collectionView
{
    if (_collectionView == nil) {
        MKJCollectionViewFlowLayout *flow = [[MKJCollectionViewFlowLayout alloc] init];
        flow.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flow.itemSize = CGSizeMake(self.underBackView.width / 2, self.underBackView.width - 100);
        flow.minimumLineSpacing = 30;
        flow.minimumInteritemSpacing = 30;
        flow.needAlpha = YES;
        flow.delegate = self;
        CGFloat oneX =self.underBackView.width / 4;
        flow.sectionInset = UIEdgeInsetsMake(0, oneX, 0, oneX);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 30, self.underBackView.bounds.size.width, self.underBackView.bounds.size.height * 0.65) collectionViewLayout:flow];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerNib:[UINib nibWithNibName:indentify bundle:nil] forCellWithReuseIdentifier:indentify];
    }
    return _collectionView;
}


#pragma CustomLayout的代理方法
- (void)collectioViewScrollToIndex:(NSInteger)index
{
    [self labelText:index];
    _selectedIndex = index;
}


// 第一次加载的时候刷新collectionView
- (void)setDataSource:(NSArray *)dataSource
{
    _dataSource = dataSource;
    self.datas = [[NSMutableArray alloc] initWithArray:self.dataSource];
    [self labelText:0];
    [self.collectionView reloadData];
}

// 给指定的label赋值
- (void)labelText:(NSInteger)idx
{
    MKJItemModel *model = self.datas[idx];
    self.nameLabel.text = model.titleName;
}






@end
