//
//  JQueryWebMaker.m
//  JQueryWeb
//
//  Created by Bryant Reyn on 2020/4/15.
//  Copyright © 2020 Bryant Reyn. All rights reserved.
//

#import "JQueryWebMaker.h"
#import "JQueryWebTagMaker.h"
#import "JQueryWebMacroJavaScript.h"

@interface JQueryWebMaker()
@property (nonatomic,weak)NSString *tagName; /* 标签名称 */
@property (nonatomic,weak)NSString *context; /* 文本内容 */
@property (nonatomic,assign)NSUInteger index; /* 下标 */
@property (nonatomic,weak)NSString *option; /* on操作 */
@property (nonatomic,weak)NSString *function; /* 函数封装 */
@property (nonatomic,strong)NSMutableArray *resOnStrArray; /* 存储多个操作 */

/* 整合JQuery on支持的所有操作 */
@property (nonatomic,strong)NSMutableArray *onAllOptionsArray;
@end


@implementation JQueryWebMaker

#pragma mark - 懒加载
- (NSMutableArray *)resOnStrArray{
    if (!_resOnStrArray) {
        _resOnStrArray = [NSMutableArray array];
    }
    
    return _resOnStrArray;
}

/* 整合JQuery on操作数组 */
- (NSMutableArray *)onAllOptionsArray{
    if (!_onAllOptionsArray) {
        _onAllOptionsArray = [NSMutableArray arrayWithObjects:JQUERY_JS_BLUR,JQUERY_JS_FOCUS,JQUERY_JS_FOCUSION,JQUERY_JS_FOCUSOUT,JQUERY_JS_LOAD,JQUERY_JS_RESIZE,JQUERY_JS_SCROLL,JQUERY_JS_UNLOAD,JQUERY_JS_CLICK,JQUERY_JS_DBLCLICK,JQUERY_JS_MOUSEDOWN,JQUERY_JS_MOUSEUP,JQUERY_JS_MOUSEMOVE,JQUERY_JS_MOUSEOVER,JQUERY_JS_MOUSEOUT,JQUERY_JS_MOUSEENTER,JQUERY_JS_MOUSELEAVE,JQUERY_JS_CHANGE,JQUERY_JS_SELECT,JQUERY_JS_SUBMIT,JQUERY_JS_KEYDOWN,JQUERY_JS_KEYPRESS,JQUERY_JS_KEYUP,JQUERY_JS_ERROR,JQUERY_JS_CONTEXTMENU,nil];
    }
    
    return _onAllOptionsArray;
}

+ (JQueryWebMaker * _Nonnull (^)(NSString * _Nonnull))JQuery{
    JQUERY_BLOCK_WEAK;
    return ^JQueryWebMaker*(NSString *tagName){
        JQUERY_BLOCK_STRONG;
        return [[self alloc] initWithTagName:tagName];
    };
}

- (instancetype)initWithTagName:(NSString *)tagName{
    NSCParameterAssert(tagName != NULL);
    self = [super init];
    if (self) {
        _tagName = tagName;
    }
    return self;
}

#pragma mark - 文本操作
- (NSString * _Nonnull (^)(NSString * _Nonnull))text{
    JQUERY_BLOCK_WEAK;
    return ^NSString *(NSString *context) {
        JQUERY_BLOCK_STRONG;
        return [self saveText:context select:JQueryWebMakerTextORVal];
    };
}

- (NSString * _Nonnull (^)(NSUInteger,NSString * _Nonnull))textWithIndex{
    JQUERY_BLOCK_WEAK;
    return ^NSString *(NSUInteger index,NSString *context){
        JQUERY_BLOCK_STRONG;
        return [self saveText:context index:index select:JQueryWebMakerTextORVal];
    };
}

- (NSString * _Nonnull (^)(NSString *_Nonnull))html{
    JQUERY_BLOCK_WEAK;
    return ^NSString *(NSString *context) {
        JQUERY_BLOCK_STRONG;
        return [self saveText:context select:JQueryWebMakerHTML];
    };
}

- (NSString * _Nonnull (^)(NSUInteger, NSString * _Nonnull))htmlWithIndex{
    JQUERY_BLOCK_WEAK;
    return ^NSString *(NSUInteger index,NSString *context){
        JQUERY_BLOCK_STRONG;
        return [self saveText:context index:index select:JQueryWebMakerHTML];
    };
}

- (NSString * _Nonnull (^)(NSString *_Nonnull))val{
    JQUERY_BLOCK_WEAK;
    return ^NSString *(NSString *context) {
        JQUERY_BLOCK_STRONG;
        return self.text(context);
    };
}

- (NSString * _Nonnull (^)(NSUInteger, NSString * _Nonnull))valWithIndex{
    JQUERY_BLOCK_WEAK;
    return ^NSString *(NSUInteger index,NSString *context){
        JQUERY_BLOCK_STRONG;
        return self.textWithIndex(index,context);
    };
}

#pragma mark - 保存文本信息
- (NSString *__nonnull)saveText:(NSString *)context select:(JQueryWebMakerStyle)select{
    NSCParameterAssert(context != NULL);
    
    @synchronized (self) {
        _context = context;
        /* 根据tagName进行选择对应的解析方法 */
        return [self parseTagName:_tagName options:^NSString *{
            
                JQueryWebTagMaker *tagMaker = [JQueryWebTagMaker TagMakerName:self.tagName context:self.context];
                return [tagMaker parseTextTagNameWithSelect:select];
            
        }];
    }
}

- (NSString *__nonnull)saveText:(NSString *)context index:(NSUInteger)index select:(JQueryWebMakerStyle)select{
    NSCParameterAssert(context != NULL);
    
    @synchronized (self) {
        _context = context;
        _index = index;
        /* 根据tagName进行选择对应的解析方法 */
        return [self parseTagName:_tagName options:^NSString *{
            
            JQueryWebTagMaker *tagMaker = [JQueryWebTagMaker TagMakerName:self.tagName context:self.context];
            return [tagMaker parseTextTagNameWithSelect:select index:index];
        }];
    }
}

#pragma mark - ON操作
- (NSString * _Nonnull (^)(NSString * _Nonnull, NSString * _Nonnull))on{
    JQUERY_BLOCK_WEAK;
    return ^NSString *(NSString *option,NSString *function){
        JQUERY_BLOCK_STRONG;
        return [self saveOnWithOption:option function:function];
    };
}

- (NSString * _Nonnull (^)(NSUInteger, NSString * _Nonnull, NSString * _Nonnull))onWithIndex{
    JQUERY_BLOCK_WEAK;
    return ^NSString *(NSUInteger index,NSString *option,NSString *function){
        JQUERY_BLOCK_STRONG;
        return [self saveOnWithIndex:index option:option function:function];
    };
}

#pragma mark - ON参数操组(多个操作)
- (NSMutableArray * _Nonnull (^)(NSString * _Nonnull , ...))onMoreOptions{
    JQUERY_BLOCK_WEAK;
    return ^NSMutableArray *(NSString *function,...){
        JQUERY_BLOCK_STRONG;
        /* 获取可变参数 */
        NSString *options = [NSString string];
        va_list arg_list;
        
        va_start(arg_list, function);
        
        while ((options = va_arg(arg_list, NSString *))) {
            /* 处理后加入数组 */
            NSString *resStr = [self saveOnWithOption:options function:function];
            [self.resOnStrArray addObject:resStr];
        }
        va_end(arg_list);
        
        NSMutableArray *tempArray = [NSMutableArray array];
        @synchronized (self) {
            tempArray = [self.resOnStrArray copy];
            /* 清空强引用数组 */
            [self.resOnStrArray removeAllObjects];
        }
        
        
        return tempArray;
    };
}


- (NSMutableArray * _Nonnull (^)(NSUInteger, NSString * _Nonnull, ...))onMoreOptionsWithIndex{
    JQUERY_BLOCK_WEAK;
    return ^NSMutableArray *(NSUInteger index,NSString *function,...){
        JQUERY_BLOCK_STRONG;
        /* 获取可变参数 */
        NSString *options = [NSString string];
        va_list arg_list;
        
        va_start(arg_list, function);
        
        while ((options = va_arg(arg_list, NSString *))) {
            /* 处理后加入数组 */
            NSString *resStr = [self saveOnWithIndex:index option:options function:function];
            [self.resOnStrArray addObject:resStr];
        }
        va_end(arg_list);
        
        NSMutableArray *tempArray = [NSMutableArray array];
        @synchronized (self) {
            tempArray = [self.resOnStrArray copy];
            /* 清空强引用数组 */
            [self.resOnStrArray removeAllObjects];
        }
        
        
        return tempArray;
    };
}

#pragma mark - ON参数操组(多个不同事件)
- (NSMutableArray * _Nonnull (^)(NSUInteger, ...))onMoreEventWithIndex{
    JQUERY_BLOCK_WEAK;
    return ^NSMutableArray *(NSUInteger index,...){
        JQUERY_BLOCK_STRONG;
        
        NSString *eventStr = [NSString string];
        
        va_list arg_list;
        va_start(arg_list,index);
        
        
        while ((eventStr = va_arg(arg_list, NSString *))) {
            /* 保存到数组中 */
            /* 取出参数的两部分 options 和 function */
            NSString *newOption = [eventStr componentsSeparatedByString:@":"][0];
            NSString *newFunction = [eventStr componentsSeparatedByString:@":"][1];
            NSLog(@"%@ -- %@",newOption,newFunction);
            NSString *resStr = [self saveOnWithIndex:index option:newOption function:newFunction];
            [self.resOnStrArray addObject:resStr];
        }
        va_end(arg_list);
        
        NSMutableArray *tempArray = [NSMutableArray array];
        @synchronized (self) {
            tempArray = [self.resOnStrArray copy];
            /* 清空强引用数组 */
            [self.resOnStrArray removeAllObjects];
        }
        
        return self.resOnStrArray;
    };
}


#pragma mark - 保存on操作信息
- (NSString * __nonnull)saveOnWithOption:(NSString * __nonnull)option function:(NSString * __nonnull)function{
    NSCParameterAssert(option != NULL);
    NSCParameterAssert(function != NULL);
    
    @synchronized (self) {
        
        if(![self onOptionsValidity:option]){
            /* 抛出自定义异常 */
            NSException *ex = [NSException exceptionWithName:@"无效on操作" reason:@"JQuery官方未定义此操作" userInfo:nil];
            [ex raise];
        }
        
        _option = option;
        _function = function;
        
        return [self parseTagName:_tagName options:^NSString *{
            JQueryWebTagMaker *tagMaker = [JQueryWebTagMaker TagMakerName:self.tagName option:self.option function:self.function];
            return [tagMaker parseTextTagNameWithSelect:JQueryWebMakerON];
        }];
    }
    
    return [NSString string];
}


- (NSString * __nonnull)saveOnWithIndex:(NSUInteger)index option:(NSString * __nonnull)option function:(NSString * __nonnull)function{
    NSCParameterAssert(option != NULL);
    NSCParameterAssert(function != NULL);
    
    
    @synchronized (self) {
        if(![self onOptionsValidity:option]){
            /* 抛出自定义异常 */
            NSException *ex = [NSException exceptionWithName:@"无效on操作" reason:@"JQuery官方未定义此操作" userInfo:nil];
            [ex raise];
        }
        
        _option = option;
        _function = function;
        
        return [self parseTagName:_tagName options:^NSString *{
            JQueryWebTagMaker *tagMaker = [JQueryWebTagMaker TagMakerName:self.tagName option:self.option function:self.function];
            return [tagMaker parseTextTagNameWithSelect:JQueryWebMakerON index:index];
        }];
    }
    
    return [NSString string];
}

#pragma mark - 判断on操作有效性
- (Boolean)onOptionsValidity:(NSString *)option{
    NSCParameterAssert(option != NULL);
    
    /* 遍历数组判断是否包含 */
    for (NSString *str in self.onAllOptionsArray) {
        if ([str isEqualToString:option]) {
            return TRUE;
        }
    }
    
    return FALSE;
}

#pragma mark - 解析标签
- (NSString *__nonnull)parseTagName:(NSString *)tagName options:(NSString *(^)(void))option{
    NSCParameterAssert(tagName != NULL);
    
    return option();
}

@end
