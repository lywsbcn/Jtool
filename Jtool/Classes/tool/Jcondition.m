//
//  JHCondition.m
//  happiness
//
//  Created by jh on 2018/5/11.
//  Copyright © 2018年 jh. All rights reserved.
//

#import "Jcondition.h"
#define sIndex 0

@implementation Jcondition

+(Jcondition *)create{
    return [[Jcondition alloc]init];
}

+(Jcondition *)createWithPageSize:(NSInteger)pageSize{
    Jcondition *condition = [self create];
    condition.page_size = pageSize;
    return condition;
}

-(instancetype)init{
    if(self = [super init]){
        self.noMoreData = YES;
    }
    return self;
}


-(void)countWithDictionary:(NSDictionary *)dictionary{
    [self countWithPageIndex:[[dictionary objectForKey:@"page_index"] integerValue]
                    pageSize:[[dictionary objectForKey:@"page_size"] integerValue]
                    numTotal:[[dictionary objectForKey:@"num_total"] integerValue]];
}

-(void)countWithPageIndex:(NSInteger)pageIndex andTotal:(NSInteger)numTotal{
    [self countWithPageIndex:pageIndex pageSize:_page_size numTotal:numTotal];
}

-(void)countWithPageIndex:(NSInteger)pageIndex pageSize:(NSInteger)pageSize numTotal:(NSInteger)numTotal{
    self.page_index = pageIndex<sIndex ? sIndex: pageIndex;
    self.page_size= pageSize;
    self.num_total = numTotal;
    self.total_page = ceil(numTotal*1.0/pageSize);
    
    if(self.total_page-1 ==self.page_index){
        self.noMoreData = YES;
    }else{
        self.noMoreData=NO;
    }    
}

-(void)countWithPageIndex:(NSNumber *)pageIndex andPageSize:(NSNumber *)pageSize andNumTotal:(NSNumber *)numTotal{
    [self countWithPageIndex:[pageIndex integerValue] pageSize:[pageSize integerValue] numTotal:[numTotal integerValue]];
}

+(NSInteger)currentPage:(NSDictionary *)condition{
    NSInteger num_total = [[condition objectForKey:@"num_total"] floatValue];
    NSInteger page_index =[[condition objectForKey:@"page_index"] integerValue];
    NSInteger page_size=[[condition objectForKey:@"page_size"] integerValue];
    
    NSInteger totalPage= ceil(num_total / page_size);
    
    if (totalPage < page_index) return  totalPage ==0 ? 0 : totalPage - 1;
    return  page_index;
    
}



/*重置 page_index 为初始值, 重置数据 YES*/
-(void)reloadData{
    self.page_index = sIndex;
    self.isReload = YES;
}

/*上一页*/
-(void)prevPage:(void (^)(Jcondition *, BOOL))callback{
    [self prevPage:callback isReload:YES];
}

/*
 上一页, page_index-- 并且回调,
 如果 page_index <=初始值, page_index 不减,回调不执行
 */
-(void)prevPage:(void (^)(Jcondition *, BOOL))callback isReload:(BOOL)isReload{
    _isReload = isReload;
    
    if(self.page_index <= sIndex){
        if(callback){
            callback(self,NO);
        }
        return;
    }
    self.page_index --;
    if(callback){
        callback(self,YES);
    }
}



/*下一页*/
-(void)nextPage:(void (^)(Jcondition *, BOOL))callback{
    [self nextPage:callback isReload:NO];
}
/*
 上一页, page_index++ 并且回调,
 如果 page_index >= 最后一页, page_index 不加,回调不执行
 */
-(void)nextPage:(void (^)(Jcondition *, BOOL))callback isReload:(BOOL)isReload{
    _isReload = isReload;
    
    if(self.total_page <= self.page_index +1){
        if(callback){
            callback(self,NO);
        }
        return;
    }
    
    self.page_index ++;
    
    if(callback){
        callback(self,YES);
    }
}



-(void)dealloc{
}

@end
