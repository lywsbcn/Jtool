//
//  JPageView.h
//  IQKeyboardManager
//
//  Created by w on 2019/1/25.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,JPageViewAlign) {
    JPageViewAlignTop,
    JPageViewAlignBottom,
};
@class JPageView;
@protocol JPageViewDataSource<NSObject>
@required
-(NSInteger)numOfPage:(JPageView*)pageView;

-(UIView*)pageView:(JPageView*)pageView viewAtIndex:(NSInteger)index;

@optional
-(UIButton*)pageView:(JPageView*)pageView buttonAtIndex:(NSInteger)index;

@end


@protocol JPageViewDelegate<NSObject>

@optional
/*滚动到 某个页面,index相同 也会调用*/
-(void)pageView:(JPageView*)pageView didScorllToView:(UIView*)tableView atIndex:(NSInteger)index;

/*选中了某个按钮,index不相同时才会调用*/
-(void)pageView:(JPageView*)pageView didSelectedButton:(UIButton*)button atIndex:(NSInteger)index;

/*已经取消选中某个按钮,index不相同时才会调用*/
-(void)pageView:(JPageView *)pageView unSelectedButton:(UIButton *)button atIndex:(NSInteger)index;

/*选中了某个页面,index不相同时才会调用*/
-(void)pageView:(JPageView *)pageView didSelectedView:(UIView *)tableView atIndex:(NSInteger)index;

/*已经取消选中某个页面,index不相同时才会调用*/
-(void)pageView:(JPageView*)pageView unSelectedView:(UIView*)tableView atIndex:(NSInteger)index;

@end

@interface JPageView : UIView



@property(nonatomic,assign)NSInteger index;

#pragma mark- 下划线
@property(nonatomic,strong)UIView * lineView;

@property(nonatomic,assign)CGSize lineSize;
@property(nonatomic,copy)UIColor * lineColor;

@property(nonatomic,strong)UIImageView * headView;
@property(nonatomic,assign)CGFloat heightOfHeadView;


@property(nonatomic,copy)UIFont * headNormarlFont;
@property(nonatomic,copy)UIFont * headSelectedFont;

@property(nonatomic,copy)UIColor * headNormarlColor;
@property(nonatomic,copy)UIColor * headSelectedColor;

@property(nonatomic,strong)UIScrollView * scrollView;

@property(nonatomic,strong)NSMutableArray <UIView*>*tableViewList;

@property(nonatomic,strong)NSMutableArray <UIButton *>*buttonList;

@property(nonatomic,weak)id<JPageViewDataSource>  dateSource;

@property(nonatomic,weak)id<JPageViewDelegate>  delegate;

@property(nonatomic,assign)JPageViewAlign titleAlignment;

@property(nonatomic,assign)BOOL titleHidden;
//-(void)setTitleViewHidden:(BOOL)hidden;

/*
 需要在布局后调用,否则会有警告..虽然不影响效果
 */
-(void)reload;

-(void)scrollToIndex:(NSInteger)index;

@end
