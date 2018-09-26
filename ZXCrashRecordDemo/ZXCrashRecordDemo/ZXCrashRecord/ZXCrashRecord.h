//
//  ZXCrashRecord.h
//  ZXCrashRecord
//
//  Created by 李兆祥 on 2018/9/23.
//  Copyright © 2018年 李兆祥. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^kCrashEventHandler) (NSUInteger crashCount);
@interface ZXCrashRecord : NSObject
///获取或设置崩溃次数
@property(nonatomic,assign)NSUInteger crashCount;
+ (instancetype)shareInstance;
///获取崩溃次数
-(void)handleCrashCallBack:(kCrashEventHandler)_result;
///获取崩溃次数并设置失效时间 超过失效时间的次数将被清零
-(void)handleCrashWithExpireSec:(long)expireSec CallBack:(kCrashEventHandler)_result;
@end
