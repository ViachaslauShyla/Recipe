#import <Foundation/Foundation.h>
#import "OAIObject.h"

@class EquipmentModel;
@class IngredientModel;

NS_ASSUME_NONNULL_BEGIN

@interface StepsModel : OAIObject

@property(strong, nonatomic) NSNumber *number;
@property(strong, nonatomic) NSString *text;
@property(strong, nonatomic) NSArray<EquipmentModel *> *equipments;
@property(strong, nonatomic) NSArray<IngredientModel *> *ingredients;

- (instancetype)initWithDictionary:(NSDictionary *)dict error:(NSError **)err;

@end

NS_ASSUME_NONNULL_END
