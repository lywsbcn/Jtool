//
//  TrendLiveViewController.m
//  BeautifulSow
//
//  Created by dandan on 16/4/11.
//  Copyright © 2016年 Mars. All rights reserved.
//
#import "SDAdScrollView.h"
#import "UIImageView+WebCache.h"

#import "NSTimer+Addition.h"


@implementation SDAdScrollViewItem

+(instancetype)createWithImageUrl:(id)image_url andTargetUrl:(NSString *)target_url{
    SDAdScrollViewItem * item = [SDAdScrollViewItem new];
    
    item.image_url = image_url;
    item.target_url = target_url;
    
    return item;
}

+(instancetype)createWithDictionary:(NSDictionary *)dictionary andKey:(NSArray <NSString*>*)key{
    if(key.count <2) return nil;
    
    id image_url = [dictionary objectForKey:key[0]];
    
    NSString * target_url = [dictionary objectForKey:key[1]];
    
    return [self createWithImageUrl:image_url andTargetUrl:target_url];
}

+(instancetype)createWithDictionary:(NSDictionary *)dictionary{
    return [self createWithDictionary:dictionary andKey:@[@"img",@"url"]];
}


+(NSArray<SDAdScrollViewItem *> *)createListWithArray:(NSArray *)list andKey:(NSArray<NSString *> *)key{
    NSMutableArray * data = [NSMutableArray array];
    for(NSDictionary * dic in list){
        [data addObject:[self createWithDictionary:dic andKey:key]];
    }
    return  data;
}

+(NSArray<SDAdScrollViewItem *> *)createListWithArray:(NSArray *)list{
    NSMutableArray *data =[NSMutableArray array];
    for(NSDictionary * dic in list){
        [data addObject:[self createWithDictionary:dic]];
    }
    return data;
}

@end

@interface SDAdScrollView ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIImageView *currentImageView;
@property (nonatomic, strong) UIImageView *leftImageView;
@property (nonatomic, strong) UIImageView *rightImageView;

@property(nonatomic,assign)BOOL isCall;
@end


@implementation SDAdScrollView

-(void)awakeFromNib{
    [super awakeFromNib];
    
    [super layoutSubviews];
    
    [self setDefaultParame];
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setDefaultParame];
    }
    return self;
}

-(void)setDefaultParame{
    _baseUrl = @"";
    
    _cmodel = UIViewContentModeScaleAspectFill;
    
    _animationDuration = 2.0f;
    
    _leftImageView = [[UIImageView alloc]init];
    _leftImageView.clipsToBounds = YES;
    _leftImageView.contentMode = _cmodel;
    [self.scrollView addSubview:_leftImageView];
    
    _rightImageView = [[UIImageView alloc]init];
    _rightImageView.contentMode = _cmodel;
    _rightImageView.clipsToBounds = YES;
    [self.scrollView addSubview:_rightImageView];
    
    _currentImageView = [[UIImageView alloc]init];
    _currentImageView.contentMode = _cmodel;
    _currentImageView.clipsToBounds = YES;
    [self.scrollView addSubview:_currentImageView];
    
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onGesture:)];
    [self.scrollView addGestureRecognizer:tapGesture];
}

-(void)setCmodel:(UIViewContentMode)cmodel{
    _cmodel = cmodel;
    
    _currentImageView.contentMode = cmodel;
    _leftImageView.contentMode = cmodel;
    _rightImageView.contentMode = cmodel;
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    _leftImageView.frame = CGRectMake(0, 0, CGRectGetWidth(self.scrollView.bounds), CGRectGetHeight(self.scrollView.bounds));
    
    _currentImageView.frame = CGRectOffset(_leftImageView.frame, CGRectGetWidth(_leftImageView.frame), 0);
    
    _rightImageView.frame = CGRectOffset(_currentImageView.frame, CGRectGetWidth(_currentImageView.frame), 0);
}

-(void)setScrollViewEdge:(UIEdgeInsets)scrollViewEdge
{
    _scrollViewEdge = scrollViewEdge;
    CGRect rect = self.scrollView.frame;
    
    self.scrollView.frame = CGRectMake(CGRectGetMinX(rect)+_scrollViewEdge.left,
                                       CGRectGetMinY(rect)+_scrollViewEdge.top,
                                       CGRectGetWidth(rect)-_scrollViewEdge.left-_scrollViewEdge.right,
                                       CGRectGetHeight(rect)-_scrollViewEdge.top-_scrollViewEdge.bottom);
}
#pragma mark - Action

-(void)onTimer:(NSTimer*)timer
{
//    DLog(@"adScrollView onTimer");
    [self.scrollView setContentOffset:CGPointMake(CGRectGetWidth(self.bounds)*2, 0) animated:YES];
}

-(void)onGesture:(UITapGestureRecognizer*)tapGesture
{
    if (self.tapActionBlock) {
        self.tapActionBlock(self,self.adList[self.currentPage]);
    }
}

#pragma mark - setter

-(void)setAdList:(NSArray<SDAdScrollViewItem*>*)adList
{
    
    _adList = adList;
    self.pageControl.numberOfPages = _adList.count;
    self.pageControl.currentPage = 0;
    _currentPage = 0;
    
    
    
    if (![_timer isValid]) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:_animationDuration target:self selector:@selector(onTimer:) userInfo:nil repeats:YES];
        [_timer pauseTimer];
    }
    
    
    if (_adList.count <= 1) {
         [self.timer pauseTimer];
        self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.bounds), 0);
    }else{
        _scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.bounds)*3, 0);
        [_timer resumeTimerAfterTimeInterval:_animationDuration];
    }
    
    [self refreshImageView];
}


//根据当前的index，重置当前显示的图片，并且使currentImageView永远保持在中间
-(void)refreshImageView
{
    NSInteger index = _currentPage;
    
    [self formatImageView:_currentImageView index:index];
    
    
    
    index = _currentPage-1<0?self.adList.count-1:_currentPage-1;
    [self formatImageView:_leftImageView index:index];
    
    index = _currentPage+1>=self.adList.count?0:_currentPage+1;
    [self formatImageView:_rightImageView index:index];
    
    self.scrollView.contentOffset = CGPointMake(CGRectGetWidth(self.bounds), 0);
}

//根据数组中类型判断如何展示图片
-(void)formatImageView:(UIImageView*)imageView index:(NSInteger)index
{
    
    SDAdScrollViewItem * item = self.adList[index];
    
    id data = item.image_url;
    
    
    if ([data isKindOfClass:[UIImage class]]) {
        imageView.image = (UIImage*)data;
    }else if ([data isKindOfClass:[NSString class]]) {
        NSString *imageName =[NSString stringWithFormat:@"%@%@",_baseUrl, (NSString*)data];
        if ([imageName hasPrefix:@"http"]) {
            __weak typeof(self) weekSelf = self;
            //网络图片
//            [imageView sd_setImageWithURL:[NSURL URLWithString:imageName] placeholderImage:_placeHolderImage];
            [imageView sd_setImageWithURL:[NSURL URLWithString:imageName] placeholderImage:_placeHolderImage completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                if(weekSelf.imageDidLoad && !item.completed){
                    item.completed = YES;
                    weekSelf.imageDidLoad(weekSelf, index);
                }
            }];
        }else{
            //本地图片
            imageView.image = [UIImage imageNamed:imageName];
        }
    }
}


-(void)refreshCurrentPage
{
    if (self.scrollView.contentOffset.x >= CGRectGetWidth(self.bounds)*1.5) {
        
        _currentPage ++;
        
        if (_currentPage > self.adList.count-1) {
            _currentPage = 0;
        }
    }else if (self.scrollView.contentOffset.x <= CGRectGetWidth(self.bounds)/2) {
        _currentPage--;
        
        if (_currentPage < 0) {
            _currentPage = self.adList.count-1;
        }
    }
}


#pragma mark - UI
-(UIPageControl*)pageControl
{
    if (!_pageControl) {
        CGRect rect = CGRectMake(40, CGRectGetHeight(self.bounds)-20, CGRectGetWidth(self.bounds)-40*2, 10);
        _pageControl = [[UIPageControl alloc]initWithFrame:rect];
        _pageControl.hidesForSinglePage = YES;
        _pageControl.pageIndicatorTintColor = [UIColor grayColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
        [self addSubview:_pageControl];
    }
    return _pageControl;
}

-(UIScrollView*)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
        _scrollView.delegate = self;
        _scrollView.bounces = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.scrollsToTop = NO;
        _scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.bounds)*3, 0);
        [self addSubview:_scrollView];
    }
    return _scrollView;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    //开始滚动时暂停定时器
    [self.timer pauseTimer];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self refreshCurrentPage];
    
    if (self.pageControl.currentPage != _currentPage) {
        self.pageControl.currentPage = _currentPage;
        [self refreshImageView];
    }
    //滚动结束回复定时器
    [self.timer resumeTimerAfterTimeInterval:_animationDuration];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self refreshCurrentPage];
    
    if (self.pageControl.currentPage != _currentPage) {
        self.pageControl.currentPage = _currentPage;
        [self refreshImageView];
    }
}

@end
