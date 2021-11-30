//
//  NSArray+Architecture.m
//  DesignSDK
//
//  Created by lvfeijun on 2021/8/18.
//

#import "NSArray+lvfj.h"

@implementation NSArray (lvfj)
+ (BOOL)lvfj_isEmptyArray:(NSArray *)array
{
    return ![array isKindOfClass:NSArray.class]||array.count<1;
}
+ (NSArray *)lvfj_emptyArrayReplaceEmpty:(NSArray *)array
{
    if (![self lvfj_isEmptyArray:array]) {
        return array;
    } else {
        return @[];
    }
}
@end
