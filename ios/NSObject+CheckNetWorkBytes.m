//
//  NSObject+CheckNetWorkBytes.m
//  DoubleConversion
//
//  Created by Mac on 2019/8/20.
//

#import "NSObject+CheckNetWorkBytes.h"
#import <arpa/inet.h>
#import <net/if.h>
#import <ifaddrs.h>
#import <net/if_dl.h>

uint64_t _lastBytes_total;
uint64_t _lastBytes_upload;
uint64_t _lastBytes_download;

long _lastDownLoadTimeStamp = 0;
long _lastUpLoadTimeStamp = 0;

@implementation NSObject (CheckNetWorkBytes)

+ (void )initCheck {
    _lastBytes_total = 0;
    _lastBytes_upload = 0;
    _lastBytes_download = 0;
}

+ (NSDictionary *)getNetworkSpeed {
    NSDictionary *netInfo = [NSObject getGprsWifiFlowIOBytes];
    
    NSString *uploadBytesStr = [netInfo valueForKey:@"uploadBytes"];
    NSString *downloadBytesStr = [netInfo valueForKey:@"downloadBytes"];
//    NSString *totalBytesStr = [netInfo valueForKey:@"totalBytes"];
    
    long long uploadBytes = [self getUploadBytes:uploadBytesStr];
    long long downloadBytes = [self getDownloadBytes:downloadBytesStr];
//    long long totalBytes = [self getTotalBytes:totalBytesStr];
    
    NSString *uploadSpeedStr = [self convertStringWithbyte:uploadBytes];
    NSString *downloadSpeedStr = [self convertStringWithbyte:downloadBytes];
//    NSString *totalSpeedStr = [self convertStringWithbyte:totalBytes];
    
    NSDictionary *speed = @{
                                @"downLoadSpeed": downloadSpeedStr,
                                @"upLoadSpeed": uploadSpeedStr,
                                @"downLoadSpeedCurrent": @"0",
                                @"upLoadSpeedCurrent": @"0"
                            };
    return speed;
}

// 上传速率
+ (long long )getUploadBytes:(NSString *)uploadBytes {
    long currentBytes = 0;
    long currentTimeStamp = [self getNowTimeTimestamp];
    
    if ( _lastBytes_upload > 0) {
        currentBytes = ([uploadBytes longLongValue] - _lastBytes_upload) / (currentTimeStamp - _lastUpLoadTimeStamp) * 1000;
    }
    _lastBytes_upload = [uploadBytes longLongValue];
    
    _lastUpLoadTimeStamp = currentTimeStamp;
//    NSLog(@"upload%ld", _lastUpLoadTimeStamp);
    return currentBytes;
}

// 下载速率
+ (long long )getDownloadBytes:(NSString *)downloadBytes {
    long currentBytes = 0;
    long currentTimeStamp = [self getNowTimeTimestamp];
    
    if ( _lastBytes_download > 0) {
        currentBytes = ([downloadBytes longLongValue] - _lastBytes_download) / (currentTimeStamp - _lastDownLoadTimeStamp) * 1000;
    }
    
    _lastBytes_download = [downloadBytes longLongValue];
    _lastDownLoadTimeStamp = currentTimeStamp;
//    NSLog(@"download%ld", _lastDownLoadTimeStamp);
    return currentBytes;
}

// 上下之和
+ (long long )getTotalBytes:(NSString *)totalBytes {
    long currentBytes = 0;
    if ( _lastBytes_total > 0) {
        currentBytes = [totalBytes longLongValue] - _lastBytes_total;
    }
    _lastBytes_total = [totalBytes longLongValue];
    return currentBytes;
}


/*获取网络流量信息*/
+ (NSDictionary *)getGprsWifiFlowIOBytes{
    struct ifaddrs *ifa_list = 0, *ifa;
    if (getifaddrs(&ifa_list) == -1) {
        return 0;
    }
    uint64_t iBytes = 0;
    uint64_t oBytes = 0;
    for (ifa = ifa_list; ifa; ifa = ifa->ifa_next) {
        if (AF_LINK != ifa->ifa_addr->sa_family)
            continue;
        if (!(ifa->ifa_flags & IFF_UP) && !(ifa->ifa_flags & IFF_RUNNING))
            continue;
        if (ifa->ifa_data == 0)
            continue;
        //Wifi
        if (strncmp(ifa->ifa_name, "lo", 2)) {
            struct if_data *if_data = (struct if_data *)ifa->ifa_data;
            iBytes += if_data->ifi_ibytes;
            oBytes += if_data->ifi_obytes;
        }
        //3G或者GPRS
        if (!strcmp(ifa->ifa_name, "pdp_ip0")){
            struct if_data *if_data = (struct if_data *)ifa->ifa_data;
            iBytes += if_data->ifi_ibytes;
            oBytes += if_data->ifi_obytes;
        }
    }
    freeifaddrs(ifa_list);
    NSDictionary *bytesInfo = @{
                                    @"totalBytes": [NSString stringWithFormat:@"%llu", iBytes + oBytes],
                                    @"uploadBytes": [NSString stringWithFormat:@"%llu", oBytes],
                                    @"downloadBytes": [NSString stringWithFormat:@"%llu", iBytes],
                                };
    return bytesInfo;
}

//将bytes单位转换
+ (NSString *)convertStringWithbyte:(long)bytes{
//    if(bytes < 1024){ // B
//        return [NSString stringWithFormat:@"%ldB", bytes];
//    }else if(bytes >= 1024 && bytes < 1024 * 1024){// KB
//        return [NSString stringWithFormat:@"%.1fKB", (double)bytes / 1024];
//    }else if(bytes >= 1024 * 1024 && bytes < 1024 * 1024 * 1024){// MB
//        return [NSString stringWithFormat:@"%.2fMB", (double)bytes / (1024 * 1024)];
//    }else{ // GB
//        return [NSString stringWithFormat:@"%.3fGB", (double)bytes / (1024 * 1024 * 1024)];
//    }
    return [NSString stringWithFormat:@"%.1f", (double)bytes / 1024];
}

// 获取当前时间戳
+ (long)getNowTimeTimestamp{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss SSS"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    //设置时区,这个对于时间的处理有时很重要
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    
    [formatter setTimeZone:timeZone];
    
    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    
    long timeStamp =  (long)[datenow timeIntervalSince1970]*1000;
    
    return timeStamp;
}
@end

