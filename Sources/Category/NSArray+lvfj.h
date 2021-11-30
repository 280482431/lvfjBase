//
//  NSArray+Architecture.h
//  DesignSDK
//
//  Created by lvfeijun on 2021/8/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray (lvfj)

+ (BOOL)lvfj_isEmptyArray:(NSArray *)array;
+ (NSArray *)lvfj_emptyArrayReplaceEmpty:(NSArray *)array;

@end

NS_ASSUME_NONNULL_END
