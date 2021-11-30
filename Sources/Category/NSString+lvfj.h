//
//  NSString+Architecture.h
//  ArchitectureBase
//
//  Created by lvfeijun on 2021/7/14.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    EnumTimeFormatTypess,
    EnumTimeFormatTypemmss,
    EnumTimeFormatTypeHHmmss,
    EnumTimeFormatTypeHHmmssAuto,
    EnumTimeFormatTypeddHHmmss,
} EnumTimeFormatType;

@interface NSString (lvfj)

+ (NSString *)hq_argetString:(id)string;
//是否空字符，不去空格
+ (BOOL)lvfj_isEmptyString:(id)string;
//是否空字符，去空格
+ (BOOL)hq_isEmptyString:(NSString *)str;
+ (NSString *)hq_aremptyStringReplaceNSNull:(id)string;
+ (NSString *)hq_arzeroReplayEmptyString:(id)string;
//
+ (NSString *)hq_timeFormtString:(CGFloat)time type:(EnumTimeFormatType)type;

#pragma mark regex
- (NSString *)hqar_replaceRegex:(NSString *)regex withString:(NSString *)string;
- (NSString *)hqar_replaceArrayRegex:(NSArray *)arrayRegex withString:(NSString *)string;

@end

NS_ASSUME_NONNULL_END
