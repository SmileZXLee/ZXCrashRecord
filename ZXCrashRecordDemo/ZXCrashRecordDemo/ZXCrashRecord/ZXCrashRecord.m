//
//  ZXCrashRecord.m
//  ZXCrashRecord
//
//  Created by 李兆祥 on 2018/9/23.
//  Copyright © 2018年 李兆祥. All rights reserved.
//

#import "ZXCrashRecord.h"
#import <UIKit/UIKit.h>
#define  USERDEFAULT [NSUserDefaults standardUserDefaults]
#define CRASHFLAG @"CrashFlag"
#define CRASHCOUNT @"CrashCount"
#define CRASHTIME @"CrashTime"
@implementation ZXCrashRecord
+ (instancetype)shareInstance{
    static ZXCrashRecord * s_instance_dj_singleton = nil ;
    if (s_instance_dj_singleton == nil) {
        s_instance_dj_singleton = [[ZXCrashRecord alloc] init];
    }
    return (ZXCrashRecord *)s_instance_dj_singleton;
}
-(void)handleCrashCallBack:(kCrashEventHandler)_result{
    [self handleCrashWithExpireSec:0 CallBack:_result];
}
-(void)handleCrashWithExpireSec:(long)expireSec CallBack:(kCrashEventHandler)_result{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appEnterBackground) name:UIApplicationDidEnterBackgroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appEnterForeground) name:UIApplicationWillEnterForegroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appDidFinishLaunching) name:UIApplicationDidFinishLaunchingNotification object:nil];
    NSNumber *countNum = [USERDEFAULT objectForKey:CRASHCOUNT];
    NSUInteger ccount = [countNum integerValue];
    if([USERDEFAULT boolForKey:CRASHFLAG]){
        if(expireSec && [USERDEFAULT objectForKey:CRASHTIME] && [self getTimeStamp] - [[USERDEFAULT objectForKey:CRASHTIME] doubleValue] >= expireSec){
            ccount = 0;
        }
        ccount ++;
        [USERDEFAULT setObject:[NSNumber numberWithInteger:ccount] forKey:CRASHCOUNT];
        [USERDEFAULT setObject:[NSNumber numberWithDouble:[self getTimeStamp]] forKey:CRASHTIME];
        [USERDEFAULT synchronize];
    }
    !_result ? : _result(ccount);
    [USERDEFAULT setBool:YES forKey:CRASHFLAG];
}

#pragma mark - getter and setter
-(void)setCrashCount:(NSUInteger)crashCount{
    [USERDEFAULT setObject:[NSNumber numberWithInteger:crashCount] forKey:CRASHCOUNT];
}

-(NSUInteger)crashCount{
    return [[USERDEFAULT objectForKey:CRASHCOUNT] integerValue];
}

#pragma mark - lifeCircle
-(void)appEnterBackground{
    [USERDEFAULT setBool:NO forKey:CRASHFLAG];
}
-(void)appEnterForeground{
    [USERDEFAULT setBool:YES forKey:CRASHFLAG];
}
-(void)appDidFinishLaunching{
    
}
#pragma mark - Private
-(NSTimeInterval)getTimeStamp{
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:[NSDate date]];
    NSDate *localeDate = [[NSDate date]  dateByAddingTimeInterval: interval];
    return [localeDate timeIntervalSince1970];
}
@end
