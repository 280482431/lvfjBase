//
//  HQArBaseModel.m
//  ArchitectureBase
//
//  Created by lvfeijun on 2021/9/25.
//

#import "lvfjBaseModel.h"
#import "NSArray+Architecture.h"
#import "MJExtension.h"

@implementation lvfjBaseModel
+ (NSArray *)getPageArray:(NSDictionary *)data key:(NSString *)key
{
    if ([data isKindOfClass:NSDictionary.class]&&![NSArray hq_isEmptyArray:data[key]]) {
        return data[key];
    } else {
        return nil;
    }
}
+ (NSArray *)getPageModel:(NSDictionary *)data  key:(NSString *)key
{
    NSArray *array = [self getPageArray:data key:key];
    if (array) {
        return [self mj_objectArrayWithKeyValuesArray:array];
    } else {
        return nil;
    }
}
@end
