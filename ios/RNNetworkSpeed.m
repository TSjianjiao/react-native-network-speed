
#import "RNNetworkSpeed.h"
#import "./NSObject+CheckNetWorkBytes.h"
@implementation RNNetworkSpeed {
    NSTimer *timer;
}

- (dispatch_queue_t)methodQueue
{
    return dispatch_get_main_queue();
}

RCT_EXPORT_MODULE();

#pragma mark - react方法

RCT_EXPORT_METHOD(findEvents:(RCTResponseSenderBlock)callback) {
    NSArray *events = @[@1, @"test"];
    callback(@[[NSNull null], events]);
};

RCT_EXPORT_METHOD(startListenNetworkSpeed) {
    if(timer == nil) {
        timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(getNetworkTraffic) userInfo:nil repeats:true];
        [NSObject initCheck];
        [timer fireDate];
    }
}

RCT_EXPORT_METHOD(stopListenNetworkSpeed) {
    if(timer) {
        [timer invalidate];
        timer = nil;
    }
}

#pragma mark - 实例方法

- (void)getNetworkTraffic {
    NSDictionary *netWorkSpeed = [NSObject getNetworkSpeed]; //获取当前秒流量
    [self sendEventWithName:@"onSpeedUpdate" body:netWorkSpeed];
    NSLog(@"下载速度%@",[netWorkSpeed valueForKey: @"downLoadSpeed"]);
    NSLog(@"上传速度%@",[netWorkSpeed valueForKey: @"upLoadSpeed"]);
}

#pragma mark - 消息发送
- (NSArray<NSString *> *)supportedEvents {
    return @[@"onSpeedUpdate"];
}

@end
  
