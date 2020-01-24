#import "Models.h"

@implementation Recipe

+ (JSONKeyMapper *)keyMapper {
    NSDictionary<NSString *, NSString *> *properties = @{
        @"isVeryHealthy" : @"veryHealthy",
        @"isGlutenFree" : @"glutenFree",
        @"identifier" : @"id",
        @"isVeryPopular" : @"veryPopular",
        @"isKetogenic" : @"ketogenic",
        @"sourceURL" : @"sourceUrl",
        @"isDairyFree" : @"dairyFree",
        @"imageURL" : @"image",
        @"isSustainable" : @"sustainable",
        @"isCheap" : @"cheap",
        @"isVegan" : @"vegan",
        @"isVegetarian" : @"vegetarian",
        @"isWhole30" : @"whole30",
        @"isLowFodmap" : @"lowFodmap",
        @"spoonacularSourceURL" : @"spoonacularSourceUrl",
    };
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:properties];
}

@end

@implementation ExtendedIngredient

+ (JSONKeyMapper *)keyMapper {
    NSDictionary<NSString *, NSString *> *properties = @{
        @"identifier" : @"id",
    };
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:properties];
}

@end

@implementation Measures

@end

@implementation Metric

@end

@implementation Nutrition

@end

@implementation CaloricBreakdown

@end

@implementation Ingredient

@end

@implementation IngredientNutrient

@end

@implementation NutritionNutrient

@end

@implementation WeightPerServing

@end

@implementation WinePairing

@end

@implementation ProductMatch

+ (JSONKeyMapper *)keyMapper {
    NSDictionary<NSString *, NSString *> *properties = @{
        @"identifier" : @"id",
        @"imageURL" : @"imageUrl",
        @"theDescription" : @"description",
    };
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:properties];
}

@end
