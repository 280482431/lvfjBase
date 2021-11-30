//
//  HQArBaseModel.h
//  ArchitectureBase
//
//  Created by lvfeijun on 2021/9/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define kRecordsKey @"records"

@interface lvfjBaseModel : NSObject

@property (nonatomic, assign) CGFloat arHeight;

+ (NSArray *)getPageArray:(NSDictionary *)data key:(NSString *)key;
+ (NSArray *)getPageModel:(NSDictionary *)data  key:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
