//
//  JQueryWebTagMaker.swift
//  JQueryWebSwift
//
//  Created by Bryant Reyn on 2020/5/17.
//  Copyright © 2020 Bryant Reyn. All rights reserved.
//

/**
 * 用于解析标签
 */

import Foundation

class JQueryWebTagMaker: JQueryWebMaker {
    
    /* 解析文本内容标签 */
    func parseTextTagNameWithSelect(index : NSInteger,context : String?,option : String?,function : String?,proDict : NSMutableDictionary?,height : NSInteger,width : NSInteger,selectStr : JQueryWebMakerStyle) -> String {
        let indexStr : String?
        if index > 0 {
            indexStr = String.init(format: "%zd", index)
        }else{
            indexStr = String.init(format: "%zd", 0)
        }
        
        
        let tempTagName : String = super.tagName!
        
        switch selectStr {
        case JQueryWebMakerStyle.JQueryWebMakerTextORVal:
            
            return JQUERY_JS_TAG_TEXT_VAL(TAGNAME:tempTagName , COUNT: indexStr!, CONTEXT: context!)
        case JQueryWebMakerStyle.JQueryWebMakerHTML:
            return JQUERY_JS_TAG_HTML(TAGNAME: tempTagName, COUNT: indexStr!, CONTEXT: context!)
        case JQueryWebMakerStyle.JQueryWebMakerON:
            return JQUERY_JS_TAG_ON(TAGNAME: tempTagName, COUNT: indexStr!, OPTION: option!, FUNCTION: function!)
        case JQueryWebMakerStyle.JQueryWebMakerCSS:
            return super.JQueryWebMakerCSS_RESSTR(tempTAGName: tempTagName, indexStr: indexStr, proDict: proDict)
        case JQueryWebMakerStyle.JQueryWebMakerShow:
            return JQUERY_JS_TAG_SHOW(TAGNAME: tempTagName, COUNT: indexStr!)
        case JQueryWebMakerStyle.JQueryWebMakerShowAnimation:
            return JQUERY_JS_TAG_SHOWA(TAGNAME: tempTagName, COUNT: indexStr!, CONTEXT: context!)
        case JQueryWebMakerStyle.JQueryWebMakerShowWithFunction:
            return JQUERY_JS_TAG_SHOWF(TAGNAME: tempTagName, COUNT: indexStr!, ANIMATION: option!, FUNCTION: function!)
        case JQueryWebMakerStyle.JQueryWebMakerHidden:
            return JQUERY_JS_TAG_HIDDEN(TAGNAME: tempTagName, COUNT: indexStr!)
        case JQueryWebMakerStyle.JQueryWebMakerHeight:
            return JQUERY_JS_TAG_HEIGHT(TAGNAME: tempTagName, COUNT: indexStr!, HEIGHT: height)
        case JQueryWebMakerStyle.JQueryWebMakerWidth:
            return JQUERY_JS_TAG_WIDTH(TAGNAME: tempTagName, COUNT: indexStr!, WIDTH: width)
        case JQueryWebMakerStyle.JQueryWebTagMakerAddClass:
            return JQUERY_JS_TAG_ADDCLASS(TAGNAME: tempTagName, COUNT: indexStr!, CLASSNAME: context!)
        case JQueryWebMakerStyle.JQueryWebTagMakerRemoveClass:
            return JQUERY_JS_TAG_REMOVECLASS(TAGNAME: tempTagName, COUNT: indexStr!, CLASSNAME: context!)
        case JQueryWebMakerStyle.JQueryWebTagMakerAttrValue:
            return JQUERY_JS_TAG_ATTRVALUE_FUNCTION(TAGNAME: tempTagName, COUNT: indexStr!, ATTRNAME: function!, VALUE: option!)
        }
    }
    
    
}
