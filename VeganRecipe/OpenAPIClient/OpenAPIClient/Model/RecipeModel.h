#import <Foundation/Foundation.h>
#import "OAIObject.h"

@class StepsModel;
@class IngredientModel;
@class CookTimeModel;
@class NutritionModel;

NS_ASSUME_NONNULL_BEGIN

@interface RecipeModel : OAIObject

@property (strong, nonatomic) NSNumber *idRecipe;
@property (strong, nonatomic) NSURL *imageUrl;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSArray<StepsModel *> *steps;
@property (strong, nonatomic) NSArray<IngredientModel *> *ingredients;
@property (strong, nonatomic) CookTimeModel *cookTime;
@property (strong, nonatomic) NSNumber *serving;
@property (strong, nonatomic) NSArray<NSString *> *dishTypes;
@property (strong, nonatomic) NSNumber *healthScore;
@property (strong, nonatomic) NutritionModel *nutrition;

- (id)initWith:(NSDictionary *)data;
- (instancetype)initWithDictionary:(NSDictionary *)dict error:(NSError **)err;
- (void)fillFullRecipe:(NSDictionary *)data;

@end

NS_ASSUME_NONNULL_END
