//
//  JQueryWebMacroJavaScript.swift
//  JQueryWebSwift
//
//  Created by Bryant Reyn on 2020/5/16.
//  Copyright © 2020 Bryant Reyn. All rights reserved.
//

import Foundation

/* ----------------------------- TAGNAME -----------------------------*/
/* JavaScript标签文本内容 */
func JQUERY_JS_TAG_TEXT_VAL(TAGNAME : String,COUNT : String,CONTEXT : String) -> String {
    return String.localizedStringWithFormat("document.getElementsByTagName('%@')[%@].innerText = '%@'",TAGNAME,COUNT,CONTEXT)
}
/* JavaScript标签文本HTML格式 */
func JQUERY_JS_TAG_HTML(TAGNAME : String,COUNT : String,CONTEXT : String) -> String {
    return String.localizedStringWithFormat("document.getElementsByTagName('%@')[%@].innerHTML = '%@'", TAGNAME,COUNT,CONTEXT)
}
/* JavaScript标签ON操作 */
func JQUERY_JS_TAG_ON(TAGNAME : String,COUNT : String,OPTION : String,FUNCTION : String) -> String {
    return String.localizedStringWithFormat("document.getElementsByTagName('%@')[%@].on%@ = %@", TAGNAME,COUNT,OPTION,FUNCTION)
}
/* JavaScript标签CSS操作 */
func JQUERY_JS_TAG_CSS(TAGNAME : String,COUNT : String,KEY : String,VALUE : String) -> String {
    return String.localizedStringWithFormat("document.getElementsByTagName('%@')[%@].style.%@ = '%@'", TAGNAME,COUNT,KEY,VALUE)
}
/* JavaScript标签SHOW操作 */
func JQUERY_JS_TAG_SHOW(TAGNAME : String,COUNT : String) -> String {
    return String.localizedStringWithFormat("document.getElementsByTagName('%@')[%@].show = true", TAGNAME,COUNT)
}
func JQUERY_JS_TAG_SHOWF(TAGNAME : String,COUNT : String,ANIMATION : String,FUNCTION : String) -> String {
    return String.localizedStringWithFormat("document.getElementsByTagName('%@')[%@].show('%@') = %@", TAGNAME,COUNT,ANIMATION,FUNCTION)
}
func JQUERY_JS_TAG_SHOWA(TAGNAME : String,COUNT : String,CONTEXT : String) -> String {
    return String.localizedStringWithFormat("document.getElementsByTagName('%@')[%@].show('%@')", TAGNAME,COUNT,CONTEXT)
}
/* JavaScript标签Hidden操作 */
func JQUERY_JS_TAG_HIDDEN(TAGNAME : String,COUNT : String) -> String {
    return String.localizedStringWithFormat("document.getElementsByTagName('%@')[%@].hidden = true", TAGNAME,COUNT)
}
/* JavaScript标签Height操作 */
func JQUERY_JS_TAG_HEIGHT(TAGNAME : String,COUNT : String,HEIGHT : NSInteger) -> String {
    return String.localizedStringWithFormat("document.getElementsByTagName('%@')[%@].style.height = '%zdpx'", TAGNAME,COUNT,HEIGHT)
}
/* JavaScript标签Width操作 */
func JQUERY_JS_TAG_WIDTH(TAGNAME : String,COUNT : String,WIDTH : NSInteger) -> String {
    return String.localizedStringWithFormat("document.getElementsByTagName('%@')[%@].style.width = '%zdpx'", TAGNAME,COUNT,WIDTH)
}
/* JavaScript标签AddClass操作 */
func JQUERY_JS_TAG_ADDCLASS(TAGNAME : String,COUNT : String,CLASSNAME : String) -> String {
    return String.localizedStringWithFormat("document.getElementsByTagName('%@')[%@].classList.add('%@')", TAGNAME,COUNT,CLASSNAME)
}
/* JavaScript标签RemoveClass操作 */
func JQUERY_JS_TAG_REMOVECLASS(TAGNAME : String,COUNT : String,CLASSNAME : String) -> String {
    return String.localizedStringWithFormat("document.getElementsByTagName('%@')[%@].classList.remove('%@')", TAGNAME,COUNT,CLASSNAME)
}
/* JavaScript标签Attr操作 */
func JQUERY_JS_TAG_ATTRVALUE_FUNCTION(TAGNAME : String,COUNT : String,ATTRNAME : String,VALUE : String) -> String {
    return String.localizedStringWithFormat("document.getElementsByTagName('%@')[%@].setAttribute('%@','%@')", TAGNAME,COUNT,ATTRNAME,VALUE)
}
/* ----------------------------- IDNAME -----------------------------*/
/* JavaScript标签文本内容 */
func JQUERY_JS_ID_TEXT_VAL(IDNAME : String,CONTEXT : String) -> String {
    return String.localizedStringWithFormat("document.getElementById('%@').innerText = '%@'", IDNAME,CONTEXT)
}
/* JavaScript标签文本HTML格式 */
func JQUERY_JS_ID_HTML(IDNAME : String,CONTEXT : String) -> String {
    return String.localizedStringWithFormat("document.getElementById('%@').innerHTML = '%@'", IDNAME,CONTEXT)
}
/* JavaScript标签ON操作 */
func JQUERY_JS_ID_ON(IDNAME : String,OPTION : String,FUNCTION : String) -> String {
    return String.localizedStringWithFormat("document.getElementById('%@').on%@ = %@", IDNAME,OPTION,FUNCTION)
}
/* JavaScript标签CSS操作 */
func JQUERY_JS_ID_CSS(IDNAME : String,KEY : String,VALUE : String) -> String {
    return String.localizedStringWithFormat("document.getElementById('%@').style.%@ = '%@'", IDNAME,KEY,VALUE)
}
/* JavaScript标签SHOW操作 */
func JQUERY_JS_ID_SHOW(IDNAME : String) -> String {
    return String.localizedStringWithFormat("document.getElementById('%@').show = true;", IDNAME)
}
func JQUERY_JS_ID_SHOWF(IDNAME : String,ANIMATION : String,FUNCTION : String) -> String {
    return String.localizedStringWithFormat("document.getElementById('%@').show('%@') = %@", IDNAME,ANIMATION,FUNCTION)
}
func JQUERY_JS_ID_SHOWA(IDNAME : String,CONTEXT : String) -> String {
    return String.localizedStringWithFormat("document.getElementById('%@').show('%@')", IDNAME,CONTEXT)
}
/* JavaScript标签Hidden操作 */
func JQUERY_JS_ID_HIDDEN(IDNAME : String) -> String {
    return String.localizedStringWithFormat("document.getElementById('%@').hidden = true", IDNAME)
}
/* JavaScript标签Height操作 */
func JQUERY_JS_ID_HEIGHT(IDNAME : String,HEIGHT : NSInteger) -> String {
    return String.localizedStringWithFormat("document.getElementById('%@').style.height = '%zdpx'", IDNAME,HEIGHT)
}
/* JavaScript标签Width操作 */
func JQUERY_JS_ID_WIDTH(IDNAME : String,WIDTH : NSInteger) -> String {
    return String.localizedStringWithFormat("document.getElementById('%@').style.width = '%zdpx'", IDNAME,WIDTH)
}
/* JavaScript标签AddClass操作 */
func JQUERY_JS_ID_ADDCLASS(IDNAME : String,CLASSNAME : String) -> String {
    return String.localizedStringWithFormat("document.getElementById('%@').classList.add('%@')", IDNAME,CLASSNAME)
}
/* JavaScript标签RemoveClass操作 */
func JQUERY_JS_ID_REMOVECLASS(IDNAME : String,CLASSNAME : String) -> String {
    return String.localizedStringWithFormat("document.getElementById('%@').classList.remove('%@')", IDNAME,CLASSNAME)
}
/* JavaScript标签Attr操作 */
func JQUERY_JS_ID_ATTRVALUE_FUNCTION(IDNAME : String,ATTRNAME : String,VALUE : String) -> String {
    return String.localizedStringWithFormat("document.getElementById('%@').setAttribute('%@','%@')", IDNAME,ATTRNAME,VALUE)
}
/* ----------------------------- CLASSNAME -----------------------------*/
/* JavaScript标签文本内容 */
func JQUERY_JS_CLASS_TEXT_VAL(CLASSNAME : String,COUNT : String,CONTEXT : String) -> String {
    return String.localizedStringWithFormat("document.getElementsByClassName('%@')[%@].innerText = '%@'", CLASSNAME,COUNT,CONTEXT)
}
/* JavaScript标签文本HTML格式 */
func JQUERY_JS_CLASS_HTML(CLASSNAME : String,COUNT : String,CONTEXT : String) -> String {
    return String.localizedStringWithFormat("document.getElementsByClassName('%@')[%@].innerHTML = '%@'", CLASSNAME,COUNT,CONTEXT)
}
/* JavaScript标签ON操作 */
func JQUERY_JS_CLASS_ON(CLASSNAME : String,COUNT : String,OPTION : String,FUNCTION : String) -> String {
    return String.localizedStringWithFormat("document.getElementsByClassName('%@')[%@].on%@ = %@", CLASSNAME,COUNT,OPTION,FUNCTION)
}
/* JavaScript标签CSS操作 */
func JQUERY_JS_CLASS_CSS(CLASSNAME : String,COUNT : String,KEY : String,VALUE : String) -> String {
    return String.localizedStringWithFormat("document.getElementsByClassName('%@')[%@].style.%@ = '%@'", CLASSNAME,COUNT,KEY,VALUE)
}
/* JavaScript标签SHOW操作 */
func JQUERY_JS_CLASS_SHOW(CLASSNAME : String,COUNT : String) -> String {
    return String.localizedStringWithFormat("document.getElementsByClassName('%@')[%@].show = true", CLASSNAME,COUNT)
}
func JQUERY_JS_CLASS_SHOWF(CLASSNAME : String,COUNT : String,ANIMATION : String,FUNCTION : String) -> String {
    return String.localizedStringWithFormat("document.getElementsByClassName('%@')[%@].show('%@') = %@", CLASSNAME,COUNT,ANIMATION,FUNCTION)
}
func JQUERY_JS_CLASS_SHOWA(CLASSNAME : String,COUNT : String,CONTEXT : String) -> String {
    return String.localizedStringWithFormat("document.getElementsByClassName('%@')[%@].show('%@')", CLASSNAME,COUNT,CONTEXT)
}
/* JavaScript标签Hidden操作 */
func JQUERY_JS_CLASS_HIDDEN(CLASSNAME : String,COUNT : String) -> String {
    return String.localizedStringWithFormat("document.getElementsByClassName('%@')[%@].hidden = true", CLASSNAME,COUNT)
}
///* JavaScript标签Height操作 */
func JQUERY_JS_CLASS_HEIGHT(CLASSNAME : String,COUNT : String,HEIGHT : NSInteger) -> String {
    return String.localizedStringWithFormat("document.getElementsByClassName('%@')[%@].style.height = '%zdpx'", CLASSNAME,COUNT,HEIGHT)
}
/* JavaScript标签Width操作 */
func JQUERY_JS_CLASS_WIDTH(CLASSNAME : String,COUNT : String,WIDTH : NSInteger) -> String {
    return String.localizedStringWithFormat("document.getElementsByClassName('%@')[%@].style.width = '%zdpx'", CLASSNAME,COUNT,WIDTH)
}
/* JavaScript标签AddClass操作 */
func JQUERY_JS_CLASS_ADDCLASS(CLASSNAME : String,COUNT : String,CLASSNAMES : String) -> String {
    return String.localizedStringWithFormat("document.getElementsByClassName('%@')[%@].classList.add('%@')", CLASSNAME,COUNT,CLASSNAMES)
}
/* JavaScript标签RemoveClass操作 */
func JQUERY_JS_CLASS_REMOVECLASS(CLASSNAME : String,COUNT : String,CLASSNAMES : String) -> String {
    return String.localizedStringWithFormat("document.getElementsByClassName('%@')[%@].classList.remove('%@')", CLASSNAME,COUNT,CLASSNAMES)
}
/* JavaScript标签Attr操作 */
func JQUERY_JS_CLASS_ATTRVALUE_FUNCTION(CLASSNAME : String,COUNT : String,ATTRNAME : String,VALUE : String) -> String {
    return String.localizedStringWithFormat("document.getElementsByClassName('%@')[%@].setAttribute('%@','%@')", CLASSNAME,COUNT,ATTRNAME,VALUE)
}
