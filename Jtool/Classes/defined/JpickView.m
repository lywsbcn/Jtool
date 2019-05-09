//
//  JHPickView.m
//  Analog
//
//  Created by Apple on 2017/7/14.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import "JpickView.h"

@interface JpickView ()<UIPickerViewDataSource,UIPickerViewDelegate>
{
    UIPickerView * _pick;


}
@end

@implementation JpickView


-(instancetype)init{
    if (self =[super init]){
        [self initialization];
    }
    return self;
}
-(void)awakeFromNib{
    [super awakeFromNib];
    [self initialization];
}
-(void)initialization{
    CGRect frame=CGRectZero;
    frame.origin = CGPointZero;
    frame.size = (CGSize){[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height * 0.4 - 20};
    self.frame =frame;
//    self.backgroundColor =[UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    
    UIToolbar *toolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0.1, self.bounds.size.width, 44)];
    UIBarButtonItem *flexibleSpaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:self action:@selector(doneItemDidClicked:)];
    toolBar.items = @[flexibleSpaceItem, doneItem];
    [self addSubview:toolBar];
    
    _pick=[[UIPickerView alloc]initWithFrame:CGRectMake(0, 44, frame.size.width, frame.size.height-44)];
    [self addSubview:_pick];
//    _pick.backgroundColor =[UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    
    _pick.dataSource = self;
    _pick.delegate = self;
    
    
}

-(void)doneItemDidClicked:(UIBarButtonItem*)sender{
    NSInteger row = [_pick selectedRowInComponent:0];
    if(row >-1){
        self.textField.text = self.data[row].value;
        self.textField.tag = self.data[row].key;
        
        if([self.delegate respondsToSelector:@selector(pickViewDidSelected:row:)]){
            [self.delegate pickViewDidSelected:_pick row:row];
        }
    }
    
    [self.textField endEditing:YES];
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return _data.count;
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return _data[row].value;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
  
    self.textField.text = self.data[row].value;
    self.textField.tag = self.data[row].key;
    if([self.delegate respondsToSelector:@selector(pickViewDidSelected:row:)]){
        [self.delegate pickViewDidSelected:pickerView row:row];
    }
    
    
}

-(NSInteger)selectRow{
    return [_pick selectedRowInComponent:0];
}

-(void)setSelectRow:(NSInteger)selectRow{
    if(selectRow >= self.data.count) return;
    if(selectRow==0){
        [self pickerView:_pick didSelectRow:0 inComponent:0];
    }else{
        [_pick selectRow:selectRow inComponent:0 animated:YES];
    }
   
}

-(void)reload{
    [_pick reloadAllComponents];
}
@end
