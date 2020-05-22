//
//  ViewController.swift
//  JQueryWebSwift
//
//  Created by Bryant Reyn on 2020/5/16.
//  Copyright © 2020 Bryant Reyn. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print(JQUERY_JS_TAG_TEXT_VAL(TAGNAME: "p", COUNT: "0", CONTEXT: "d"))
        print(JQUERY_JS_TAG_HTML(TAGNAME: "p", COUNT: "0", CONTEXT: "d"))
        print(JQUERY_JS_TAG_ON(TAGNAME: "p", COUNT: "1", OPTION: "Click", FUNCTION: "dasfasd"))

        print(ALLTAG)

        print(JQueryWebMaker.init(tagName: "p").text(context: "JSJSJS..."))
         print(JQueryWebMaker.init(tagName: "p").text(index: 10, context: "JSJSJS..."))
        print(JQueryWebMaker.init(tagName: "p").html(context: "dsfasdfa..."))
        print(JQueryWebMaker.init(tagName: "p").html(index: 10, context: "dsfdsafweewe...."))
        print(JQueryWebMaker.init(tagName: "p").val(context: "dsfasdfa..."))
        print(JQueryWebMaker.init(tagName: "p").val(index: 10, context: "dsfdsafweewe...."))
        
        print(JQueryWebMaker.init(idName: "#id").text(context:"asdf..."))
        print(JQueryWebMaker.init(idName: "#id").html(context:"asdf..."))
        print(JQueryWebMaker.init(idName: "#id").val(context:"asdf..."))
        
        print(JQueryWebMaker.init(className: ".asdf").html(context: "asdddddf..."))
        print(JQueryWebMaker.init(className: ".sadfsdf").html(index: 10, context: "sdddd..."))
        
        print(JQueryWebMaker.init(tagName: "p").on(option: "click", function: "function(){alert('asdf...');}"))
        print(JQueryWebMaker.init(tagName: "p").on(index: 10, option: "click", function: "function(){alert('asdf...');}"))
        for resStr : String in JQueryWebMaker.init(tagName: "p").on(options: "click","blur", function: "function(){ alert('asdf...'); }") {
            print(resStr)
        }
        
        for resStr : String in JQueryWebMaker.init(tagName: "p").on(index: 10,options: "click","blur", function: "function(){ alert('dasdfasdf...'); }") {
            print(resStr)
        }
        
        for resStr : String in JQueryWebMaker.init(tagName: "p").on(index: 10, input: "click:function(){ alert('asdf..'); }","blur:function(){ alert('dassdfasdf...'); }") {
            print(resStr)
        }
        
        
        print( JQueryWebMaker.init(tagName: "button").onBlur(index: 0, function: "adsf..."))
        
        print( JQueryWebMaker.init(idName: "#button").onBlur(index: 10, function: "adsf..."))
        
        print( JQueryWebMaker.init(className: ".button").onBlur(index: 10, function: "adsf..."))
        
        for resStr : String in JQueryWebMaker.init(tagName: "button").css(properties: "font:asdf...,button:asdfdd...,p:sasdf...") {
            print(resStr)
        }
        
        for resStr : String in JQueryWebMaker.init(idName: "#ddd").css(properties: "font:asdf...,button:asdfdd...,p:sasdf...") {
            print(resStr)
        }
        
        for resStr : String in JQueryWebMaker.init(className: ".sss").css(properties: "font:asdf...,button:asdfdd...,p:sasdf...") {
            print(resStr)
        }

        print(JQueryWebMaker.init(tagName: "p").css(key: "ddd", value: "eee..."))
        print(JQueryWebMaker.init(idName: "#ppp").css(key: "ddd", value: "eee..."))
        print(JQueryWebMaker.init(className: ".ddd").css(key: "ddd", value: "eee..."))
        print()
        print(JQueryWebMaker.init(tagName: "p").show())
        print(JQueryWebMaker.init(idName: "#ppp").show())
        print(JQueryWebMaker.init(className: ".ddd").show())
        print()
        print(JQueryWebMaker.init(tagName: "p").show(index: 10))
        print(JQueryWebMaker.init(idName: "#ppp").show(index: 10))
        print(JQueryWebMaker.init(className: ".ddd").show(index: 10))
        print()
        print(JQueryWebMaker.init(tagName: "p").show(animation: "fast"))
        print(JQueryWebMaker.init(idName: "#ppp").show(animation: "fast"))
        print(JQueryWebMaker.init(className: ".ddd").show(animation: "fast"))
        print()
        print(JQueryWebMaker.init(tagName: "p").show(index: 10, animation: "fast"))
        print(JQueryWebMaker.init(className: ".ddd").show(index: 10, animation: "fast"))
        print()
        print(JQueryWebMaker.init(tagName: "p").show(animation: "fast", function: "function(){ alert('ddd...'); }"))
        print(JQueryWebMaker.init(idName: "#ppp").show(animation: "fast", function: "function(){ alert('ddd...'); }"))
        print(JQueryWebMaker.init(className: ".ddd").show(animation: "fast", function: "function(){ alert('ddd...'); }"))
        print()
        print(JQueryWebMaker.init(tagName: "p").show(index: 10, animation: "fast", function: "function(){ alert('ddd...'); }"))
        print(JQueryWebMaker.init(idName: "#ppp").show(index: 10, animation: "fast", function: "function(){ alert('ddd...'); }"))
        print(JQueryWebMaker.init(className: ".ddd").show(index: 10, animation: "fast", function: "function(){ alert('ddd...'); }"))
        print()
        print(JQueryWebMaker.init(tagName: "p").hidden())
        print(JQueryWebMaker.init(idName: "#ppp").hidden())
        print(JQueryWebMaker.init(className: ".ddd").hidden())
        print()
        print(JQueryWebMaker.init(tagName: "p").hidden(index: 10))
        print(JQueryWebMaker.init(idName: "#ppp").hidden(index: 10))
        print(JQueryWebMaker.init(className: ".ddd").hidden(index: 10))
        print()
        
        print(JQueryWebMaker.init(tagName: "p").height(heightPX: 20))
        print(JQueryWebMaker.init(idName: "#ppp").height(heightPX: 20))
        print(JQueryWebMaker.init(className: ".ddd").height(heightPX: 20))
        print()
        print(JQueryWebMaker.init(tagName: "p").height(index: 10, heightPX: 20))
        print(JQueryWebMaker.init(className: ".ddd").height(index: 10, heightPX: 20))
        print()
        print(JQueryWebMaker.init(tagName: "p").addClass(index: 10, className: "ddd"))
        print(JQueryWebMaker.init(idName: "#ppp").addClass(index: 10, className: "ddd"))
        print(JQueryWebMaker.init(className: ".ddd").addClass(index: 10, className: "ddd"))
        print()
        print(JQueryWebMaker.init(tagName: "p").removeClass(index: 10, className: "ddd"))
        print(JQueryWebMaker.init(idName: "#ppp").removeClass(index: 10, className: "ddd"))
        print(JQueryWebMaker.init(className: ".ddd").removeClass(index: 10, className: "ddd"))
        
    }

    
}

