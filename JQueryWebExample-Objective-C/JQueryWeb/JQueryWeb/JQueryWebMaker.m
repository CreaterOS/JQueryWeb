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
#import "JQueryWebIDMaker.h"
#import "JQueryWebClassMaker.h"

@interface JQueryWebMaker()
@property (nonatomic,weak)NSString *tagName; /* 标签名称 */
@property (nonatomic,weak)NSString *idName; /* 标签名称 */
@property (nonatomic,weak)NSString *className; /* 标签名称 */
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

#pragma mark - JQuery标签
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

#pragma mark - JQuery ID
+ (JQueryWebMaker * _Nonnull (^)(NSString * _Nonnull))JQueryID{
    JQUERY_BLOCK_WEAK;
    return ^JQueryWebMaker*(NSString *idName){
        JQUERY_BLOCK_STRONG;
        return [[self alloc] initWithIDName:idName];
    };
}

- (instancetype)initWithIDName:(NSString *)idName{
    NSCParameterAssert(idName != NULL);
    self = [super init];
    if (self) {
        /* 此处需要判断ID的有效性 */
        if(![self idNameValidity:idName]){
            NSException *ex = [NSException exceptionWithName:@"ID传入错误" reason:@"JQueryWeb - 核查ID参数" userInfo:nil];
            [ex raise];
        }
        _idName = idName;
    }
    return self;
}

#pragma mark - JQuery Class
+ (JQueryWebMaker * _Nonnull (^)(NSString * _Nonnull))JQueryClass{
    JQUERY_BLOCK_WEAK;
    return ^JQueryWebMaker*(NSString *className){
        JQUERY_BLOCK_STRONG;
        return [[self alloc] initWithClassName:className];
    };
}

- (instancetype)initWithClassName:(NSString *)className{
    NSCParameterAssert(className != NULL);
    
    self = [super init];
    if (self) {
        /* 此处需要判断Class的有效性 */
        if(![self classNameValidity:className]){
            NSException *ex = [NSException exceptionWithName:@"Class传入错误" reason:@"JQueryWeb - 核查Class参数" userInfo:nil];
            [ex raise];
        }
        _className = className;
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

#pragma mark - trim操作
- (NSString * _Nonnull (^)(NSUInteger, NSString * _Nonnull))trim{
    JQUERY_BLOCK_WEAK;
    return ^NSString *(NSUInteger index,NSString *text){
        JQUERY_BLOCK_STRONG;
        return [self removeSpace:text index:index];
    };
}

#pragma mark - addClass添加类名称
- (NSString * _Nonnull (^)(NSUInteger, NSString * _Nonnull))addClass{
    JQUERY_BLOCK_WEAK;
    return ^NSString *(NSUInteger index,NSString *className){
        JQUERY_BLOCK_STRONG;
        return [self saveClassName:className index:index selectName:JQueryWebTagMakerAddClass];
    };
}

#pragma mark - removeClass删除类名称
- (NSString * _Nonnull (^)(NSUInteger, NSString * _Nonnull))removeClass{
    JQUERY_BLOCK_WEAK;
    return ^NSString *(NSUInteger index,NSString *className){
        JQUERY_BLOCK_STRONG;
        return [self saveClassName:className index:index selectName:JQueryWebTagMakerRemoveClass];
    };
}

#pragma mark - attr操作
- (NSString * _Nonnull (^)(NSUInteger, NSString * _Nonnull, NSString * _Nonnull))attr{
    JQUERY_BLOCK_WEAK;
    return ^NSString *(NSUInteger index,NSString *attrName,NSString *value){
        JQUERY_BLOCK_STRONG;
        return [self saveAttr:value index:index selectStr:JQueryWebTagMakerAttrValue attrName:attrName];
    };
}

- (NSString * _Nonnull (^)(NSUInteger, NSString * _Nonnull, NSString * _Nonnull))attrFunction{
    JQUERY_BLOCK_WEAK;
    return ^NSString *(NSUInteger index,NSString *attrName,NSString *value){
        JQUERY_BLOCK_STRONG;
        return [self saveAttr:value index:index selectStr:JQueryWebTagMakerAttrValue attrName:attrName];
    };
}

- (NSMutableArray * _Nonnull (^)(NSUInteger, ...))attrMore{
    JQUERY_BLOCK_WEAK;
    return ^NSMutableArray *(NSUInteger index,...){
        JQUERY_BLOCK_STRONG;
        /* 可变参数 */
        /* 封装字典 */
        
        NSString *options = [NSString string];
        va_list arg_list;
        
        va_start(arg_list, index);
        
        while ((options = va_arg(arg_list, NSString *))) {
            /* 处理后加入数组 */
            /* 拆分 : 前后的值 */
            NSString *attrName = [options componentsSeparatedByString:@":"][0];
            NSString *value =  [options componentsSeparatedByString:@":"][1];
            NSString *resStr = [self saveAttr:value index:index selectStr:JQueryWebTagMakerAttrValue attrName:attrName];
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

#pragma mark - id有效性
- (Boolean)idNameValidity:(NSString *)idName{
    NSCParameterAssert(idName != NULL);
    
    /* idName特性必须第一个字符含有#这个符号 */
    return [[idName substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"#"];
}

#pragma mark - class有效性
- (Boolean)classNameValidity:(NSString *)className{
    NSCParameterAssert(className != NULL);
    
    /* className特性必须第一个字符含有.这个符号 */
    return [[className substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"."];
}


#pragma mark - 解析标签
- (NSString *__nonnull)parseTagName:(NSString *)tagName options:(NSString *(^)(void))option{
    NSCParameterAssert(tagName != NULL);
    
    return option();
}

#pragma mark - 保存操作
#pragma mark - 保存文本信息
- (NSString *__nonnull)saveText:(NSString *)context select:(JQueryWebMakerStyle)select{
    NSCParameterAssert(context != NULL);
    
    @synchronized (self) {
        _context = context;
        /* 根据tagName进行选择对应的解析方法 */
        if (_tagName != NULL) {
            return [self parseTagName:_tagName options:^NSString *{
                JQueryWebTagMaker *tagMaker = [JQueryWebTagMaker TagMakerName:self.tagName context:self.context];
                return [tagMaker parseTextTagNameWithSelect:select];
            }];
        }else if (_idName != NULL){
            JQueryWebIDMaker *idMaker = [JQueryWebIDMaker IDMakerName:self.idName context:self.context];
            return [idMaker parseTextIDNameWithSelect:select];
        }else if (_className != NULL){
            JQueryWebClassMaker *classMaker = [JQueryWebClassMaker ClassMakerName:self.className context:self.context];
            return [classMaker parseTextClassNameWithSelect:select];
        }
    }
    
    return [NSString string];
}

- (NSString *__nonnull)saveText:(NSString *)context index:(NSUInteger)index select:(JQueryWebMakerStyle)select{
    NSCParameterAssert(context != NULL);
    
    @synchronized (self) {
        _context = context;
        _index = index;
        
        if (_tagName != NULL) {
            /* 根据tagName进行选择对应的解析方法 */
            return [self parseTagName:_tagName options:^NSString *{
                
                JQueryWebTagMaker *tagMaker = [JQueryWebTagMaker TagMakerName:self.tagName context:self.context];
                return [tagMaker parseTextTagNameWithSelect:select index:index];
            }];
        }else if (_idName != NULL){
            JQueryWebIDMaker *idMaker = [JQueryWebIDMaker IDMakerName:self.idName context:self.context];
            return [idMaker parseTextIDNameWithSelect:select];
        }else if (_className != NULL){
            JQueryWebClassMaker *classMaker = [JQueryWebClassMaker ClassMakerName:self.className context:self.context];
            return [classMaker parseTextClassNameWithSelect:select index:index];
        }
    }
    
    return [NSString string];
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
        
        if (_tagName != NULL) {
            return [self parseTagName:_tagName options:^NSString *{
                JQueryWebTagMaker *tagMaker = [JQueryWebTagMaker TagMakerName:self.tagName option:self.option function:self.function];
                return [tagMaker parseTextTagNameWithSelect:JQueryWebMakerON];
            }];
        }else if (_idName != NULL){
            JQueryWebIDMaker *idMaker = [JQueryWebIDMaker IDMakerName:self.idName option:self.option function:self.function];
            return [idMaker parseTextIDNameWithSelect:JQueryWebMakerON];
        }else if (_className != NULL){
            JQueryWebClassMaker *classMaker = [JQueryWebClassMaker ClassMakerName:self.className option:self.option function:self.function];
            return [classMaker parseTextClassNameWithSelect:JQueryWebMakerON];
        }
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
        if (_tagName != NULL) {
            return [self parseTagName:_tagName options:^NSString *{
                JQueryWebTagMaker *tagMaker = [JQueryWebTagMaker TagMakerName:self.tagName option:self.option function:self.function];
                return [tagMaker parseTextTagNameWithSelect:JQueryWebMakerON index:index];
            }];
        }else if (_idName != NULL){
            JQueryWebIDMaker *idMaker = [JQueryWebIDMaker IDMakerName:self.idName option:self.option function:self.function];
            return [idMaker parseTextIDNameWithSelect:JQueryWebMakerON];
        }else if (_className != NULL){
            JQueryWebClassMaker *classMaker = [JQueryWebClassMaker ClassMakerName:self.className option:self.option function:self.function];
            return [classMaker parseTextClassNameWithSelect:JQueryWebMakerON index:index];
        }
    }
    
    return [NSString string];
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
    
    
    if (_tagName != NULL) {
        return [self parseTagName:_tagName options:^NSString *{
            /* 保存到Tag字典中去 */
            JQueryWebTagMaker *tagM = [JQueryWebTagMaker TagMakerName:self.tagName properties:proDict];
            return [tagM parseTextTagNameWithSelect:JQueryWebMakerCSS];
        }];
    }else if (_idName != NULL){
        JQueryWebIDMaker *idM = [JQueryWebIDMaker IDMakerName:self.idName properties:proDict];
        return [idM parseTextIDNameWithSelect:JQueryWebMakerCSS];
    }else if (_className != NULL){
        JQueryWebClassMaker *classM = [JQueryWebClassMaker ClassMakerName:self.className properties:proDict];
        return [classM parseTextClassNameWithSelect:JQueryWebMakerCSS];
    }
    
    return [NSString string];
}

- (NSString *)saveCSSWithIndex:(NSUInteger)index properties:(NSString *)properties{
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
    
    if(_tagName != NULL){
        return [self parseTagName:_tagName options:^NSString *{
            /* 保存到Tag字典中去 */
            JQueryWebTagMaker *tagM = [JQueryWebTagMaker TagMakerName:self.tagName properties:proDict];
            return [tagM parseTextTagNameWithSelect:JQueryWebMakerCSS index:index];
        }];
    }else if (_idName != NULL){
        [self saveCSSWithProperties:properties];
    }else if (_className != NULL){
        JQueryWebClassMaker *classM = [JQueryWebClassMaker ClassMakerName:self.className properties:proDict];
        return [classM parseTextClassNameWithSelect:JQueryWebMakerCSS index:index];
    }
    
    return [NSString string];
}

#pragma mark - 保存hidden操作
- (NSString *)saveHidden{
    if(_tagName != NULL){
        return [self parseTagName:_tagName options:^NSString *{
            JQueryWebTagMaker *tag = [JQueryWebTagMaker TagMakerName:self.tagName];
            return [tag parseTextTagNameWithSelect:JQueryWebMakerHidden];
        }];
    }else if (_idName != NULL){
        JQueryWebIDMaker *idM = [JQueryWebIDMaker IDMakerName:self.idName];
        return [idM parseTextIDNameWithSelect:JQueryWebMakerHidden];
    }else if (_className != NULL){
        JQueryWebClassMaker *classM = [JQueryWebClassMaker ClassMakerName:self.className];
        return [classM parseTextClassNameWithSelect:JQueryWebMakerHidden];
    }
    
    return [NSString string];
}

- (NSString *)saveHiddenWithIndex:(NSUInteger)index{
    if(_tagName != NULL){
        return [self parseTagName:_tagName options:^NSString *{
            JQueryWebTagMaker *tag = [JQueryWebTagMaker TagMakerName:self.tagName];
            return [tag parseTextTagNameWithSelect:JQueryWebMakerHidden index:index];
        }];
    }else if(_idName != NULL){
        [self saveHidden];
    }else if (_className != NULL){
        JQueryWebClassMaker *classM = [JQueryWebClassMaker ClassMakerName:self.className];
        return [classM parseTextClassNameWithSelect:JQueryWebMakerHidden index:index];
    }
    
    return [NSString string];
}

#pragma mark - 保存show操作
- (NSString *)saveShow{
    if(_tagName != NULL){
        return [self parseTagName:_tagName options:^NSString *{
            JQueryWebTagMaker *tag = [JQueryWebTagMaker TagMakerName:self.tagName];
            return [tag parseTextTagNameWithSelect:JQueryWebMakerShow];
        }];
    }else if(_idName != NULL){
        JQueryWebIDMaker *idM = [JQueryWebIDMaker IDMakerName:self.idName];
        return [idM parseTextIDNameWithSelect:JQueryWebMakerShow];
    }else if (_className != NULL){
        JQueryWebClassMaker *classM = [JQueryWebClassMaker ClassMakerName:self.className];
        return [classM parseTextClassNameWithSelect:JQueryWebMakerShow];
    }
            
    return [NSString string];
}

- (NSString *)saveShowWithIndex:(NSUInteger)index{
    
    if(_tagName != NULL){
        return [self parseTagName:_tagName options:^NSString *{
            JQueryWebTagMaker *tag = [JQueryWebTagMaker TagMakerName:self.tagName];
            return [tag parseTextTagNameWithSelect:JQueryWebMakerShow index:index];
        }];
    }else if(_idName != NULL){
        [self saveShow];
    }else if (_className != NULL){
        JQueryWebClassMaker *classM = [JQueryWebClassMaker ClassMakerName:self.className];
        return [classM parseTextClassNameWithSelect:JQueryWebMakerShow index:index];
    }
    
    return [NSString string];
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
        
        if (_tagName != NULL) {
            return [self parseTagName:_tagName options:^NSString *{
                JQueryWebTagMaker *tagMaker = [JQueryWebTagMaker TagMakerName:self.tagName option:self.option function:self.function];
                return [tagMaker parseTextTagNameWithSelect:JQueryWebMakerShowWithFunction];
            }];
        }else if(_idName != NULL){
            JQueryWebIDMaker *idMaker = [JQueryWebIDMaker IDMakerName:self.idName option:self.option function:self.function];
            return [idMaker parseTextIDNameWithSelect:JQueryWebMakerShowWithFunction];
        }else if (_className != NULL){
            JQueryWebClassMaker *classMaker = [JQueryWebClassMaker ClassMakerName:self.className option:self.option function:self.function];
            return [classMaker parseTextClassNameWithSelect:JQueryWebMakerShowWithFunction];
        }
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
        
        if (_tagName != NULL) {
            return [self parseTagName:_tagName options:^NSString *{
                JQueryWebTagMaker *tagMaker = [JQueryWebTagMaker TagMakerName:self.tagName option:self.option function:self.function];
                return [tagMaker parseTextTagNameWithSelect:JQueryWebMakerShowWithFunction index:index];
            }];
        }else if (_idName != NULL){
            [self saveShowWithOption:option function:function];
        }else if (_className != NULL){
            JQueryWebClassMaker *classMaker = [JQueryWebClassMaker ClassMakerName:self.className option:self.option function:self.function];
            return [classMaker parseTextClassNameWithSelect:JQueryWebMakerShowWithFunction index:index];
        }
    }
    
    return [NSString string];
}

#pragma mark - 保存height操作和weight操作
- (NSString *)saveHeight:(NSUInteger)height width:(NSUInteger)width{
    
    if (height == -1 && width != -1) {
        /* 保存宽度 */
        if (_tagName != NULL) {
            return [self parseTagName:_tagName options:^NSString *{
                JQueryWebTagMaker *tag = [JQueryWebTagMaker TagMakerName:self.tagName width:width];
                return [tag parseTextTagNameWithSelect:JQueryWebMakerWidth];
            }];
        }else if (_idName != NULL){
            JQueryWebIDMaker *idM = [JQueryWebIDMaker IDMakerName:self.idName width:width];
            return [idM parseTextIDNameWithSelect:JQueryWebMakerWidth];
        }else if (_className != NULL){
            JQueryWebClassMaker *classM = [JQueryWebClassMaker ClassMakerName:self.className width:width];
            return [classM parseTextClassNameWithSelect:JQueryWebMakerWidth];
        }
    }else if(height != -1 && width == -1){
        if (_tagName != NULL) {
            return [self parseTagName:_tagName options:^NSString *{
                /* 保存高度 */
                JQueryWebTagMaker *tag = [JQueryWebTagMaker TagMakerName:self.tagName height:height];
                return [tag parseTextTagNameWithSelect:JQueryWebMakerHeight];
            }];
        }else if (_idName != NULL){
            JQueryWebIDMaker *idM = [JQueryWebIDMaker IDMakerName:self.idName height:height];
            return [idM parseTextIDNameWithSelect:JQueryWebMakerHeight];
        }else if (_className != NULL){
            JQueryWebClassMaker *classM = [JQueryWebClassMaker ClassMakerName:self.className height:height];
            return [classM parseTextClassNameWithSelect:JQueryWebMakerHeight];
        }
    }
    
    return [NSString string];
}

- (NSString *)saveHeight:(NSUInteger)height width:(NSUInteger)width index:(NSUInteger)index{
    
    if (_idName != NULL) {
        [self saveHeight:height width:width];
    }else if(_tagName != NULL){
        if (height == -1 && width != -1) {
            /* 保存宽度 */
            JQueryWebTagMaker *tag = [JQueryWebTagMaker TagMakerName:_tagName width:width];
            return [tag parseTextTagNameWithSelect:JQueryWebMakerWidth index:index];
        }else if(height != -1 && width == -1){
            /* 保存高度 */
            JQueryWebTagMaker *tag = [JQueryWebTagMaker TagMakerName:_tagName height:height];
            return [tag parseTextTagNameWithSelect:JQueryWebMakerHeight index:index];
        }
    }else if (_className != NULL){
        if (height == -1 && width != -1) {
            /* 保存宽度 */
            JQueryWebClassMaker *classM = [JQueryWebClassMaker ClassMakerName:_className width:width];
            return [classM parseTextClassNameWithSelect:JQueryWebMakerWidth index:index];
        }else if(height != -1 && width == -1){
            /* 保存高度 */
            JQueryWebClassMaker *classM = [JQueryWebClassMaker ClassMakerName:_className height:height];
            return [classM parseTextClassNameWithSelect:JQueryWebMakerHeight index:index];
        }
    }
    
    return [NSString string];
}

#pragma mark - 保存Class操作
- (NSString *__nonnull)saveClassName:(NSString *)className index:(NSUInteger)index selectName:(JQueryWebMakerStyle)selectName{
    NSCParameterAssert(className != NULL);
    NSCParameterAssert(index >= 0);
    
    if (_tagName != NULL) {
        return [self parseTagName:_tagName options:^NSString *{
            JQueryWebTagMaker *tag = [JQueryWebTagMaker TagMakerName:self.tagName context:className];
            return [tag parseTextTagNameWithSelect:selectName index:index];
        }];
    }else if (_idName != NULL){
        JQueryWebIDMaker *idM = [JQueryWebIDMaker IDMakerName:self.idName context:className];
        return [idM parseTextIDNameWithSelect:selectName];
    }else if (_className != NULL){
        JQueryWebClassMaker *classM = [JQueryWebClassMaker ClassMakerName:self.className context:className];
        return [classM parseTextClassNameWithSelect:selectName index:index];
    }
    
    return [NSString string];
}

#pragma mark - 保存attr操作
- (NSString *)saveAttr:(NSString *)context index:(NSUInteger)index selectStr:(JQueryWebMakerStyle)selectStr attrName:(NSString *)attrName{
    NSCParameterAssert(context != NULL);
    NSCParameterAssert(index >= 0);
    
    if (_tagName != NULL) {
        return [self parseTagName:_tagName options:^NSString *{
            JQueryWebTagMaker *tag = [JQueryWebTagMaker TagMakerName:self.tagName option:attrName function:context];
            return [tag parseTextTagNameWithSelect:selectStr index:index];
        }];
    }else if (_idName != NULL){
        JQueryWebIDMaker *idM = [JQueryWebIDMaker IDMakerName:self.idName option:attrName function:context];
        return [idM parseTextIDNameWithSelect:selectStr];
    }else if (_className != NULL){
        JQueryWebClassMaker *classM = [JQueryWebClassMaker ClassMakerName:self.className option:attrName function:context];
        return [classM parseTextClassNameWithSelect:selectStr index:index];
    }
    
    return [NSString string];
}

@end
