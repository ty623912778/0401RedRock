//
//  ViewController.m
//  GCD非原子性
//
//  Created by mac on 16/4/3.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, copy) NSArray *someArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    dispatch_queue_t queue =  dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
         dispatch_async(queue, ^{
             for (int i=0; i<10000; i++) {
             }
             });
         dispatch_async(queue, ^{
                 NSLog(@"%@",[NSThread currentThread]);
             });
    
         NSLog(@"%@",[NSThread mainThread]);
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
