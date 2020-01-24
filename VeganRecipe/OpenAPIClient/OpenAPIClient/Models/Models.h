#import <Foundation/Foundation.h>
#import "OAIObject.h"

@class Temperatures;
@class ExtendedIngredient;
@class Measures;
@class Metric;
@class Nutrition;
@class CaloricBreakdown;
@class Ingredient;
@class IngredientNutrient;
@class NutritionNutrient;
@class WeightPerServing;
@class WinePairing;
@class ProductMatch;

NS_ASSUME_NONNULL_BEGIN

@interface Recipe : OAIObject

@property (nonatomic) NSInteger identifier;
@property (nonatomic) NSInteger weightWatcherSmartPoints;
@property (nonatomic) NSString *gaps;
@property (nonatomic) NSString *sourceURL;
@property (nonatomic) NSString *creditsText;
@property (nonatomic) NSURL *imageURL;
@property (nonatomic) NSInteger servings;
@property (nonatomic) Nutrition *nutrition;
@property (nonatomic) NSArray<NSString *> *cuisines;
@property (nonatomic) NSArray<NSString *> *dishTypes;
@property (nonatomic) NSString *imageType;
@property (nonatomic) NSString *instructions;
@property (nonatomic) NSInteger aggregateLikes;
@property (nonatomic) NSInteger readyInMinutes;
@property (nonatomic) NSArray *occasions;
@property (nonatomic) NSInteger healthScore;
@property (nonatomic) NSArray<ExtendedIngredient *> *extendedIngredients;
@property (nonatomic) NSArray *analyzedInstructions;
@property (nonatomic) NSString *sourceName;
@property (nonatomic) NSString *title;
@property (nonatomic) NSInteger spoonacularScore;
@property (nonatomic) NSURL *spoonacularSourceURL;
@property (nonatomic) NSArray<NSString *> *diets;
@property (nonatomic) double pricePerServing;
@property (nonatomic) WinePairing *winePairing;
@property (nonatomic) BOOL isGlutenFree;
@property (nonatomic) BOOL isVeryPopular;
@property (nonatomic) BOOL isVeryHealthy;
@property (nonatomic) BOOL isKetogenic;
@property (nonatomic) BOOL isDairyFree;
@property (nonatomic) BOOL isSustainable;
@property (nonatomic) BOOL isCheap;
@property (nonatomic) BOOL isVegan;
@property (nonatomic) BOOL isVegetarian;
@property (nonatomic) BOOL isWhole30;
@property (nonatomic) BOOL isLowFodmap;

@end

@interface ExtendedIngredient : OAIObject

@property (nonatomic) NSInteger identifier;
@property (nonatomic) NSString *originalName;
@property (nonatomic) NSString *unit;
@property (nonatomic) NSString *originalString;
@property (nonatomic) double amount;
@property (nonatomic) Measures *measures;
@property (nonatomic) NSString *original;
@property (nonatomic) NSString *consitency;
@property (nonatomic) NSString *image;
@property (nonatomic) NSArray<NSString *> *meta;
@property (nonatomic) NSString *aisle;
@property (nonatomic) NSArray<NSString *> *metaInformation;
@property (nonatomic) NSString *name;

@end

@interface Measures : OAIObject

@property (nonatomic) Metric *us;
@property (nonatomic) Metric *metric;

@end

@interface Metric : OAIObject

@property (nonatomic) double amount;
@property (nonatomic) NSString *unitShort;
@property (nonatomic) NSString *unitLong;

@end

@interface Nutrition : OAIObject

@property (nonatomic) CaloricBreakdown *caloricBreakdown;
@property (nonatomic) NSArray<NutritionNutrient *> *nutrients;
@property (nonatomic) NSArray<Ingredient *> *ingredients;
@property (nonatomic) WeightPerServing *weightPerServing;

@end

@interface CaloricBreakdown : OAIObject

@property (nonatomic) double percentCarbs;
@property (nonatomic) double percentFat;
@property (nonatomic) double percentProtein;

@end

@interface Ingredient : OAIObject

@property (nonatomic) double amount;
@property (nonatomic) NSArray<IngredientNutrient *> *nutrients;
@property (nonatomic) NSString *name;
@property (nonatomic) NSString *unit;

@end

@interface IngredientNutrient : OAIObject

@property (nonatomic) NSString *name;
@property (nonatomic) double amount;
@property (nonatomic) NSString *unit;

@end

@interface NutritionNutrient : OAIObject

@property (nonatomic) double amount;
@property (nonatomic) NSString *title;
@property (nonatomic) double percentOfDailyNeeds;
@property (nonatomic) NSString *unit;

@end

@interface WeightPerServing : OAIObject

@property (nonatomic) NSInteger amount;
@property (nonatomic) NSString *unit;

@end

@interface WinePairing : OAIObject

@property (nonatomic) NSString *pairingText;
@property (nonatomic) NSArray<ProductMatch *> *productMatches;
@property (nonatomic) NSArray<NSString *> *pairedWines;

@end

@interface ProductMatch : OAIObject

@property (nonatomic) double score;
@property (nonatomic) NSInteger identifier;
@property (nonatomic) NSString *price;
@property (nonatomic) NSString *title;
@property (nonatomic) NSString *imageURL;
@property (nonatomic) double averageRating;
@property (nonatomic) NSInteger ratingCount;
@property (nonatomic) NSString *theDescription;
@property (nonatomic) NSString *link;

@end

NS_ASSUME_NONNULL_END
