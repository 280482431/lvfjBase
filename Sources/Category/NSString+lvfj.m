//
//  NSString+Architecture.m
//  ArchitectureBase
//
//  Created by lvfeijun on 2021/7/14.
//

#import "NSString+lvfj.h"
#import "NSArray+lvfj.h"

@implementation NSString (lvfj)

#pragma mark nil
+ (NSString *)hq_argetString:(id)string
{
    return [NSString stringWithFormat:@"%@",string];
}
+ (BOOL)lvfj_isEmptyString:(id)string
{
    return ![string isKindOfClass:[NSString class]] || [(NSString *)string length]==0;
}

+ (NSString *)hq_aremptyStringReplaceNSNull:(id)string
{
    if ([self hq_arisEmptyString:string]) {
        return @"";
    } else {
        return string;
    }
}
+ (NSString *)hq_arzeroReplayEmptyString:(id)string
{
    if ([self hq_arisEmptyString:string]) {
        return @"0";
    } else {
        return string;
    }
}
+ (BOOL)hq_isEmptyString:(NSString *)str
{
    if (![self hq_arisEmptyString:str]) {
        NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        return  [str stringByTrimmingCharactersInSet:set].length<1;
    }
    return YES;
}
#pragma mark time
+ (NSString *)hq_timeFormtString:(CGFloat)padding type:(EnumTimeFormatType)type
{
    if (type==EnumTimeFormatTypess) {
        return [NSString stringWithFormat:@"%02d",padding];
    } else if (type==EnumTimeFormatTypeHHmmss||type==EnumTimeFormatTypeHHmmssAuto) {
        int hours = ((int)padding)/3600;
        int minutes = ((int)padding)%3600/60;
        int seconds = ((int)padding)%3600%60;
        if (type==EnumTimeFormatTypeHHmmssAuto) {
            if (hours<1) {
                return [NSString stringWithFormat:@"%02d:%02d",minutes,seconds];
            }
        }
        return [NSString stringWithFormat:@"%02d:%02d:%02d",hours,minutes,seconds];
    }
    else if (type==EnumTimeFormatTypeddHHmmss) {
        int days = ((int)padding)/(3600*24);
        int hours = ((int)padding)%(3600*24)/3600;
        int minutes = ((int)padding)%(3600*24)%3600/60;
        int seconds = ((int)padding)%(3600*24)%3600%60;
        return [NSString stringWithFormat:@"%d天 %02d:%02d:%02d",days,hours,minutes,seconds];
    }
    return @"0";
}
#pragma mark regex
- (NSString *)hqar_replaceRegex:(NSString *)regex withString:(NSString *)string
{
    return [self hqar_replaceArrayRegex:@[regex] withString:string];
}
- (NSString *)hqar_replaceArrayRegex:(NSArray *)arrayRegex withString:(NSString *)string
{
    if ([NSString lvfj_isEmptyString:self]||[NSArray lvfj_isEmptyString:arrayRegex]) {
        return @"";
    }
    
    NSString *resultsString = self.mutableCopy;
    for (NSString * regex in arrayRegex) {
        
        if ([NSString lvfj_isEmptyString:resultsString]) {
            return @"";
        } else if ([NSString lvfj_isEmptyString:regex]) {
            break;
        }
        NSRegularExpression *regext = [NSRegularExpression regularExpressionWithPattern:regex options:NSRegularExpressionCaseInsensitive error:nil];
        if (regext) {
            resultsString =[regext stringByReplacingMatchesInString:resultsString options:NSMatchingReportProgress range:NSMakeRange(0, resultsString.length) withTemplate:@""];
        }
    }
    
    return [resultsString copy];
}
@end
