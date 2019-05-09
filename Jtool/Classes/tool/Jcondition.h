//
//  JHCondition.h
//  happiness
//
//  Created by jh on 2018/5/11.
//  Copyright © 2018年 jh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Jcondition : NSObject

+(Jcondition*)create;
+(Jcondition*)createWithPageSize:(NSInteger)pageSize;

//计算当前 page_index
+(NSInteger)currentPage:(NSDictionary *)condition;

@property(nonatomic,assign)NSInteger page_index;
@property(nonatomic,assign)NSInteger page_size;
@property(nonatomic,assign)NSInteger num_total;
@property(nonatomic,assign)NSInteger total_page;

//告诉请求,是否移除数据源,用新的数据填充, 如果isReload=NO,则在数据源后追加数据
@property(nonatomic,assign)BOOL isReload;

//page_index 已经是最后一页了,没有数据了
@property(nonatomic,assign)BOOL noMoreData;

-(void)countWithDictionary:(NSDictionary*)dictionary;

-(void)countWithPageIndex:(NSInteger)pageIndex andTotal:(NSInteger)numTotal;

-(void)countWithPageIndex:(NSInteger)pageIndex pageSize:(NSInteger)pageSize numTotal:(NSInteger)numTotal;

-(void)countWithPageIndex:(NSNumber*)pageIndex andPageSize:(NSNumber*)pageSize andNumTotal:(NSNumber*)numTotal;

/*第一页,page_index =0; isReload = YES*/
-(void)reloadData;

/*上一页,page_index --
 如果page_index==0,page_index 不变, isChange=NO
 isReload = YES
 */
-(void)prevPage:(void(^)(Jcondition * condition, BOOL isChange))callback;
-(void)prevPage:(void(^)(Jcondition * condition, BOOL isChange))callback isReload:(BOOL)isReload;

/*下一页,page_index++
 如果page_index = 最后一页, page_index 不变,isChange=NO
 isReload =NO;
 */
-(void)nextPage:(void(^)(Jcondition * condition, BOOL isChange))callback;
-(void)nextPage:(void(^)(Jcondition * condition, BOOL isChange))callback isReload:(BOOL)isReload;
@end
