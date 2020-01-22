#import <Foundation/Foundation.h>
#import "OAIObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface CookTimeModel : OAIObject

@property (strong, nonatomic) NSNumber *inReady;
@property (strong, nonatomic) NSNumber *cooking;
@property (strong, nonatomic) NSNumber *preparetion;

- (instancetype)initWithDictionary:(NSDictionary *)dict error:(NSError **)err;

@end

NS_ASSUME_NONNULL_END
