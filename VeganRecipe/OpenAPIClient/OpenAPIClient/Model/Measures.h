#import <Foundation/Foundation.h>
#import "OAIObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface Measures : OAIObject

@property (strong, nonatomic) NSNumber *amount;
@property (strong, nonatomic) NSString *unitShort;
@property (strong, nonatomic) NSString *unitLong;

- (instancetype)initWithDictionary:(NSDictionary *)dict error:(NSError **)err;

@end

NS_ASSUME_NONNULL_END
