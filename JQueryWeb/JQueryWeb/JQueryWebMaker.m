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
    return ^NSString *(NSUInteger index,NSString *function){
        NSString *functionName = [NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding];
        NSString *optionName = [self functionNameSubOption:functionName];

        return [self saveOnWithIndex:index option:optionName function:function];
    };
}

- (NSString * _Nonnull (^)(NSUInteger, NSString * _Nonnull))onFocus{
    return ^NSString *(NSUInteger index,NSString *function){
        NSString *functionName = [NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding];
        NSString *optionName = [self functionNameSubOption:functionName];
        
        return [self saveOnWithIndex:index option:optionName function:function];
    };
}

- (NSString * _Nonnull (^)(NSUInteger, NSString * _Nonnull))onFocusin{
    return ^NSString *(NSUInteger index,NSString *function){
        NSString *functionName = [NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding];
        NSString *optionName = [self functionNameSubOption:functionName];
        
        return [self saveOnWithIndex:index option:optionName function:function];
    };
}

- (NSString * _Nonnull (^)(NSUInteger, NSString * _Nonnull))onFocusout{
    return ^NSString *(NSUInteger index,NSString *function){
        NSString *functionName = [NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding];
        NSString *optionName = [self functionNameSubOption:functionName];
        
        return [self saveOnWithIndex:index option:optionName function:function];
    };
}

- (NSString * _Nonnull (^)(NSUInteger, NSString * _Nonnull))onLoad{
    return ^NSString *(NSUInteger index,NSString *function){
        NSString *functionName = [NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding];
        NSString *optionName = [self functionNameSubOption:functionName];
        
        return [self saveOnWithIndex:index option:optionName function:function];
    };
}

- (NSString * _Nonnull (^)(NSUInteger, NSString * _Nonnull))onResize{
    return ^NSString *(NSUInteger index,NSString *function){
        NSString *functionName = [NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding];
        NSString *optionName = [self functionNameSubOption:functionName];
        
        return [self saveOnWithIndex:index option:optionName function:function];
    };
}

- (NSString * _Nonnull (^)(NSUInteger, NSString * _Nonnull))onScroll{
    return ^NSString *(NSUInteger index,NSString *function){
        NSString *functionName = [NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding];
        NSString *optionName = [self functionNameSubOption:functionName];
        
        return [self saveOnWithIndex:index option:optionName function:function];
    };
}

- (NSString * _Nonnull (^)(NSUInteger, NSString * _Nonnull))onUnload{
    return ^NSString *(NSUInteger index,NSString *function){
        NSString *functionName = [NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding];
        NSString *optionName = [self functionNameSubOption:functionName];
        
        return [self saveOnWithIndex:index option:optionName function:function];
    };
}

- (NSString * _Nonnull (^)(NSUInteger, NSString * _Nonnull))onClick{
    return ^NSString *(NSUInteger index,NSString *function){
        NSString *functionName = [NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding];
        NSString *optionName = [self functionNameSubOption:functionName];
        
        return [self saveOnWithIndex:index option:optionName function:function];
    };
}

- (NSString * _Nonnull (^)(NSUInteger, NSString * _Nonnull))onDblclick{
    return ^NSString *(NSUInteger index,NSString *function){
        NSString *functionName = [NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding];
        NSString *optionName = [self functionNameSubOption:functionName];
        
        return [self saveOnWithIndex:index option:optionName function:function];
    };
}

- (NSString * _Nonnull (^)(NSUInteger, NSString * _Nonnull))onMousedown{
    return ^NSString *(NSUInteger index,NSString *function){
        NSString *functionName = [NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding];
        NSString *optionName = [self functionNameSubOption:functionName];
        
        return [self saveOnWithIndex:index option:optionName function:function];
    };
}

- (NSString * _Nonnull (^)(NSUInteger, NSString * _Nonnull))onMouseup{
    return ^NSString *(NSUInteger index,NSString *function){
        NSString *functionName = [NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding];
        NSString *optionName = [self functionNameSubOption:functionName];
        
        return [self saveOnWithIndex:index option:optionName function:function];
    };
}

- (NSString * _Nonnull (^)(NSUInteger, NSString * _Nonnull))onMousemove{
    return ^NSString *(NSUInteger index,NSString *function){
        NSString *functionName = [NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding];
        NSString *optionName = [self functionNameSubOption:functionName];
        
        return [self saveOnWithIndex:index option:optionName function:function];
    };
}

- (NSString * _Nonnull (^)(NSUInteger, NSString * _Nonnull))onMouseover{
    return ^NSString *(NSUInteger index,NSString *function){
        NSString *functionName = [NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding];
        NSString *optionName = [self functionNameSubOption:functionName];
        
        return [self saveOnWithIndex:index option:optionName function:function];
    };
}

- (NSString * _Nonnull (^)(NSUInteger, NSString * _Nonnull))onMouseout{
    return ^NSString *(NSUInteger index,NSString *function){
        NSString *functionName = [NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding];
        NSString *optionName = [self functionNameSubOption:functionName];
        
        return [self saveOnWithIndex:index option:optionName function:function];
    };
}

- (NSString * _Nonnull (^)(NSUInteger, NSString * _Nonnull))onMouseenter{
    return ^NSString *(NSUInteger index,NSString *function){
        NSString *functionName = [NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding];
        NSString *optionName = [self functionNameSubOption:functionName];
        
        return [self saveOnWithIndex:index option:optionName function:function];
    };
}

- (NSString * _Nonnull (^)(NSUInteger, NSString * _Nonnull))onMouseleave{
    return ^NSString *(NSUInteger index,NSString *function){
        NSString *functionName = [NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding];
        NSString *optionName = [self functionNameSubOption:functionName];
        
        return [self saveOnWithIndex:index option:optionName function:function];
    };
}

- (NSString * _Nonnull (^)(NSUInteger, NSString * _Nonnull))onChange{
    return ^NSString *(NSUInteger index,NSString *function){
        NSString *functionName = [NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding];
        NSString *optionName = [self functionNameSubOption:functionName];
        
        return [self saveOnWithIndex:index option:optionName function:function];
    };
}

- (NSString * _Nonnull (^)(NSUInteger, NSString * _Nonnull))onSelect{
    return ^NSString *(NSUInteger index,NSString *function){
        NSString *functionName = [NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding];
        NSString *optionName = [self functionNameSubOption:functionName];
        
        return [self saveOnWithIndex:index option:optionName function:function];
    };
}

- (NSString * _Nonnull (^)(NSUInteger, NSString * _Nonnull))onSubmit{
    return ^NSString *(NSUInteger index,NSString *function){
        NSString *functionName = [NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding];
        NSString *optionName = [self functionNameSubOption:functionName];
        
        return [self saveOnWithIndex:index option:optionName function:function];
    };
}

- (NSString * _Nonnull (^)(NSUInteger, NSString * _Nonnull))onKeydown{
    return ^NSString *(NSUInteger index,NSString *function){
        NSString *functionName = [NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding];
        NSString *optionName = [self functionNameSubOption:functionName];
        
        return [self saveOnWithIndex:index option:optionName function:function];
    };
}

- (NSString * _Nonnull (^)(NSUInteger, NSString * _Nonnull))onKeypress{
    return ^NSString *(NSUInteger index,NSString *function){
        NSString *functionName = [NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding];
        NSString *optionName = [self functionNameSubOption:functionName];
        
        return [self saveOnWithIndex:index option:optionName function:function];
    };
}

- (NSString * _Nonnull (^)(NSUInteger, NSString * _Nonnull))onKeyup{
    return ^NSString *(NSUInteger index,NSString *function){
        NSString *functionName = [NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding];
        NSString *optionName = [self functionNameSubOption:functionName];
        
        return [self saveOnWithIndex:index option:optionName function:function];
    };
}

- (NSString * _Nonnull (^)(NSUInteger, NSString * _Nonnull))onError{
    return ^NSString *(NSUInteger index,NSString *function){
        NSString *functionName = [NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding];
        NSString *optionName = [self functionNameSubOption:functionName];
        
        return [self saveOnWithIndex:index option:optionName function:function];
    };
}

- (NSString * _Nonnull (^)(NSUInteger, NSString * _Nonnull))onContextmenu{
    return ^NSString *(NSUInteger index,NSString *function){
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

#pragma mark - 有效性
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
