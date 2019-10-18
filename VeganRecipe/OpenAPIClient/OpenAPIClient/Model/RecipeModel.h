//
//  RecipeModel.h
//  OpenAPIClient
//
//  Created by Slava on 10/15/19.
//

#import <Foundation/Foundation.h>

@class StepsModel;
@class IngredientModel;
@class CookTimeModel;
@class NutritionModel;


NS_ASSUME_NONNULL_BEGIN

@interface RecipeModel : NSObject

@property(strong, nonatomic) NSNumber *idRecipe;
@property(strong, nonatomic) NSString *imageUrl;
@property(strong, nonatomic) NSString *title;
@property(strong, nonatomic) NSArray<StepsModel *> *steps;
@property(strong, nonatomic) NSArray<IngredientModel *> *ingredients;
@property(strong, nonatomic) CookTimeModel *cookTime;
@property(strong, nonatomic) NSNumber *serving;
@property(strong, nonatomic) NSArray<NSString *> *dishTypes;
@property(strong, nonatomic) NSNumber *healthScore;
@property(strong, nonatomic) NutritionModel *nutrition;

- (id) initWithResultRequest: (NSDictionary *) result;
- (void)setInitialDataIntoModel: (NSDictionary *)data;
- (void)fillFullData: (NSDictionary *)data;

@end

NS_ASSUME_NONNULL_END
