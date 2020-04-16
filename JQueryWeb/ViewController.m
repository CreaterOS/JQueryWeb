//
//  ViewController.m
//  JQueryWeb
//
//  Created by Bryant Reyn on 2020/4/15.
//  Copyright © 2020 Bryant Reyn. All rights reserved.
//

#import "ViewController.h"
#import "JQueryWebMacroJavaScript.h"
#import "JQueryWebMaker.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSString *str1 = JQueryWebMaker.JQuery(@"p").html(@"我是JQuery...");
    NSString *str2 = JQueryWebMaker.JQuery(@"p").htmlWithIndex(2,@"asf..");
    NSString *str3 = JQueryWebMaker.JQuery(@"p").on(@"click",@"function(){ alert('asdf...'); };");
    NSString *str4 = JQueryWebMaker.JQuery(@"p").onWithIndex(3,@"click",@"function(){ alert('asdf...'); }");
    
    NSLog(@"%@",str1);
    NSLog(@"%@",str2);
    NSLog(@"%@",str3);
    NSLog(@"%@",str4);
}


@end
