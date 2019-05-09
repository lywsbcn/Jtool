//
//  JPageView.m
//  IQKeyboardManager
//
//  Created by w on 2019/1/25.
//

#import "JPageView.h"
#import "Masonry.h"

@interface JPageView()<UIScrollViewDelegate>

@property(nonatomic,assign)NSInteger count;

@end

@implementation JPageView


-(void)awakeFromNib{
    [super awakeFromNib];
    
    [self setDefaultParam];
    
    [self autoLayout];
    
}

-(instancetype)init{
    if(self =[super init]){
        [self setDefaultParam];
        
        [self autoLayout];
    }
    return self;
}


-(void)setDefaultParam{
    _index = -1;
    
    _lineSize = CGSizeMake(50, 2);
    _lineColor =[UIColor whiteColor];
    
    _headSelectedFont =[UIFont systemFontOfSize:14];
    _headNormarlFont =[UIFont systemFontOfSize:13];
    
    _headSelectedColor =[UIColor whiteColor];
    _headNormarlColor =[UIColor lightGrayColor];
}


-(void)autoLayout{
    [self addSubview:self.headView];
    
    
    
    [self addSubview:self.scrollView];
    
    [self reLyout];
}


-(void)setTitleAlignment:(JPageViewAlign)titleAlignment{
    _titleAlignment = titleAlignment;
    
    [self reLyout];
}
-(void)reLyout{
    
    if(self.titleAlignment == JPageViewAlignTop){
        [self.headView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.left.equalTo(self);
            make.right.equalTo(self.mas_right);
            make.height.offset(self->_heightOfHeadView==0 ? 50 : self->_heightOfHeadView);
        }];
        [self.scrollView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(self);
            make.left.equalTo(self);
            make.bottom.equalTo(self.mas_bottom);
            if(!self->_headView){
                make.top.equalTo(self);
            }else{
                make.top.equalTo(self.headView.mas_bottom).offset(2);
            }
        }];
    }else{
        [self.headView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.mas_bottom);
            make.left.equalTo(self);
            make.right.equalTo(self.mas_right);
            make.height.offset(self->_heightOfHeadView==0 ? 50 : self->_heightOfHeadView);
        }];
        [self.scrollView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(self);
            make.left.equalTo(self);
            make.top.equalTo(self);
            if(!self->_headView){
                make.bottom.equalTo(self.mas_bottom);
            }else{
                make.bottom.equalTo(self.headView.mas_top).offset(2);
            }
        }];
    }
    
}

-(void)setTitleHidden:(BOOL)titleHidden{
    _titleHidden = titleHidden;
    if(!_headView) return;
    if(titleHidden){
        _headView.hidden = YES;
        [_headView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.offset(0);
        }];
    }else{
        _headView.hidden = YES;
        [_headView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.offset(self->_heightOfHeadView==0 ? 50 : self->_heightOfHeadView);
        }];
    }
    
}

-(void)reload{
    [self layoutIfNeeded];
    
    self.count = [self.dateSource numOfPage:self];
    
    [self createHeadButton];
    
    [self createTableViews];
    
    [self createStatusLine:0];
}

-(void)createHeadButton{
    
    if([self.dateSource respondsToSelector:@selector(pageView:buttonAtIndex:)]){
        
    }else{
        [self setTitleHidden:YES];
        return;
    }
    for(NSInteger i=0;i<self.count;i++){
        
        UIButton * button =[self.dateSource pageView:self buttonAtIndex:i];
        [button setTitleColor:_headNormarlColor forState:UIControlStateNormal];
        button.titleLabel.font = _headNormarlFont;
        button.tag = i;
        [button addTarget:self action:@selector(buttonClickListener:) forControlEvents:UIControlEventTouchUpInside];
        [self.headView addSubview:button];
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.headView);
            make.bottom.equalTo(self.headView.mas_bottom);
            if(i==0){
                make.left.equalTo(self.headView);
            }else{
                make.left.equalTo(self.buttonList[i-1].mas_right);
            }
            if(i==self.count-1){
                make.right.equalTo(self.headView.mas_right);
            }else{
                make.width.equalTo(self.headView).multipliedBy(1.0/self.count);
            }
        }];
        
        [self.buttonList addObject:button];
        
        if(i==0){
            [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self.headView.mas_bottom);
                make.height.offset(self.lineSize.height);
                make.centerX.equalTo(button.mas_centerX);
                make.width.offset(self.lineSize.width);
            }];
        }
        
    }
}

-(void)buttonClickListener:(UIButton*)sender{
    [self scrollToIndex:sender.tag];
}

-(void)scrollToIndex:(NSInteger)index{
    [UIView animateWithDuration:0.3 animations:^{
        self.scrollView.contentOffset=CGPointMake(self.scrollView.frame.size.width*index, 0);
    }];
}

-(void)createStatusLine:(NSInteger)index{
    
    
    if(self.tableViewList.count > index){
        if([self.delegate respondsToSelector:@selector(pageView:didScorllToView:atIndex:)]){
            [self.delegate pageView:self didScorllToView:self.tableViewList[index] atIndex:index];
        }
        if(self.index != index){
            
            if(self.buttonList.count-1<=index){
            
                if([self.delegate respondsToSelector:@selector(pageView:unSelectedButton:atIndex:)] && self.index >=0){
                    [self.delegate pageView:self unSelectedButton:self.buttonList[self.index] atIndex:self.index];
                }
                if([self.delegate respondsToSelector:@selector(pageView:didSelectedButton:atIndex:)]){
                    [self.delegate pageView:self didSelectedButton:self.buttonList[index] atIndex:index];
                }
                
            }
            
            if([self.delegate respondsToSelector:@selector(pageView:unSelectedView:atIndex:)]&& self.index >=0){
                [self.delegate pageView:self unSelectedView:self.tableViewList[self.index] atIndex:index];
            }
            if([self.delegate respondsToSelector:@selector(pageView:didSelectedView:atIndex:)]){
                [self.delegate pageView:self didSelectedView:self.tableViewList[index] atIndex:index];
            }
            
            
            if(self.buttonList.count-1<=index){
                [self.buttonList[index] setTitleColor:self->_headSelectedColor forState:UIControlStateNormal];
                self.buttonList[index].titleLabel.font = self->_headSelectedFont;
                
                if(self.index>=0){
                    [self.buttonList[self.index] setTitleColor:self->_headNormarlColor forState:UIControlStateNormal];
                    self.buttonList[self.index].titleLabel.font = self->_headNormarlFont;
                }
            }
        }
        
    }
    
    
    
    self.index = index;
    
    
}

-(void)createTableViews{
    CGSize size = self.scrollView.contentSize;
    size.width = [UIScreen mainScreen].bounds.size.width * self.count;
    //    size.height= ScreenHeight;
    self.scrollView.contentSize = size;
    
    for(NSInteger i=0;i<self.count;i++){
        UIView * tView = [self.dateSource pageView:self viewAtIndex:i];
        
        [self.scrollView addSubview:tView];
        
        [tView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.scrollView);
            make.width.equalTo(self.scrollView);
            make.height.equalTo(self.scrollView);
            if(i==0){
                make.left.equalTo(self.scrollView);
            }else{
                make.left.equalTo(self.tableViewList[i-1].mas_right);
            }
        }];
        
        [self.tableViewList addObject:tView];
        
    }
}


#pragma mark- scrollView delegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat ox = scrollView.contentOffset.x;
    CGFloat w = scrollView.frame.size.width;
    
    
    CGFloat x = (ox/w);
    CGFloat p = floor(x);
    
    
    //    CGFloat f =1.0*(self.count-1)/self.count * w * (ox/ ((self.count-1)*w));
    CGFloat f2 = ox / self.count;
    
    if(self.count>0){
        _lineView.transform = CGAffineTransformMakeTranslation(f2, 0);
    }
    
    
    if(p==x){
        [self createStatusLine:p];
    }
}




#pragma mark- GET

-(void)setHeightOfHeadView:(CGFloat)heightOfHeadView{
    _heightOfHeadView = heightOfHeadView;
    
    if(_headView){
        [_headView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.offset(heightOfHeadView);
        }];
        
        [self layoutIfNeeded];
    }
}

-(UIImageView *)headView{
    if(!_headView){
        _headView=[[UIImageView alloc]init];
        _headView.userInteractionEnabled = YES;
        _headView.backgroundColor = [UIColor clearColor];
    }
    return _headView;
}

-(UIScrollView *)scrollView{
    if(!_scrollView){
        _scrollView=[[UIScrollView alloc]init];
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.bounces = NO;
        _scrollView.delegate = self;
    }
    return _scrollView;
}

-(void)setLineColor:(UIColor *)lineColor{
    _lineColor = lineColor;
    _lineView.backgroundColor = lineColor;
}

-(UIView *)lineView{
    if(!_lineView){
        _lineView =[[UIView alloc]init];
        _lineView.backgroundColor = _lineColor;
        [_headView addSubview:_lineView];
    }
    return  _lineView;
}

-(NSMutableArray<UIView *> *)tableViewList{
    if(!_tableViewList){
        _tableViewList =[NSMutableArray array];
    }
    return _tableViewList;
}

-(NSMutableArray<UIButton *> *)buttonList{
    if(!_buttonList){
        _buttonList = [NSMutableArray array];
    }
    return _buttonList;
}

-(void)setDateSource:(id<JPageViewDataSource>)dateSource{
    _dateSource = dateSource;
    [self reload];
}


@end
