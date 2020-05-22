//
//  JQueryWebIDMaker.swift
//  JQueryWebSwift
//
//  Created by Bryant Reyn on 2020/5/17.
//  Copyright © 2020 Bryant Reyn. All rights reserved.
//

import Foundation

class JQueryWebIDMaker: JQueryWebMaker {
    func parseTextIDNameWithSelect(context : String?,option : String?,funtion : String?,proDict : NSMutableDictionary?,height : NSInteger,width : NSInteger,selectStr : JQueryWebMakerStyle) -> String {
        var tempIdName : String = super.idName!
        tempIdName = (tempIdName as NSString).substring(from: 1)
        
        switch selectStr {
        case JQueryWebMakerStyle.JQueryWebMakerTextORVal:
            return JQUERY_JS_ID_TEXT_VAL(IDNAME: tempIdName, CONTEXT: context!)
        case JQueryWebMakerStyle.JQueryWebMakerHTML:
            return JQUERY_JS_ID_HTML(IDNAME: tempIdName, CONTEXT: context!)
        case JQueryWebMakerStyle.JQueryWebMakerON:
            return JQUERY_JS_ID_ON(IDNAME: tempIdName, OPTION: option!, FUNCTION: funtion!)
        case JQueryWebMakerStyle.JQueryWebMakerCSS:
            return super.JQueryWebMakerCSS_RESSTR(tempIDName: tempIdName, indexStr: nil, proDict: proDict)
        case JQueryWebMakerStyle.JQueryWebMakerShow:
            return JQUERY_JS_ID_SHOW(IDNAME: tempIdName)
        case JQueryWebMakerStyle.JQueryWebMakerShowAnimation:
            return JQUERY_JS_ID_SHOWA(IDNAME: tempIdName, CONTEXT: context!)
        case JQueryWebMakerStyle.JQueryWebMakerShowWithFunction:
            return JQUERY_JS_ID_SHOWF(IDNAME: tempIdName, ANIMATION: option!, FUNCTION: funtion!)
        case JQueryWebMakerStyle.JQueryWebMakerHidden:
            return JQUERY_JS_ID_HIDDEN(IDNAME: tempIdName)
        case JQueryWebMakerStyle.JQueryWebMakerHeight:
            return JQUERY_JS_ID_HEIGHT(IDNAME: tempIdName, HEIGHT: height)
        case JQueryWebMakerStyle.JQueryWebMakerWidth:
            return JQUERY_JS_ID_WIDTH(IDNAME: tempIdName, WIDTH: width)
        case JQueryWebMakerStyle.JQueryWebTagMakerAddClass:
            return JQUERY_JS_ID_ADDCLASS(IDNAME: tempIdName, CLASSNAME: context!)
        case JQueryWebMakerStyle.JQueryWebTagMakerRemoveClass:
            return JQUERY_JS_ID_REMOVECLASS(IDNAME: tempIdName, CLASSNAME: context!)
        case JQueryWebMakerStyle.JQueryWebTagMakerAttrValue:
            return JQUERY_JS_ID_ATTRVALUE_FUNCTION(IDNAME: tempIdName, ATTRNAME: funtion!, VALUE: option!)
        }
    }
}
