//
//  JQueryWebMaker.swift
//  JQueryWebSwift
//
//  Created by Bryant Reyn on 2020/5/16.
//  Copyright © 2020 Bryant Reyn. All rights reserved.
//

/**
 * JQueryWebMaker
 * 创建一个JQuery制作者
 */

import Foundation

/* 枚举法设置标签操作种类 */
enum JQueryWebMakerStyle : Int{
    case JQueryWebMakerTextORVal /* innerText */
    case JQueryWebMakerHTML /* innerHTML */
    case JQueryWebMakerON /* on */
    case JQueryWebMakerCSS /* css */
    case JQueryWebMakerShow /* show */
    case JQueryWebMakerShowWithFunction /* show function */
    case JQueryWebMakerShowAnimation /* show animation */
    case JQueryWebMakerHidden /* hidden */
    case JQueryWebMakerHeight /* height */
    case JQueryWebMakerWidth /* width */
    case JQueryWebTagMakerAddClass /* addClass */
    case JQueryWebTagMakerRemoveClass /* removeClass */
    case JQueryWebTagMakerAttrValue /* attrValue */
}

class JQueryWebMaker: NSObject {
    public var tagName : String?
    public var idName : String?
    public var className : String?
    public var context : String?
    
    //整合JQuery动画效果
    private lazy var showAnimationArray : [String] = {
        return ["slow","normal","fast"]
    }()
    
    /* JQuery实现Tag标签处理 */
    init(tagName : String){
        var flag = Bool(true)
        /* 遍历数组判断是否包含 */
        for str : String in ALLTAG {
            //判断字符串相等
            if str == tagName.lowercased() {
                flag = true
                break
            }else{
                flag = false
            }
        }
    
        //抛出异常
        assert(flag, "HTML标签错误,JQueryWeb - 核查标签参数")
        
        //保存标签名称
        self.tagName = tagName
    }
     /* JQuery实现ID处理 */
    init(idName : String) {
        
        /* idName特性必须第一个字符含有#这个符号 */
        if idName.prefix(upTo: idName.index(idName.startIndex, offsetBy: 1)) == "#" {
            self.idName = idName
        }else{
            //抛出异常
            assertionFailure("ID传入错误,JQueryWeb - JQueryWeb - 核查ID参数")
        }
        
    }
    /* JQuery实现Class处理 */
    init(className : String) {
        
        //判断className有效性
        if className.prefix(upTo: className.index(className.startIndex, offsetBy: 1)) == "."{
            self.className = className
        }else{
            assertionFailure("Class传入错误,JQueryWeb - 核查Class参数")
        }
        
        
    }
    
    
}

/* 文本操作 */
//MARK: 文本操作
extension JQueryWebMaker{
    func text(context : String) -> String {
        return saveText(index: 0, context: context, select: JQueryWebMakerStyle.JQueryWebMakerTextORVal)
    }
    func text(index : NSInteger,context : String) -> String {
        return saveText(index: index, context: context, select: JQueryWebMakerStyle.JQueryWebMakerTextORVal)
    }
    func html(context : String) -> String {
        return saveText(index: 0, context: context, select: JQueryWebMakerStyle.JQueryWebMakerHTML)
    }
    func html(index : NSInteger,context : String) -> String {
        return saveText(index: index, context: context
            , select: JQueryWebMakerStyle.JQueryWebMakerHTML)
    }
    func val(context : String) -> String {
        return saveText(index: 0, context: context, select: JQueryWebMakerStyle.JQueryWebMakerTextORVal)
    }
    func val(index : NSInteger,context : String) -> String {
        return saveText(index: index, context: context, select: JQueryWebMakerStyle.JQueryWebMakerTextORVal)
    }
    
    //保存文本信息
    private func saveText(index : NSInteger, context : String,select : JQueryWebMakerStyle) -> String {
        self.context = context
        /* 根据tagName进行选择对应的解析方法 */
        if self.tagName != nil {
            return JQueryWebTagMaker.init(tagName: self.tagName!).parseTextTagNameWithSelect(index: index,context: self.context!, option: nil, function: nil, proDict: nil, height: 0, width: 0, selectStr: select)
        }else if self.idName != nil{
            return JQueryWebIDMaker.init(idName: self.idName!).parseTextIDNameWithSelect(context: self.context!, option: nil,funtion: nil, proDict: nil, height: 0, width: 0, selectStr: select)
        }else if self.className != nil{
            return JQueryWebClassMaker.init(className: self.className!).parseTextClassNameWithSelect(index: index, context: self.context!, option: nil, function: nil, proDict: nil, height: 0, width: 0, selectStr: select)
        }
        
        return String.init()
    }
}

/* ON操作 */
//MARK: ON操作
extension JQueryWebMaker{
    func on(option : String,function : String) -> String {
        return saveOnWithOption(index: 0, option: option, function: function)
    }
    
    func on(index : NSInteger,option : String,function : String) -> String {
        return saveOnWithOption(index: index,option: option,function: function)
    }

    func on(options : String...,function : String) -> [String] {
        var resOnStrArray : [String] = Array.init()
        for option : String in options {
            let resStr : String = saveOnWithOption(index: 0, option: option, function: function)
            
            resOnStrArray.append(resStr)
        }
        
        return resOnStrArray
    }
    
    func on(index : NSInteger,options : String...,function : String) -> [String] {
        var resOnStrArray : [String] = Array.init()
        for option : String in options {
            let resStr : String = saveOnWithOption(index: index, option: option, function: function)
            
            resOnStrArray.append(resStr)
        }
        
        return resOnStrArray
    }
    
    func on(index : NSInteger,input : String...) -> [String] {
        var resOnStrArray : [String] = Array.init()
        for str : String in input {
            /* 保存到数组中 */
            /* 取出参数的两部分 options 和 function */
            let newOption : String = str.components(separatedBy: ":")[0]
            let newFunction : String = str.components(separatedBy: ":")[1]
            let resStr : String = saveOnWithOption(index: index, option: newOption, function: newFunction)
            
            resOnStrArray.append(resStr)
        }
        
        
        return resOnStrArray
    }
    
    /* 保存on操作信息 */
    private func saveOnWithOption(index : NSInteger,option : String,function : String) -> String {
        assert(onOptionsValidity(option: option), "无效on操作,JQueryWeb - JQuery官方未定义此操作")

        if self.tagName != nil {
            return JQueryWebTagMaker.init(tagName: self.tagName!).parseTextTagNameWithSelect(index: index, context: nil, option: option, function: function, proDict: nil, height: 0, width: 0, selectStr: JQueryWebMakerStyle.JQueryWebMakerON)
        }else if self.idName != nil{
            return JQueryWebIDMaker.init(idName: self.idName!).parseTextIDNameWithSelect(context: nil, option: option, funtion: function, proDict: nil, height: 0, width: 0, selectStr:JQueryWebMakerStyle.JQueryWebMakerON)
        }else if self.className != nil{
            return JQueryWebClassMaker.init(className: self.className!).parseTextClassNameWithSelect(index: index, context: nil, option: option, function: function, proDict: nil, height: 0, width: 0, selectStr: JQueryWebMakerStyle.JQueryWebMakerON)
        }
        
        return String.init()
    }

    /* 抛出自定义异常 */
    private func onOptionsValidity(option : String) -> Bool {

        for str : String in ALLOPTIONS {
            if str == option.lowercased(){
                return true
            }
        }

        return false
    }
}

/* on操作展开 */
//MARK: ON操作展开
extension JQueryWebMaker{
    func onBlur(index : NSInteger,function : String) -> String {
        //函数名称
        let functionName : String = #function
        return saveOnWithOption(index: index, option: functionNameSubOption(functionName: functionName), function: function)
    }
    func onFocus(index : NSInteger,function : String) -> String {
        //函数名称
        let functionName : String = #function
        return saveOnWithOption(index: index, option: functionNameSubOption(functionName: functionName), function: function)
    }
    func onFocusin(index : NSInteger,function : String) -> String {
        //函数名称
        let functionName : String = #function
        return saveOnWithOption(index: index, option: functionNameSubOption(functionName: functionName), function: function)
    }
    func onFocusout(index : NSInteger,function : String) -> String {
        //函数名称
        let functionName : String = #function
        return saveOnWithOption(index: index, option: functionNameSubOption(functionName: functionName), function: function)
    }
    func onLoad(index : NSInteger,function : String) -> String {
        //函数名称
        let functionName : String = #function
        return saveOnWithOption(index: index, option: functionNameSubOption(functionName: functionName), function: function)
    }
    func onResize(index : NSInteger,function : String) -> String {
        //函数名称
        let functionName : String = #function
        return saveOnWithOption(index: index, option: functionNameSubOption(functionName: functionName), function: function)
    }
    func onScroll(index : NSInteger,function : String) -> String {
        //函数名称
        let functionName : String = #function
        return saveOnWithOption(index: index, option: functionNameSubOption(functionName: functionName), function: function)
    }
    func onUnload(index : NSInteger,function : String) -> String {
        //函数名称
        let functionName : String = #function
        return saveOnWithOption(index: index, option: functionNameSubOption(functionName: functionName), function: function)
    }
    func onClick(index : NSInteger,function : String) -> String {
        //函数名称
        let functionName : String = #function
        return saveOnWithOption(index: index, option: functionNameSubOption(functionName: functionName), function: function)
    }
    func onDblclick(index : NSInteger,function : String) -> String {
        //函数名称
        let functionName : String = #function
        return saveOnWithOption(index: index, option: functionNameSubOption(functionName: functionName), function: function)
    }
    func onMousedown(index : NSInteger,function : String) -> String {
        //函数名称
        let functionName : String = #function
        return saveOnWithOption(index: index, option: functionNameSubOption(functionName: functionName), function: function)
    }
    func onMouseup(index : NSInteger,function : String) -> String {
        //函数名称
        let functionName : String = #function
        return saveOnWithOption(index: index, option: functionNameSubOption(functionName: functionName), function: function)
    }
    func onMousemove(index : NSInteger,function : String) -> String {
        //函数名称
        let functionName : String = #function
        return saveOnWithOption(index: index, option: functionNameSubOption(functionName: functionName), function: function)
    }
    func onMouseover(index : NSInteger,function : String) -> String {
        //函数名称
        let functionName : String = #function
        return saveOnWithOption(index: index, option: functionNameSubOption(functionName: functionName), function: function)
    }
    func onMouseout(index : NSInteger,function : String) -> String {
        //函数名称
        let functionName : String = #function
        return saveOnWithOption(index: index, option: functionNameSubOption(functionName: functionName), function: function)
    }
    func onMouseenter(index : NSInteger,function : String) -> String {
        //函数名称
        let functionName : String = #function
        return saveOnWithOption(index: index, option: functionNameSubOption(functionName: functionName), function: function)
    }
    func onMouseleave(index : NSInteger,function : String) -> String {
        //函数名称
        let functionName : String = #function
        return saveOnWithOption(index: index, option: functionNameSubOption(functionName: functionName), function: function)
    }
    func onChange(index : NSInteger,function : String) -> String {
        //函数名称
        let functionName : String = #function
        return saveOnWithOption(index: index, option: functionNameSubOption(functionName: functionName), function: function)
    }
    func onSelect(index : NSInteger,function : String) -> String {
        //函数名称
        let functionName : String = #function
        return saveOnWithOption(index: index, option: functionNameSubOption(functionName: functionName), function: function)
    }
    func onSubmit(index : NSInteger,function : String) -> String {
        //函数名称
        let functionName : String = #function
        return saveOnWithOption(index: index, option: functionNameSubOption(functionName: functionName), function: function)
    }
    func onKeydown(index : NSInteger,function : String) -> String {
        //函数名称
        let functionName : String = #function
        return saveOnWithOption(index: index, option: functionNameSubOption(functionName: functionName), function: function)
    }
    func onKeypress(index : NSInteger,function : String) -> String {
        //函数名称
        let functionName : String = #function
        return saveOnWithOption(index: index, option: functionNameSubOption(functionName: functionName), function: function)
    }
    func onKeyup(index : NSInteger,function : String) -> String {
        //函数名称
        let functionName : String = #function
        return saveOnWithOption(index: index, option: functionNameSubOption(functionName: functionName), function: function)
    }
    func onError(index : NSInteger,function : String) -> String {
        //函数名称
        let functionName : String = #function
        return saveOnWithOption(index: index, option: functionNameSubOption(functionName: functionName), function: function)
    }
    func onContextmenu(index : NSInteger,function : String) -> String {
        //函数名称
        let functionName : String = #function
        return saveOnWithOption(index: index, option: functionNameSubOption(functionName: functionName), function: function)
    }
    
    /* 函数名 */
    private func functionNameSubOption(functionName : String) -> String {
       return ((functionName as NSString).components(separatedBy: "(")[0] as NSString).substring(from: 2)
    }
}

/* CSS操作 */
//MARK: CSS操作展开
extension JQueryWebMaker{
    func css(properties : String) -> [String] {
        let cssStr : String = saveCSSWithProperties(index: 0, properties: properties);
        let resArr = NSMutableArray.init()
        
        for resStr : String in cssStr.components(separatedBy: "|") {
            resArr.add(resStr)
        }
        
        return resArr as! [String];
    }
    
    func css(index : NSInteger,properties : String) -> [String] {
        let cssStr : String = saveCSSWithProperties(index: index, properties: properties);
        let resArr = NSMutableArray.init()
        
        for resStr : String in cssStr.components(separatedBy: "|") {
            resArr.add(resStr)
        }
        
        return resArr as! [String];
    }
    
    func css(key : String?,value : String?) -> String {
        let properties : String = String.init(format: "%@:%@", key!,value!)
        let resStr : String = saveCSSWithProperties(index: 0, properties: properties)
        
        return (resStr as NSString).substring(with: NSMakeRange(0, (resStr as NSString).length - 1))
    }
    
    func css(index : NSInteger,key : String?,value : String?) -> String {
        let properties : String = String.init(format: "%@:%@", key!,value!)
        let resStr : String = saveCSSWithProperties(index: index, properties: properties)
        
        return (resStr as NSString).substring(with: NSMakeRange(0, (resStr as NSString).length - 1))
    }

    
    private func saveCSSWithProperties(index : NSInteger,properties : String) -> String {
        let proDict : NSMutableDictionary = NSMutableDictionary.init()
        
        /* 判断语法有效性 */
        let resProperties : String = cssPropertiesValidity(properties: properties)
        let proArr : [String] = resProperties.components(separatedBy: ",")
        
        for str : String in proArr {
            /* 取出key和value */
            let keyAndValue = str.components(separatedBy: ":")
            proDict.setValue(keyAndValue[1], forKey: keyAndValue[0])
        }
        
        if self.tagName != nil {
            return JQueryWebTagMaker.init(tagName: self.tagName!).parseTextTagNameWithSelect(index: index, context: nil, option: nil, function: nil, proDict: proDict, height: 0, width: 0, selectStr: JQueryWebMakerStyle.JQueryWebMakerCSS)
        }else if self.idName != nil{
            return JQueryWebIDMaker.init(idName: self.idName!).parseTextIDNameWithSelect(context: nil, option: nil, funtion: nil, proDict: proDict, height: 0, width: 0, selectStr: JQueryWebMakerStyle.JQueryWebMakerCSS)
        }else if self.className != nil{
            return JQueryWebClassMaker.init(className: self.className!).parseTextClassNameWithSelect(index: index, context: nil, option: nil, function: nil, proDict: proDict, height: 0, width: 0, selectStr: JQueryWebMakerStyle.JQueryWebMakerCSS)
        }
        
        return String.init()
    }
    
    private func cssPropertiesValidity(properties : String) -> String {
        /* 判断是否含有{} */
        var resProperties = properties;
        
        if resProperties.contains("{") && resProperties.contains("}") {
            resProperties = (resProperties as NSString).substring(with:NSMakeRange(1, (properties as NSString).length - 2))
        }else if (resProperties.contains("{") && !resProperties.contains("}")) || (!resProperties.contains("{") && resProperties.contains("}")){
            /* 语法上有错误 */
            /* 发出警告，但是不崩溃程序 */
            print("输入中括号个数不匹配请及时修改！！！")
            
            if resProperties.contains("{"){
                resProperties = (resProperties as NSString).substring(with: NSMakeRange(1, (resProperties as NSString).length - 1))
            }else{
                resProperties = (resProperties as NSString).substring(with: NSMakeRange(0, (resProperties as NSString).length - 1))
            }
        }
        
       return resProperties;
    }
    
    func JQueryWebMakerCSS_RESSTR(tempTAGName : String?,indexStr : String?,proDict : NSMutableDictionary?) -> String {
        var resStr : String = String.init()
        
        if proDict!.count > 0 {
            for i in 0..<proDict!.count{
                let tempStr : String = JQUERY_JS_TAG_CSS(TAGNAME: tempTAGName!, COUNT:indexStr!, KEY: proDict!.allKeys[i] as! String, VALUE: proDict!.allValues[i] as! String)
                resStr = (resStr as NSString).appending((tempStr as NSString).appending("|"))
            }
        }
    
        proDict!.removeAllObjects()
        return resStr
    }
    
    func JQueryWebMakerCSS_RESSTR(tempIDName : String?,indexStr : String?,proDict : NSMutableDictionary?) -> String {
        var resStr : String = String.init()
        
        if proDict!.count > 0 {
            for i in 0..<proDict!.count{
                let tempStr : String = JQUERY_JS_ID_CSS(IDNAME: tempIDName!, KEY: proDict!.allKeys[i] as! String, VALUE: proDict!.allValues[i] as! String)
                resStr = (resStr as NSString).appending((tempStr as NSString).appending("|"))
            }
        }
        
        return resStr
    }
    
    func JQueryWebMakerCSS_RESSTR(tempClassName : String?,indexStr : String?,proDict : NSMutableDictionary?) -> String {
        var resStr : String = String.init()
        
        if proDict!.count > 0 {
            for i in 0..<proDict!.count{
                let tempStr : String = JQUERY_JS_CLASS_CSS(CLASSNAME: tempClassName!, COUNT: indexStr!, KEY: proDict!.allKeys[i] as! String, VALUE: proDict!.allValues[i] as! String)
                resStr = (resStr as NSString).appending((tempStr as NSString).appending("|"))
            }
        }
        
        return resStr
    }
}

/* show操作 hidden操作 */
//MARK: show操作展开 hidden操作
extension JQueryWebMaker{
    func show() -> String {
        return saveShow(index: 0)
    }
    
    func show(index : NSInteger) -> String {
        return saveShow(index:index)
    }
    
    func show(animation : String,function : String) -> String {
        return saveShow(index: 0, animation: animation, function: function)
    }
    
    func show(index : NSInteger,animation : String,function : String) -> String {
        return saveShow(index: index, animation: animation, function: function)
    }
    
    func show(animation : String) -> String {
        assert(showAnimationValidity(animation: animation),"无效动画效果操作,JQueryWeb - JQuery官方未定义此操作")
        
        return saveText(index: 0, context: animation, select: JQueryWebMakerStyle.JQueryWebMakerShowAnimation)
    }
    
    func show(index : NSInteger,animation : String) -> String {
        assert(showAnimationValidity(animation: animation),"无效动画效果操作,JQueryWeb - JQuery官方未定义此操作")
        
        return saveText(index: index, context: animation, select: JQueryWebMakerStyle.JQueryWebMakerShowAnimation)
    }
    
    func hidden() -> String {
        return saveHidden(index: 0)
    }
    
    func hidden(index : NSInteger) -> String {
        return saveHidden(index:index)
    }
    
    //saveShow
    private func saveShow(index : NSInteger) -> String {
        if self.tagName != nil{
            return JQueryWebTagMaker.init(tagName: self.tagName!).parseTextTagNameWithSelect(index: index, context: nil, option: nil, function: nil, proDict: nil, height: 0, width: 0, selectStr: JQueryWebMakerStyle.JQueryWebMakerShow)
        }else if self.idName != nil{
            return JQueryWebIDMaker.init(idName: self.idName!).parseTextIDNameWithSelect(context: nil, option: nil, funtion: nil, proDict: nil, height: 0, width: 0, selectStr: JQueryWebMakerStyle.JQueryWebMakerShow)
        }else if self.className != nil{
            return JQueryWebClassMaker.init(className: self.className!).parseTextClassNameWithSelect(index: index, context: nil, option: nil, function: nil, proDict: nil, height: 0, width: 0, selectStr: JQueryWebMakerStyle.JQueryWebMakerShow)
        }
        
        return String.init()
    }
    
    private func saveShow(index : NSInteger,animation : String,function : String) -> String {
            assert(showAnimationValidity(animation: animation),"无效动画操作,JQueryWeb - JQuery官方未定义此操作")
        
        if self.tagName != nil {
            return JQueryWebTagMaker.init(tagName: self.tagName!).parseTextTagNameWithSelect(index: index, context: nil, option: animation, function: function, proDict: nil, height: 0, width: 0, selectStr: JQueryWebMakerStyle.JQueryWebMakerShowWithFunction)
        }else if self.idName != nil{
            return JQueryWebIDMaker.init(idName: self.idName!).parseTextIDNameWithSelect(context: nil, option: animation, funtion: function, proDict: nil, height: 0, width: 0, selectStr: JQueryWebMakerStyle.JQueryWebMakerShowWithFunction)
        }else if self.className != nil{
            return JQueryWebClassMaker.init(className: self.className!).parseTextClassNameWithSelect(index: index, context: nil, option: animation, function: function, proDict: nil, height: 0, width: 0, selectStr: JQueryWebMakerStyle.JQueryWebMakerShowWithFunction)
        }
        
        return String.init()
    }
    
    //判断show操作有效性
    private func showAnimationValidity(animation : String) -> Bool {
        for str : String in showAnimationArray{
            if (animation as NSString).isEqual(to: str){
                return true
            }
        }
        
        return false
    }
    
    //saveHidden
    private func saveHidden(index : NSInteger) -> String {
        if self.tagName != nil{
            return JQueryWebTagMaker.init(tagName: self.tagName!).parseTextTagNameWithSelect(index: index, context: nil, option: nil, function: nil, proDict: nil, height: 0, width: 0, selectStr: JQueryWebMakerStyle.JQueryWebMakerHidden)
        }else if self.idName != nil{
            return JQueryWebIDMaker.init(idName: self.idName!).parseTextIDNameWithSelect(context: nil, option: nil, funtion: nil, proDict: nil, height: 0, width: 0, selectStr: JQueryWebMakerStyle.JQueryWebMakerHidden)
        }else if self.className != nil{
            return JQueryWebClassMaker.init(className: self.className!).parseTextClassNameWithSelect(index: index, context: nil, option: nil, function: nil, proDict: nil, height: 0, width: 0, selectStr: JQueryWebMakerStyle.JQueryWebMakerHidden)
        }
        
        return String.init()
    }
    
}

/* height操作 height操作 */
//MARK: height操作展开 height操作
extension JQueryWebMaker{
    func height(heightPX : NSInteger) -> String {
        return saveHeightORWidth(index: 0, height: heightPX, width: -1)
    }
    
    func height(index : NSInteger,heightPX : NSInteger) -> String {
        return saveHeightORWidth(index: index, height: heightPX, width: -1)
    }
    
    func width(widthPX : NSInteger) -> String {
        return saveHeightORWidth(index: 0, height: -1, width: widthPX)
    }
    
    func width(index : NSInteger,widthPX : NSInteger) -> String {
        return saveHeightORWidth(index: index, height: -1, width: widthPX)
    }
    
    /* 保存高度和宽度 */
    private func saveHeightORWidth(index : NSInteger,height : NSInteger,width : NSInteger) -> String {
        if height == -1 && width != -1{
            /* 保存宽度 */
            if self.tagName != nil{
                return JQueryWebTagMaker.init(tagName: self.tagName!).parseTextTagNameWithSelect(index:index, context: nil, option: nil, function: nil, proDict: nil, height: 0, width: width, selectStr: JQueryWebMakerStyle.JQueryWebMakerWidth)
            }else if self.idName != nil{
                return JQueryWebIDMaker.init(idName: self.idName!).parseTextIDNameWithSelect(context: nil, option: nil, funtion: nil, proDict: nil, height: 0, width: width, selectStr: JQueryWebMakerStyle.JQueryWebMakerWidth)
            }else if self.className != nil{
                return JQueryWebClassMaker.init(className: self.className!).parseTextClassNameWithSelect(index: index, context: nil, option: nil, function: nil, proDict: nil, height: 0, width:width, selectStr: JQueryWebMakerStyle.JQueryWebMakerWidth)
            }
        }else if height != -1 && width == -1{
            /* 保存高度 */
            if self.tagName != nil{
                return JQueryWebTagMaker.init(tagName: self.tagName!).parseTextTagNameWithSelect(index:index, context: nil, option: nil, function: nil, proDict: nil, height: height, width: 0, selectStr: JQueryWebMakerStyle.JQueryWebMakerHeight)
            }else if self.idName != nil{
                return JQueryWebIDMaker.init(idName: self.idName!).parseTextIDNameWithSelect(context: nil, option: nil, funtion: nil, proDict: nil, height: height, width: 0, selectStr: JQueryWebMakerStyle.JQueryWebMakerHeight)
            }else if self.className != nil{
                return JQueryWebClassMaker.init(className: self.className!).parseTextClassNameWithSelect(index: index, context: nil, option: nil, function: nil, proDict: nil, height: height, width:0, selectStr: JQueryWebMakerStyle.JQueryWebMakerHeight)
            }
        }
        
        return String.init()
    }
}

/* trim操作 */
//MARK: trim操作
extension JQueryWebMaker{
    func trim(index : NSInteger,text : String) -> String {
        return removeSpace(index: index, trimText: text)
    }
    
    //处理空格
    private func removeSpace(index : NSInteger,trimText : String) -> String {
        /* 去除空格 */
        return saveText(index: index, context: trimText.trimmingCharacters(in: CharacterSet.whitespaces), select: JQueryWebMakerStyle.JQueryWebMakerTextORVal)
    }
}

/* Class操作 */
//MARK: addClass操作 removeClass操作
extension JQueryWebMaker{
    func addClass(index : NSInteger,className : String) -> String {
        return saveClassName(index: index, className: className, selectName: JQueryWebMakerStyle.JQueryWebTagMakerAddClass)
    }
    
    func removeClass(index : NSInteger,className : String) -> String {
        return saveClassName(index: index, className: className, selectName: JQueryWebMakerStyle.JQueryWebTagMakerRemoveClass)
    }
    
    //保存Class操作
    private func saveClassName(index : NSInteger,className : String,selectName : JQueryWebMakerStyle) -> String {
        if self.tagName != nil{
            return JQueryWebTagMaker.init(tagName: self.tagName!).parseTextTagNameWithSelect(index: index, context: className, option: nil, function: nil, proDict: nil, height: 0, width: 0, selectStr: selectName)
        }else if self.idName != nil{
            return JQueryWebIDMaker.init(idName: self.idName!).parseTextIDNameWithSelect(context: className, option: nil, funtion: nil, proDict: nil, height: 0, width: 0, selectStr: selectName)
        }else if self.className != nil{
            return JQueryWebClassMaker.init(className: self.className!).parseTextClassNameWithSelect(index: index, context: className, option: nil, function: nil, proDict: nil, height: 0, width: 0, selectStr: selectName)
        }
        
        return String.init()
    }
}

/* attr操作 */
extension JQueryWebMaker{
    func attr(index : NSInteger,attrName : String,value : String) -> String {
        return saveAttr(index: index, context: value, attrName: attrName, selectStr: JQueryWebMakerStyle.JQueryWebTagMakerAttrValue)
    }
    
    func attr(index : NSInteger,options : String...) -> [String] {
        var resArr : [String] = NSMutableArray.init() as! [String]
        
        for str : String in options {
            /* 处理后加入数组 */
            /* 拆分 : 前后的值 */
            let attrName : String = str.components(separatedBy: ":")[0]
            let value : String = str.components(separatedBy: ":")[1]
            
            let resStr = saveAttr(index: index, context: value, attrName: attrName, selectStr: JQueryWebMakerStyle.JQueryWebTagMakerAttrValue)
            resArr.append(resStr)
        }
        
        return resArr
    }
    
    //保存attr操作
    private func saveAttr(index : NSInteger,context : String,attrName : String,selectStr : JQueryWebMakerStyle) -> String {
        if self.tagName != nil {
            return JQueryWebTagMaker.init(tagName: self.tagName!).parseTextTagNameWithSelect(index: index, context: nil, option: attrName, function: context, proDict: nil, height: 0, width: 0, selectStr: selectStr)
        }else if self.idName != nil{
            return JQueryWebIDMaker.init(idName: self.idName!).parseTextIDNameWithSelect(context: nil, option: attrName, funtion: context, proDict: nil, height: 0, width: 0, selectStr: selectStr)
        }else if self.className != nil{
            return JQueryWebClassMaker.init(className: self.className!).parseTextClassNameWithSelect(index: index, context: nil, option: attrName, function: context, proDict: nil, height: 0, width: 0, selectStr: selectStr)
        }
        
        return String.init()
    }
}
