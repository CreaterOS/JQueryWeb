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
/* 整合HTML所有常用标签 */
@property (nonatomic,strong)NSMutableArray *tagAllArray;
/* show动画操作 */
@property (nonatomic,strong)NSMutableArray *showAnimationArray;
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
        _onAllOptionsArray = [NSMutableArray arrayWithObjects:ALLOPTIONS,nil];
    }
    
    return _onAllOptionsArray;
}

/* 整合HTML所有常用标签 */
- (NSMutableArray *)tagAllArray{
    if(!_tagAllArray){
        _tagAllArray = [NSMutableArray arrayWithObjects:ALLTAG,nil];
    }
    
    return _tagAllArray;
}

/* 整合JQuery动画效果 */
- (NSMutableArray *)showAnimationArray{
    if (!_showAnimationArray) {
        /* animation -- "slow","normal", or "fast" */
        _showAnimationArray = [NSMutableArray arrayWithObjects:@"slow",@"normal",@"fast",nil];
    }
    
    return _showAnimationArray;
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
        /* 此处需要判断标签的有效性 */
        if(![self tagNameValidity:tagName]){
            NSException *ex = [NSException exceptionWithName:@"HTML标签错误" reason:@"JQueryWeb - 核查标签参数" userInfo:nil];
            [ex raise];
        }
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
            NSException *ex = [NSException exceptionWithName:@"无效on操作" reason:@"JQueryWeb - JQuery官方未定义此操作" userInfo:nil];
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
            NSException *ex = [NSException exceptionWithName:@"无效on操作" reason:@"JQueryWeb - JQuery官方未定义此操作" userInfo:nil];
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

#pragma mark - on展开操作
- (NSString * _Nonnull (^)(NSUInteger, NSString * _Nonnull))onBlur{
    JQUERY_BLOCK_WEAK;
    return ^NSString *(NSUInteger index,NSString *function){
        JQUERY_BLOCK_STRONG;
        NSString *functionName = [NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding];
        NSString *optionName = [self functionNameSubOption:functionName];

        return [self saveOnWithIndex:index option:optionName function:function];
    };
}

- (NSString * _Nonnull (^)(NSUInteger, NSString * _Nonnull))onFocus{
    JQUERY_BLOCK_WEAK;
    return ^NSString *(NSUInteger index,NSString *function){
        JQUERY_BLOCK_STRONG;
        NSString *functionName = [NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding];
        NSString *optionName = [self functionNameSubOption:functionName];
        
        return [self saveOnWithIndex:index option:optionName function:function];
    };
}

- (NSString * _Nonnull (^)(NSUInteger, NSString * _Nonnull))onFocusin{
    JQUERY_BLOCK_WEAK;
    return ^NSString *(NSUInteger index,NSString *function){
        JQUERY_BLOCK_STRONG;
        NSString *functionName = [NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding];
        NSString *optionName = [self functionNameSubOption:functionName];
        
        return [self saveOnWithIndex:index option:optionName function:function];
    };
}

- (NSString * _Nonnull (^)(NSUInteger, NSString * _Nonnull))onFocusout{
    JQUERY_BLOCK_WEAK;
    return ^NSString *(NSUInteger index,NSString *function){
        JQUERY_BLOCK_STRONG;
        NSString *functionName = [NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding];
        NSString *optionName = [self functionNameSubOption:functionName];
        
        return [self saveOnWithIndex:index option:optionName function:function];
    };
}

- (NSString * _Nonnull (^)(NSUInteger, NSString * _Nonnull))onLoad{
    JQUERY_BLOCK_WEAK;
    return ^NSString *(NSUInteger index,NSString *function){
        JQUERY_BLOCK_STRONG;
        NSString *functionName = [NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding];
        NSString *optionName = [self functionNameSubOption:functionName];
        
        return [self saveOnWithIndex:index option:optionName function:function];
    };
}

- (NSString * _Nonnull (^)(NSUInteger, NSString * _Nonnull))onResize{
    JQUERY_BLOCK_WEAK;
    return ^NSString *(NSUInteger index,NSString *function){
        JQUERY_BLOCK_STRONG;
        NSString *functionName = [NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding];
        NSString *optionName = [self functionNameSubOption:functionName];
        
        return [self saveOnWithIndex:index option:optionName function:function];
    };
}

- (NSString * _Nonnull (^)(NSUInteger, NSString * _Nonnull))onScroll{
    JQUERY_BLOCK_WEAK;
    return ^NSString *(NSUInteger index,NSString *function){
        JQUERY_BLOCK_STRONG;
        NSString *functionName = [NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding];
        NSString *optionName = [self functionNameSubOption:functionName];
        
        return [self saveOnWithIndex:index option:optionName function:function];
    };
}

- (NSString * _Nonnull (^)(NSUInteger, NSString * _Nonnull))onUnload{
    JQUERY_BLOCK_WEAK;
    return ^NSString *(NSUInteger index,NSString *function){
        JQUERY_BLOCK_STRONG;
        NSString *functionName = [NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding];
        NSString *optionName = [self functionNameSubOption:functionName];
        
        return [self saveOnWithIndex:index option:optionName function:function];
    };
}

- (NSString * _Nonnull (^)(NSUInteger, NSString * _Nonnull))onClick{
    JQUERY_BLOCK_WEAK;
    return ^NSString *(NSUInteger index,NSString *function){
        JQUERY_BLOCK_STRONG;
        NSString *functionName = [NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding];
        NSString *optionName = [self functionNameSubOption:functionName];
        
        return [self saveOnWithIndex:index option:optionName function:function];
    };
}

- (NSString * _Nonnull (^)(NSUInteger, NSString * _Nonnull))onDblclick{
    JQUERY_BLOCK_WEAK;
    return ^NSString *(NSUInteger index,NSString *function){
        JQUERY_BLOCK_STRONG;
        NSString *functionName = [NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding];
        NSString *optionName = [self functionNameSubOption:functionName];
        
        return [self saveOnWithIndex:index option:optionName function:function];
    };
}

- (NSString * _Nonnull (^)(NSUInteger, NSString * _Nonnull))onMousedown{
    JQUERY_BLOCK_WEAK;
    return ^NSString *(NSUInteger index,NSString *function){
        JQUERY_BLOCK_STRONG;
        NSString *functionName = [NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding];
        NSString *optionName = [self functionNameSubOption:functionName];
        
        return [self saveOnWithIndex:index option:optionName function:function];
    };
}

- (NSString * _Nonnull (^)(NSUInteger, NSString * _Nonnull))onMouseup{
    JQUERY_BLOCK_WEAK;
    return ^NSString *(NSUInteger index,NSString *function){
        JQUERY_BLOCK_STRONG;
        NSString *functionName = [NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding];
        NSString *optionName = [self functionNameSubOption:functionName];
        
        return [self saveOnWithIndex:index option:optionName function:function];
    };
}

- (NSString * _Nonnull (^)(NSUInteger, NSString * _Nonnull))onMousemove{
    JQUERY_BLOCK_WEAK;
    return ^NSString *(NSUInteger index,NSString *function){
        JQUERY_BLOCK_STRONG;
        NSString *functionName = [NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding];
        NSString *optionName = [self functionNameSubOption:functionName];
        
        return [self saveOnWithIndex:index option:optionName function:function];
    };
}

- (NSString * _Nonnull (^)(NSUInteger, NSString * _Nonnull))onMouseover{
    JQUERY_BLOCK_WEAK;
    return ^NSString *(NSUInteger index,NSString *function){
        JQUERY_BLOCK_STRONG;
        NSString *functionName = [NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding];
        NSString *optionName = [self functionNameSubOption:functionName];
        
        return [self saveOnWithIndex:index option:optionName function:function];
    };
}

- (NSString * _Nonnull (^)(NSUInteger, NSString * _Nonnull))onMouseout{
    JQUERY_BLOCK_WEAK;
    return ^NSString *(NSUInteger index,NSString *function){
        JQUERY_BLOCK_STRONG;
        NSString *functionName = [NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding];
        NSString *optionName = [self functionNameSubOption:functionName];
        
        return [self saveOnWithIndex:index option:optionName function:function];
    };
}

- (NSString * _Nonnull (^)(NSUInteger, NSString * _Nonnull))onMouseenter{
    JQUERY_BLOCK_WEAK;
    return ^NSString *(NSUInteger index,NSString *function){
        JQUERY_BLOCK_STRONG;
        NSString *functionName = [NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding];
        NSString *optionName = [self functionNameSubOption:functionName];
        
        return [self saveOnWithIndex:index option:optionName function:function];
    };
}

- (NSString * _Nonnull (^)(NSUInteger, NSString * _Nonnull))onMouseleave{
    JQUERY_BLOCK_WEAK;
    return ^NSString *(NSUInteger index,NSString *function){
        JQUERY_BLOCK_STRONG;
        NSString *functionName = [NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding];
        NSString *optionName = [self functionNameSubOption:functionName];
        
        return [self saveOnWithIndex:index option:optionName function:function];
    };
}

- (NSString * _Nonnull (^)(NSUInteger, NSString * _Nonnull))onChange{
    JQUERY_BLOCK_WEAK;
    return ^NSString *(NSUInteger index,NSString *function){
        JQUERY_BLOCK_STRONG;
        NSString *functionName = [NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding];
        NSString *optionName = [self functionNameSubOption:functionName];
        
        return [self saveOnWithIndex:index option:optionName function:function];
    };
}

- (NSString * _Nonnull (^)(NSUInteger, NSString * _Nonnull))onSelect{
    JQUERY_BLOCK_WEAK;
    return ^NSString *(NSUInteger index,NSString *function){
        JQUERY_BLOCK_STRONG;
        NSString *functionName = [NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding];
        NSString *optionName = [self functionNameSubOption:functionName];
        
        return [self saveOnWithIndex:index option:optionName function:function];
    };
}

- (NSString * _Nonnull (^)(NSUInteger, NSString * _Nonnull))onSubmit{
    JQUERY_BLOCK_WEAK;
    return ^NSString *(NSUInteger index,NSString *function){
        JQUERY_BLOCK_STRONG;
        NSString *functionName = [NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding];
        NSString *optionName = [self functionNameSubOption:functionName];
        
        return [self saveOnWithIndex:index option:optionName function:function];
    };
}

- (NSString * _Nonnull (^)(NSUInteger, NSString * _Nonnull))onKeydown{
    JQUERY_BLOCK_WEAK;
    return ^NSString *(NSUInteger index,NSString *function){
        JQUERY_BLOCK_STRONG;
        NSString *functionName = [NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding];
        NSString *optionName = [self functionNameSubOption:functionName];
        
        return [self saveOnWithIndex:index option:optionName function:function];
    };
}

- (NSString * _Nonnull (^)(NSUInteger, NSString * _Nonnull))onKeypress{
    JQUERY_BLOCK_WEAK;
    return ^NSString *(NSUInteger index,NSString *function){
        JQUERY_BLOCK_STRONG;
        NSString *functionName = [NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding];
        NSString *optionName = [self functionNameSubOption:functionName];
        
        return [self saveOnWithIndex:index option:optionName function:function];
    };
}

- (NSString * _Nonnull (^)(NSUInteger, NSString * _Nonnull))onKeyup{
    JQUERY_BLOCK_WEAK;
    return ^NSString *(NSUInteger index,NSString *function){
        JQUERY_BLOCK_STRONG;
        NSString *functionName = [NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding];
        NSString *optionName = [self functionNameSubOption:functionName];
        
        return [self saveOnWithIndex:index option:optionName function:function];
    };
}

- (NSString * _Nonnull (^)(NSUInteger, NSString * _Nonnull))onError{
    JQUERY_BLOCK_WEAK;
    return ^NSString *(NSUInteger index,NSString *function){
        JQUERY_BLOCK_STRONG;
        NSString *functionName = [NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding];
        NSString *optionName = [self functionNameSubOption:functionName];
        
        return [self saveOnWithIndex:index option:optionName function:function];
    };
}

- (NSString * _Nonnull (^)(NSUInteger, NSString * _Nonnull))onContextmenu{
    JQUERY_BLOCK_WEAK;
    return ^NSString *(NSUInteger index,NSString *function){
        JQUERY_BLOCK_STRONG;
        NSString *functionName = [NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding];
        NSString *optionName = [self functionNameSubOption:functionName];
        
        return [self saveOnWithIndex:index option:optionName function:function];
    };
}

#pragma mark - 函数名
- (NSString *)functionNameSubOption:(NSString *__nonnull)functionName{
    NSUInteger startIndex = [functionName rangeOfString:@"on"].location +2;
    NSUInteger endIndex = [functionName rangeOfString:@"]"].location - startIndex;
    return [functionName substringWithRange:NSMakeRange(startIndex, endIndex)];
}


#pragma mark - css操作
- (NSMutableArray * _Nonnull (^)(NSString * _Nonnull))css{
    JQUERY_BLOCK_WEAK;
    return ^NSMutableArray *(NSString *properties){
        JQUERY_BLOCK_STRONG;
        
        NSString *cssStr = [self saveCSSWithProperties:properties];
        NSMutableArray *resArr = [NSMutableArray array];
        
        for (NSString *resStr in [cssStr componentsSeparatedByString:@"|"]) {
            [resArr addObject:resStr];
        }
        
        return resArr;
    };
}

- (NSMutableArray * _Nonnull (^)(NSUInteger, NSString * _Nonnull))cssWithIndex{
    JQUERY_BLOCK_WEAK;
    return ^NSMutableArray *(NSUInteger index,NSString *properties){
        JQUERY_BLOCK_STRONG;
        
        NSString *cssStr = [self saveCSSWithIndex:index properties:properties];
        NSMutableArray *resArr = [NSMutableArray array];
        
        for (NSString *resStr in [cssStr componentsSeparatedByString:@"|"]) {
            [resArr addObject:resStr];
        }
        
        return resArr;
    };
}

#pragma mark - 基本css操作
- (NSString * _Nonnull (^)(NSString * _Nonnull, NSString * _Nonnull))cssSet{
    return ^NSString *(NSString *key,NSString *value){
        /* 封装成为properties格式 */
        NSString *properties = [NSString stringWithFormat:@"%@:%@",key,value];
        NSString *resStr = [self saveCSSWithProperties:properties];
        
        return [resStr substringWithRange:NSMakeRange(0, resStr.length-1)];
    };
}

- (NSString * _Nonnull (^)(NSUInteger, NSString * _Nonnull, NSString * _Nonnull))cssSetWithIndex{
    return ^NSString *(NSUInteger index,NSString *key,NSString *value){
        /* 封装成为properties格式 */
        NSString *properties = [NSString stringWithFormat:@"%@:%@",key,value];
        NSString *resStr = [self saveCSSWithIndex:index properties:properties];
        
        return [resStr substringWithRange:NSMakeRange(0, resStr.length-1)];
    };

}

#pragma mark - 保存css操作
- (NSString *)saveCSSWithProperties:(NSString *)properties{
    /* 解析操作 */
    NSCParameterAssert(properties != NULL);
    
    NSMutableDictionary *proDict = [NSMutableDictionary dictionary];
    /* 字符串转字典操作 */
    @synchronized (self) {
        /* 判断语法有效性 */
        properties = [self cssPropertiesValidity:properties];
        NSArray *proArr = [properties componentsSeparatedByString:@","];
        for (NSString *str in proArr) {
            /* 取出key和value */
            NSArray *keyAndValue = [str componentsSeparatedByString:@":"];
            [proDict setValue:keyAndValue[1] forKey:keyAndValue[0]];
        }
    }
    /* 保存到Tag字典中去 */
    JQueryWebTagMaker *tagM = [JQueryWebTagMaker TagMakerName:_tagName properties:proDict];
    return [tagM parseTextTagNameWithSelect:JQueryWebMakerCSS];
}

- (NSString *)saveCSSWithIndex:(NSUInteger) index properties:(NSString *)properties{
    /* 解析操作 */
    NSCParameterAssert(properties != NULL);
    
    NSMutableDictionary *proDict = [NSMutableDictionary dictionary];
    /* 字符串转字典操作 */
    @synchronized (self) {
        /* 判断语法有效性 */
        properties = [self cssPropertiesValidity:properties];
        NSArray *proArr = [properties componentsSeparatedByString:@","];
        for (NSString *str in proArr) {
            /* 取出key和value */
            NSArray *keyAndValue = [str componentsSeparatedByString:@":"];
            [proDict setValue:keyAndValue[1] forKey:keyAndValue[0]];
        }
    }
    /* 保存到Tag字典中去 */
    JQueryWebTagMaker *tagM = [JQueryWebTagMaker TagMakerName:_tagName properties:proDict];
    return [tagM parseTextTagNameWithSelect:JQueryWebMakerCSS index:index];
}

#pragma mark - show操作
- (NSString * _Nonnull (^)(void))show{
    JQUERY_BLOCK_WEAK;
    return ^NSString *(void){
        JQUERY_BLOCK_STRONG;
        return [self saveShow];
    };
}

- (NSString * _Nonnull (^)(NSUInteger))showWithIndex{
    JQUERY_BLOCK_WEAK;
    return ^NSString *(NSUInteger index){
        JQUERY_BLOCK_STRONG;
        return [self saveShowWithIndex:index];
    };
}

#pragma mark - 保存hidden操作
- (NSString *)saveHidden{
    JQueryWebTagMaker *tag = [JQueryWebTagMaker TagMakerName:_tagName];
    return [tag parseTextTagNameWithSelect:JQueryWebMakerHidden];
}

- (NSString *)saveHiddenWithIndex:(NSUInteger)index{
    JQueryWebTagMaker *tag = [JQueryWebTagMaker TagMakerName:_tagName];
    return [tag parseTextTagNameWithSelect:JQueryWebMakerHidden index:index];
}

#pragma mark - 保存show操作
- (NSString *)saveShow{
    JQueryWebTagMaker *tag = [JQueryWebTagMaker TagMakerName:_tagName];
    return [tag parseTextTagNameWithSelect:JQueryWebMakerShow];
}

- (NSString *)saveShowWithIndex:(NSUInteger)index{
    JQueryWebTagMaker *tag = [JQueryWebTagMaker TagMakerName:_tagName];
    return [tag parseTextTagNameWithSelect:JQueryWebMakerShow index:index];
}

- (NSString * _Nonnull (^)(NSString * _Nonnull, NSString * _Nonnull))showSet{
    JQUERY_BLOCK_WEAK;
    return ^NSString *(NSString *option,NSString *function){
        JQUERY_BLOCK_STRONG;
        return [self saveShowWithOption:option function:function];
    };
}

- (NSString * _Nonnull (^)(NSUInteger, NSString * _Nonnull, NSString * _Nonnull))showSetWithIndex{
    JQUERY_BLOCK_WEAK;
    return ^NSString *(NSUInteger index,NSString *option,NSString *function){
        JQUERY_BLOCK_STRONG;
        return [self saveShowWithIndex:index option:option function:function];
    };
}

#pragma mark - 保存show带参数和函数
- (NSString * __nonnull)saveShowWithOption:(NSString * __nonnull)option function:(NSString * __nonnull)function{
    NSCParameterAssert(option != NULL);
    NSCParameterAssert(function != NULL);
    
    @synchronized (self) {
        
        if(![self showAnimationValidity:option]){
            /* 抛出自定义异常 */
            NSException *ex = [NSException exceptionWithName:@"无效动画操作" reason:@"JQueryWeb - JQuery官方未定义此操作" userInfo:nil];
            [ex raise];
        }
        
        _option = option;
        _function = function;
        
        return [self parseTagName:_tagName options:^NSString *{
            JQueryWebTagMaker *tagMaker = [JQueryWebTagMaker TagMakerName:self.tagName option:self.option function:self.function];
            return [tagMaker parseTextTagNameWithSelect:JQueryWebMakerShowWithFunction];
        }];
    }
    
    return [NSString string];
}


- (NSString * __nonnull)saveShowWithIndex:(NSUInteger)index option:(NSString * __nonnull)option function:(NSString * __nonnull)function{
    NSCParameterAssert(option != NULL);
    NSCParameterAssert(function != NULL);
    
    
    @synchronized (self) {
        if(![self showAnimationValidity:option]){
            /* 抛出自定义异常 */
            NSException *ex = [NSException exceptionWithName:@"无效动画效果操作" reason:@"JQueryWeb - JQuery官方未定义此操作" userInfo:nil];
            [ex raise];
        }
        
        _option = option;
        _function = function;
        
        return [self parseTagName:_tagName options:^NSString *{
            JQueryWebTagMaker *tagMaker = [JQueryWebTagMaker TagMakerName:self.tagName option:self.option function:self.function];
            return [tagMaker parseTextTagNameWithSelect:JQueryWebMakerShowWithFunction index:index];
        }];
    }
    
    return [NSString string];
}

- (NSString * _Nonnull (^)(NSString * _Nonnull))showAnimation{
    JQUERY_BLOCK_WEAK;
    return ^NSString *(NSString *context) {
        JQUERY_BLOCK_STRONG;
        if(![self showAnimationValidity:context]){
            /* 抛出自定义异常 */
            NSException *ex = [NSException exceptionWithName:@"无效动画效果操作" reason:@"JQueryWeb - JQuery官方未定义此操作" userInfo:nil];
            [ex raise];
        }

        return [self saveText:context select:JQueryWebMakerShowAnimation];
    };
}

- (NSString * _Nonnull (^)(NSUInteger,NSString * _Nonnull))showAnimationWithIndex{
    JQUERY_BLOCK_WEAK;
    return ^NSString *(NSUInteger index,NSString *context){
        JQUERY_BLOCK_STRONG;
        
        if(![self showAnimationValidity:context]){
            /* 抛出自定义异常 */
            NSException *ex = [NSException exceptionWithName:@"无效动画效果操作" reason:@"JQueryWeb - JQuery官方未定义此操作" userInfo:nil];
            [ex raise];
        }

        return [self saveText:context index:index select:JQueryWebMakerShowAnimation];
    };
}

#pragma mark - hidden操作
- (NSString * _Nonnull (^)(void))hidden{
    JQUERY_BLOCK_WEAK;
    return ^NSString *(void){
        JQUERY_BLOCK_STRONG;
        return [self saveHidden];
    };
}

- (NSString * _Nonnull (^)(NSUInteger))hiddenWithIndex{
    JQUERY_BLOCK_WEAK;
    return ^NSString *(NSUInteger index){
        JQUERY_BLOCK_STRONG;
        return [self saveHiddenWithIndex:index];
    };
}

#pragma mark - height操作
- (NSString * _Nonnull (^)(NSUInteger))height{
    JQUERY_BLOCK_WEAK;
    return ^NSString *(NSUInteger heightPX){
        JQUERY_BLOCK_STRONG;
        return [self saveHeight:heightPX width:-1];
    };
}

- (NSString * _Nonnull (^)(NSUInteger, NSUInteger))heightWithCount{
    JQUERY_BLOCK_WEAK;
    return ^NSString *(NSUInteger index,NSUInteger heightPX){
        JQUERY_BLOCK_STRONG;
        return [self saveHeight:heightPX width:-1 index:index];
    };
}

- (NSString * _Nonnull (^)(NSUInteger))width{
    JQUERY_BLOCK_WEAK;
    return ^NSString *(NSUInteger widthPX){
        JQUERY_BLOCK_STRONG;
        return [self saveHeight:widthPX width:-1];
    };
}

- (NSString * _Nonnull (^)(NSUInteger, NSUInteger))widthWithCount{
    JQUERY_BLOCK_WEAK;
    return ^NSString *(NSUInteger index,NSUInteger widthPX){
        JQUERY_BLOCK_STRONG;
        return [self saveHeight:widthPX width:-1 index:index];
    };
}

#pragma mark - 保存height操作和weight操作
- (NSString *)saveHeight:(NSUInteger)height width:(NSUInteger)width{

    if (height == -1 && width != -1) {
        /* 保存宽度 */
        JQueryWebTagMaker *tag = [JQueryWebTagMaker TagMakerName:_tagName width:width];
        return [tag parseTextTagNameWithSelect:JQueryWebMakerWidth];
    }else if(height != -1 && width == -1){
        /* 保存高度 */
        JQueryWebTagMaker *tag = [JQueryWebTagMaker TagMakerName:_tagName height:height];
       return [tag parseTextTagNameWithSelect:JQueryWebMakerHeight];
    }
    
    return [NSString string];
}

- (NSString *)saveHeight:(NSUInteger)height width:(NSUInteger)width index:(NSUInteger)index{
    
    if (height == -1 && width != -1) {
        /* 保存宽度 */
        JQueryWebTagMaker *tag = [JQueryWebTagMaker TagMakerName:_tagName width:width];
        return [tag parseTextTagNameWithSelect:JQueryWebMakerWidth index:index];
    }else if(height != -1 && width == -1){
        /* 保存高度 */
        JQueryWebTagMaker *tag = [JQueryWebTagMaker TagMakerName:_tagName height:height];
        return [tag parseTextTagNameWithSelect:JQueryWebMakerHeight index:index];
    }
    
    return [NSString string];
}

#pragma mark - trim操作
- (NSString * _Nonnull (^)(NSUInteger, NSString * _Nonnull))trim{
    JQUERY_BLOCK_WEAK;
    return ^NSString *(NSUInteger index,NSString *text){
        JQUERY_BLOCK_STRONG;
        return [self removeSpace:text index:index];
    };
}

#pragma mark - 处理空格
- (NSString *)removeSpace:(NSString *)trimText index:(NSUInteger)index{
    
    /* 去除空格 */
    trimText = [trimText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    return [self saveText:trimText index:index select:JQueryWebMakerTextORVal];
}

#pragma mark - 有效性
#pragma mark - 判断语法有效性
- (NSString *)cssPropertiesValidity:(NSString *__nonnull)properties{
    NSCParameterAssert(properties != NULL);
    
    /* 判断是否含有{} */
    if ([properties containsString:@"{"] && [properties containsString:@"}"]){
        properties = [properties substringWithRange:NSMakeRange(1, properties.length-2)];
    }else if (([properties containsString:@"{"] && ![properties containsString:@"}"]) || (![properties containsString:@"{"] && [properties containsString:@"}"])){
        /* 语法上有错误 */
        /* 发出警告，但是不崩溃程序 */
        NSLog(@"输入中括号个数不匹配请及时修改！！！");
        if ([properties containsString:@"{"]) {
            properties = [properties substringWithRange:NSMakeRange(1, properties.length-1)];
        }else{
            properties = [properties substringWithRange:NSMakeRange(0, properties.length-1)];
        }
    }
    
    return properties;
}

#pragma mark - 判断show操作有效性
- (Boolean)showAnimationValidity:(NSString *)animation{
    /* 判断动画类型 */
    for (NSString *str in self.showAnimationArray) {
        if ([animation isEqualToString:str]) {
            return TRUE;
        }
    }
    
    return FALSE;
}

#pragma mark - 判断on操作有效性
- (Boolean)onOptionsValidity:(NSString *)option{
    NSCParameterAssert(option != NULL);
    /* 所有转换为小写 */
    
    /* 遍历数组判断是否包含 */
    for (NSString *str in self.onAllOptionsArray) {
        if ([str isEqualToString:[option lowercaseString]]) {
            return TRUE;
        }
    }
    
    return FALSE;
}

#pragma mark - tag有效性
- (Boolean)tagNameValidity:(NSString *)tagName{
    NSCParameterAssert(tagName != NULL);
    
    /* 遍历数组判断是否包含 */
    for (NSString *str in self.tagAllArray) {
        if ([str isEqualToString:[tagName lowercaseString]]) {
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
