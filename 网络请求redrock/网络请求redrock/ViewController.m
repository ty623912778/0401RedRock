//
//  ViewController.h
//  网络请求redrock
//
//  Created by mac on 16/4/1.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<NSURLSessionDataDelegate>
@property(nonatomic,strong)NSMutableData *mutableData;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)session_blockButtonDidClicked:(id)sender {
    dispatch_queue_t network_queue;
    network_queue = dispatch_queue_create("com.myapp.network", nil);

    dispatch_async(network_queue, ^{
    
    NSString *baseString = @"http://stackoverflow.com/questions/32655340/difference-between-nsurlsession-on-ios-8-and-ios-9";
    //转化为URL
    NSURL *baseURL = [NSURL URLWithString:baseString];
    
    //根据 baseURL 创建网络请求对象
    NSMutableURLRequest *requset = [NSMutableURLRequest requestWithURL:baseURL];
    //设置参数：1.POST 2.参数体（body）
    [requset setHTTPMethod:@"POST"];
    //2.body参数
    NSString *bodyString = @"date=20131129&startRecord=1&len=5&udid=1234567890&terminalType=Iphone&cid=213";
    NSData *badyData = [bodyString dataUsingEncoding:NSUTF8StringEncoding];
    //设置 body（POST参数）
    [requset setHTTPBody:badyData];
    
    //iOS 9 NSURLSession 代替  NSURLConnection
    //创建NSURLSession 对象（如果要使用block来完成网络请求，这个对象可以使用 NSURLSession 自带的单例对象）
    NSURLSession *session = [NSURLSession sharedSession];
    
    // session发送网络请求对象
    
    NSURLSessionTask *task = [session dataTaskWithRequest:requset completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
       
        
    }];
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [task resume];
            //开始网络请求任务


            
        });
        
        
        
    } );
    
}

//代理 实现网络请求
- (IBAction)session_delegateButtonDidClicked:(id)sender {
    
    NSString *baseString = @"http://www.baidu.com/s?wd=nsurlsession%20ios9&pn=10&oq=nsurlsession%20ios9&tn=84053098_dg&ie=utf-8&f=3&rsv_pq=cf759ad000011691&rsv_t=1641%2B9NEQTHbvgjDgPdKexZJ7xu%2Fx2P%2BzRipoFhfxRsZ3h4uh%2FAeduDbs3wTCnqwIhg&rsv_page=1";
    NSURL *baseURL = [NSURL URLWithString:baseString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:baseURL];
    
    [request setHTTPMethod:@"POST"];
    NSString *bodyString = @"date=20131129&startRecord=1&len=5&udid=1234567890&terminalType=Iphone&cid=213";
    NSData *bodyData = [bodyString dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:bodyData];
    
    //创建 session
    //默认的 session 配置，从网络读取数据
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    //需要遵守 NSURLSessionDataDelegate
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];
    
    //利用 session 发送网络请求
    NSURLSessionTask *task = [session dataTaskWithRequest:request];
    
    
    //初始化接收数据的容器
    self.mutableData = [NSMutableData data];
    
    //开始任务
    [task resume];
    
    
}

//#pragma mark 1.收到服务器相应
//-(void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler {
//
//    NSLog(@"1");
//
//}




//服务器开始传输数据（一点一点返回，这个代理方法会被反复调用，返回 NSData 数据）
-(void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data {
    
    NSLog(@"2");
    [self.mutableData appendData:data];
    
}
//客户端接收数据完成的时候
-(void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask willCacheResponse:(NSCachedURLResponse *)proposedResponse completionHandler:(void (^)(NSCachedURLResponse * _Nullable))completionHandler {
    
    NSLog(@"3");
    
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:self.mutableData options:NSJSONReadingMutableContainers error:nil];
    NSLog(@"%@",dict);
}








- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end