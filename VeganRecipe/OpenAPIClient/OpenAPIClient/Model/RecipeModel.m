//
//  RecipeModel.m
//  OpenAPIClient
//
//  Created by Slava on 10/15/19.
//

#import "RecipeModel.h"
#import "StepsModel.h"
#import "IngredientModel.h"
#import "CookTimeModel.h"
#import "OAIDefaultApi.h"
#import "NutritionModel.h"

@interface RecipeModel()

@property(strong, nonatomic) OAIDefaultApi *api;

@end


@implementation RecipeModel

-(id) initWithResultRequest: (NSDictionary *)result {

    self = [super init];
    if (self) {
        _api = [[OAIDefaultApi alloc] init];
        _steps = [NSArray array];
        _ingredients = [NSArray array];
        _recipeImage = [[UIImage alloc] init];
        [self setInitialDataIntoModel:result];
    }

    return self;
}

- (void)setImage:(UIImage *)recipeImage {
    self.recipeImage = recipeImage;
}

- (void)setInitialDataIntoModel: (NSDictionary *)data {

    if ((NSNumber *)data[@"id"]) {
        _idRecipe = data[@"id"];
    }

    if ((NSString *)data[@"image"]) {
        _imageUrl = data[@"image"];
    }

    if ((NSString *)data[@"title"]) {
        _title = data[@"title"];
    }
}

- (void)fillFullData: (NSDictionary *)data {
    
    if ((NSArray<NSDictionary *> *)data[@"steps"]) {
        NSMutableArray *tempArray = [NSMutableArray array];
        for (NSDictionary *result in data[@"steps"]) {
            StepsModel *step = [[StepsModel alloc] initWithResultRequest:result];
            [tempArray addObject:step];
        }
        self.steps = [NSArray arrayWithArray:tempArray];
    }

    if ((NSArray<NSDictionary *> *)data[@"extendedIngredients"]) {
        NSMutableArray *tempArray = [NSMutableArray array];
        for (NSDictionary *result in data[@"extendedIngredients"]) {
            IngredientModel *ingredient = [[IngredientModel alloc] initWithResultRequest:result];
            [tempArray addObject:ingredient];
        }
        self.ingredients = [NSArray arrayWithArray:tempArray];
    }

    self.cookTime = [[CookTimeModel alloc] initWithResultRequest:data];
    self.serving = (NSNumber *)data[@"servings"];
    self.dishTypes = [NSArray arrayWithArray:(NSArray *)data[@"dishTypes"]];
    self.healthScore = (NSNumber *)data[@"healthScore"];

    // Getting Nutrition
    [self.api getRecipeNutritionByIDWithId:self.idRecipe completionHandler:^(NSObject *output, NSError *error) {
        if ((NSDictionary *)output) {
            self.nutrition = [[NutritionModel alloc] initWithResultRequest:(NSDictionary *)output];
        }
    }];
}

@end
