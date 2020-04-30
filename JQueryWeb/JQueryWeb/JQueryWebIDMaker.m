//
//  JQueryWebIDMaker.m
//  JQueryWeb
//
//  Created by Bryant Reyn on 2020/4/23.
//  Copyright © 2020 Bryant Reyn. All rights reserved.
//

#import "JQueryWebIDMaker.h"
#import "JQueryWebMacroJavaScript.h"

/* 默认数组下标为0 */
typedef NS_ENUM(NSUInteger,JQueryWebTagMakerIndex){
    JQueryWebTagMakerDefaultIndex = 0
};

@interface JQueryWebIDMaker()
@property (nonatomic,weak,readonly)NSString *idName; /* 标签名称 */
@property (nonatomic,weak,readonly)NSString *context; /* 文本内容 */
@property (nonatomic,weak,readonly)NSString *option; /* on操作 */
@property (nonatomic,weak,readonly)NSString *function; /* 函数封装 */
@property (nonatomic,weak,readonly)NSMutableDictionary *cssproperties; /* css传入字典封装 */
@property (nonatomic,assign,readonly)NSUInteger height; //高度
@property (nonatomic,assign,readonly)NSUInteger weight; //宽度
@end

@implementation JQueryWebIDMaker
#pragma mark -- 实例化
+ (instancetype)IDMakerName:(NSString *)idName{
    return [[self alloc] initWithIDName:idName];
}

- (instancetype)initWithIDName:(NSString *)idName
{
    self = [super init];
    if (self) {
        _idName = idName;
    }
    return self;
}

+ (instancetype)IDMakerName:(NSString *)idName context:(NSString *)context{
    return [[self alloc] initWithIDName:idName context:context];
}

- (instancetype)initWithIDName:(NSString *)idName context:(NSString *)context{
    self = [super init];
    if (self) {
        _idName = idName;
        _context = context;
    }
    return self;
}

+ (instancetype)IDMakerName:(NSString *)idName option:(NSString *)option function:(NSString *)function{
    return [[self alloc] initWithIDName:idName option:option function:function];
}

- (instancetype)initWithIDName:(NSString *)idName option:(NSString *)option function:(NSString *)function{
    self = [super init];
    if (self) {
        _idName = idName;
        _option = option;
        _function = function;
    }
    return self;
}

+ (instancetype)IDMakerName:(NSString *)idName properties:(NSMutableDictionary *)dict{
    return [[self alloc] initWithIDName:idName properties:dict];
}

- (instancetype)initWithIDName:(NSString *)idName properties:(NSMutableDictionary *)dict{
    self = [super init];
    if (self) {
        _idName = idName;
        _cssproperties = dict;
    }
    return self;
}

+ (instancetype)IDMakerName:(NSString *)idName height:(NSUInteger)height{
    return [[self alloc] initWithIDName:idName height:height];
}

- (instancetype)initWithIDName:(NSString *)idName height:(NSUInteger)height{
    self = [super init];
    if (self) {
        _idName = idName;
        _height = height;
    }
    return self;
}

+ (instancetype)IDMakerName:(NSString *)idName width:(NSUInteger)width{
    return [[self alloc] initWithIDName:idName width:width];
}

- (instancetype)initWithIDName:(NSString *)idName width:(NSUInteger)width{
    self = [super init];
    if (self) {
        _idName = idName;
        _weight = width;
    }
    return self;
}

#pragma mark - 解析文本内容标签
- (NSString * _Nonnull)parseTextIDNameWithSelect:(JQueryWebMakerStyle)selectStr{
    NSString *tempStr = [_idName substringFromIndex:1];
    _idName = tempStr;
    
    if (selectStr == JQueryWebMakerTextORVal) {
        return JQUERY_JS_ID_TEXT_VAL(_idName,_context);
    }else if(selectStr == JQueryWebMakerHTML){
        return JQUERY_JS_ID_HTML(_idName, _context);
    }else if (selectStr == JQueryWebMakerON){
        NSString *newOptionStr = [self humpStr:_option];
        NSString *newFunction = [self removeFunctionSemicolon:_function];
        return JQUERY_JS_ID_ON(_idName,newOptionStr, newFunction);
    }else if (selectStr == JQueryWebMakerCSS){
        /* 从保存的数组中获得key和value */
        @synchronized (self) {
            NSMutableDictionary *tempDict = [_cssproperties copy];
            NSString *resStr = [NSString string];
            for (NSUInteger i = 0; i < [tempDict count]; i++) {
                NSString *tempStr = JQUERY_JS_ID_CSS(_idName, tempDict.allKeys[i], tempDict.allValues[i]);
                resStr = [resStr stringByAppendingString:[tempStr stringByAppendingString:@"|"]];
            }
            
            return resStr;
        }
    }else if (selectStr == JQueryWebMakerShow){
        /* show操作 */
        return JQUERY_JS_ID_SHOW(_idName);
    }else if (selectStr == JQueryWebMakerShowWithFunction){
        return JQUERY_JS_ID_SHOWF(_idName, _option, _function);
    }else if (selectStr == JQueryWebMakerShowAnimation){
        return JQUERY_JS_ID_SHOWA(_idName, _context);
    }else if (selectStr == JQueryWebMakerHidden){
        return JQUERY_JS_ID_HIDDEN(_idName);
    }else if (selectStr == JQueryWebMakerHeight){
        return JQUERY_JS_ID_HEIGHT(_idName, _height);
    }else if (selectStr == JQueryWebMakerWidth){
        return JQUERY_JS_ID_WIDTH(_idName, _weight);
    }else if (selectStr == JQueryWebTagMakerAddClass){
        return JQUERY_JS_ID_ADDCLASS(_idName, _context);
    }else if (selectStr == JQueryWebTagMakerRemoveClass){
        return JQUERY_JS_ID_REMOVECLASS(_idName, _context);
    }else if (selectStr == JQueryWebTagMakerAttrValue){
        return JQUERY_JS_ID_ATTRVALUE_FUNCTION(_idName, _option, _function);
    }
    
    return [NSString string];
}

#pragma mark - humpStr
- (NSString *__nonnull)humpStr:(NSString *__nonnull)str{
    NSCParameterAssert(str != NULL);
    
    return [[str substringWithRange:NSMakeRange(0, _option.length)] lowercaseString];
}

- (NSString *__nonnull)removeFunctionSemicolon:(NSString *__nonnull)str{
    NSCParameterAssert(str != NULL);
    
    NSString *lastStr =[str substringFromIndex:str.length-1];
    
    if([lastStr isEqualToString:@";"]) return [str substringWithRange:NSMakeRange(0, str.length-1)]; else return str;
}
@end
