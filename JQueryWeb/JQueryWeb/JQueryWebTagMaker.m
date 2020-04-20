//
//  JQueryWebTagMaker.m
//  JQueryWeb
//
//  Created by Bryant Reyn on 2020/4/15.
//  Copyright © 2020 Bryant Reyn. All rights reserved.
//

/**
 * JQueryWebPTagMaker
 * 用来实现对<p></p>标签的JQuery操作
 */
#import "JQueryWebTagMaker.h"
#import "JQueryWebMacroJavaScript.h"

/* 默认数组下标为0 */
typedef NS_ENUM(NSUInteger,JQueryWebTagMakerIndex){
    JQueryWebTagMakerDefaultIndex = 0
};


@interface JQueryWebTagMaker()
@property (nonatomic,weak,readonly)NSString *tagName; /* 标签名称 */
@property (nonatomic,weak,readonly)NSString *context; /* 文本内容 */
@property (nonatomic,weak,readonly)NSString *option; /* on操作 */
@property (nonatomic,weak,readonly)NSString *function; /* 函数封装 */
@property (nonatomic,weak,readonly)NSMutableDictionary *cssproperties; /* css传入字典封装 */
@end

@implementation JQueryWebTagMaker
#pragma mark -- 实例化
+ (instancetype)TagMakerName:(NSString *)tagName context:(NSString *)context{
    return [[self alloc] initWithTagName:tagName context:context];
}

- (instancetype)initWithTagName:(NSString *)tagName context:(NSString *)context{
    self = [super init];
    if (self) {
        _tagName = tagName;
        _context = context;
    }
    return self;
}

+ (instancetype)TagMakerName:(NSString *)tagName option:(NSString *)option function:(NSString *)function{
    return [[self alloc] initWithTagName:tagName option:option function:function];
}

- (instancetype)initWithTagName:(NSString *)tagName option:(NSString *)option function:(NSString *)function{
    self = [super init];
    if (self) {
        _tagName = tagName;
        _option = option;
        _function = function;
    }
    return self;
}

+ (instancetype)TagMakerName:(NSString *)tagName properties:(NSMutableDictionary *)dict{
    return [[self alloc] initWithTagName:tagName properties:dict];
}

- (instancetype)initWithTagName:(NSString *)tagName properties:(NSMutableDictionary *)dict{
    self = [super init];
    if (self) {
        _tagName = tagName;
        _cssproperties = dict;
    }
    return self;
}

#pragma mark - 解析文本内容标签
- (NSString * _Nonnull)parseTextTagNameWithSelect:(JQueryWebMakerStyle)selectStr{
    NSString *indexStr = [NSString stringWithFormat:@"%zd",JQueryWebTagMakerDefaultIndex];
    if (selectStr == JQueryWebMakerTextORVal) {
        return JQUERY_JS_TAG_TEXT_VAL(_tagName,indexStr,_context);
    }else if(selectStr == JQueryWebMakerHTML){
        return JQUERY_JS_TAG_HTML(_tagName,indexStr, _context);
    }else if (selectStr == JQueryWebMakerON){
        NSString *newOptionStr = [self humpStr:_option];
        NSString *newFunction = [self removeFunctionSemicolon:_function];
        return JQUERY_JS_TAG_ON(_tagName, indexStr, newOptionStr, newFunction);
    }else if (selectStr == JQueryWebMakerCSS){
        /* 从保存的数组中获得key和value */
        @synchronized (self) {
            NSMutableDictionary *tempDict = [_cssproperties copy];
            NSString *resStr = [NSString string];
            for (NSUInteger i = 0; i < [tempDict count]; i++) {
                NSString *tempStr = JQUERY_JS_TAG_CSS(_tagName, indexStr, tempDict.allKeys[i], tempDict.allValues[i]);
                resStr = [resStr stringByAppendingString:[tempStr stringByAppendingString:@"|"]];
            }
            
            return resStr;
        }
    }
    
    return [NSString string];
}

- (NSString *)parseTextTagNameWithSelect:(JQueryWebMakerStyle)selectStr index:(NSUInteger)index{
    NSCParameterAssert(index >= 0);
    NSString *indexStr = [NSString stringWithFormat:@"%zd",index];
    if (selectStr == JQueryWebMakerTextORVal) {
        return JQUERY_JS_TAG_TEXT_VAL(_tagName,indexStr,_context);
    }else if(selectStr == JQueryWebMakerHTML){
        return JQUERY_JS_TAG_HTML(_tagName, indexStr, _context);
    }else if (selectStr == JQueryWebMakerON){
        NSString *newOptionStr = [self humpStr:_option];
        NSString *newFunction = [self removeFunctionSemicolon:_function];
        return JQUERY_JS_TAG_ON(_tagName, indexStr, newOptionStr, newFunction);
    }else if (selectStr == JQueryWebMakerCSS){
        /* 从保存的数组中获得key和value */
        @synchronized (self) {
            NSMutableDictionary *tempDict = [_cssproperties copy];
            NSString *resStr = [NSString string];
            for (NSUInteger i = 0; i < [tempDict count]; i++) {
                NSString *tempStr = JQUERY_JS_TAG_CSS(_tagName, indexStr, tempDict.allKeys[i], tempDict.allValues[i]);
                resStr = [resStr stringByAppendingString:[tempStr stringByAppendingString:@"|"]];
            }
            
            return resStr;
        }
    }
    
    return [NSString string];
}


#pragma mark - humpStr
- (NSString *__nonnull)humpStr:(NSString *__nonnull)str{
    NSCParameterAssert(str != NULL);
    
    /* 处理option字符串,防止用户没有使用驼峰使用 */
    NSString *firstStr = [str substringWithRange:NSMakeRange(0, 1)];
    NSString *upcaseStr = [firstStr uppercaseString];
    NSString *lastStr = [str substringWithRange:NSMakeRange(1, _option.length-1)];
    
    return [upcaseStr stringByAppendingString:lastStr];
}

- (NSString *__nonnull)removeFunctionSemicolon:(NSString *__nonnull)str{
    NSCParameterAssert(str != NULL);
    
    NSString *lastStr =[str substringFromIndex:str.length-1];
    
    if([lastStr isEqualToString:@";"]) return [str substringWithRange:NSMakeRange(0, str.length-1)]; else return str;
}
@end
