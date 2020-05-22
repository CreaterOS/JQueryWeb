//
//  JQueryWebClassMaker.swift
//  JQueryWebSwift
//
//  Created by Bryant Reyn on 2020/5/17.
//  Copyright © 2020 Bryant Reyn. All rights reserved.
//

import Foundation

class JQueryWebClassMaker: JQueryWebMaker {

    func parseTextClassNameWithSelect(index : NSInteger,context : String?,option : String?,function : String?,proDict : NSMutableDictionary?,height : NSInteger,width : NSInteger,selectStr : JQueryWebMakerStyle) -> String {
        let indexStr : String?
        if index > 0 {
            indexStr = String.init(format: "%zd", index)
        }else{
            indexStr = String.init(format: "%zd", 0)
        }
        
        var tempClassName = super.className!
        tempClassName = (tempClassName as NSString).substring(from: 1)
        
        switch selectStr {
        case JQueryWebMakerStyle.JQueryWebMakerTextORVal:
            return JQUERY_JS_CLASS_TEXT_VAL(CLASSNAME: tempClassName, COUNT: indexStr!, CONTEXT: context!)
        case JQueryWebMakerStyle.JQueryWebMakerHTML:
            return JQUERY_JS_CLASS_HTML(CLASSNAME: tempClassName, COUNT: indexStr!, CONTEXT: context!)
        case JQueryWebMakerStyle.JQueryWebMakerON:
            return JQUERY_JS_CLASS_ON(CLASSNAME: tempClassName, COUNT: indexStr!, OPTION: option!, FUNCTION: function!)
        case JQueryWebMakerStyle.JQueryWebMakerCSS:
            return super.JQueryWebMakerCSS_RESSTR(tempClassName: tempClassName, indexStr: indexStr, proDict: proDict)
        case JQueryWebMakerStyle.JQueryWebMakerShow:
            return JQUERY_JS_CLASS_SHOW(CLASSNAME: tempClassName, COUNT: indexStr!)
        case JQueryWebMakerStyle.JQueryWebMakerShowAnimation:
            return JQUERY_JS_CLASS_SHOWA(CLASSNAME: tempClassName, COUNT: indexStr!, CONTEXT: context!)
        case JQueryWebMakerStyle.JQueryWebMakerShowWithFunction:
            return JQUERY_JS_CLASS_SHOWF(CLASSNAME: tempClassName, COUNT: indexStr!, ANIMATION: option!, FUNCTION: function!)
        case JQueryWebMakerStyle.JQueryWebMakerHidden:
            return JQUERY_JS_CLASS_HIDDEN(CLASSNAME: tempClassName, COUNT: indexStr!)
        case JQueryWebMakerStyle.JQueryWebMakerHeight:
            return JQUERY_JS_CLASS_HEIGHT(CLASSNAME: tempClassName, COUNT: indexStr!, HEIGHT: height)
        case JQueryWebMakerStyle.JQueryWebMakerWidth:
            return JQUERY_JS_CLASS_WIDTH(CLASSNAME: tempClassName, COUNT: indexStr!, WIDTH: width)
        case JQueryWebMakerStyle.JQueryWebTagMakerAddClass:
            return JQUERY_JS_CLASS_ADDCLASS(CLASSNAME: tempClassName, COUNT: indexStr!, CLASSNAMES: context!)
        case JQueryWebMakerStyle.JQueryWebTagMakerRemoveClass:
            return JQUERY_JS_CLASS_REMOVECLASS(CLASSNAME: tempClassName, COUNT: indexStr!, CLASSNAMES: context!)
        case JQueryWebMakerStyle.JQueryWebTagMakerAttrValue:
            return JQUERY_JS_CLASS_ATTRVALUE_FUNCTION(CLASSNAME: tempClassName, COUNT: indexStr!, ATTRNAME: function!, VALUE: option!)
        }
    }
}
