#import <Foundation/Foundation.h>
#import "OAIObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface EquipmentModel : OAIObject

@property (strong, nonatomic) NSNumber *idEquipment;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *imageName;

- (instancetype)initWithDictionary:(NSDictionary *)dict error:(NSError **)err;

@end

NS_ASSUME_NONNULL_END
