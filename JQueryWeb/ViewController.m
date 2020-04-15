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
    NSString *str1 = JQueryWebMaker.JQuery(@"p").val(@"我是JQuery...");
    NSString *str2 = JQueryWebMaker.JQuery(@"p").valWithIndex(2,@"asf..");
    
    NSLog(@"%@",str1);
    NSLog(@"%@",str2);
    
}


@end
