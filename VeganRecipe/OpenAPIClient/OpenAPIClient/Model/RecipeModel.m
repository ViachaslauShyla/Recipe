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

@implementation RecipeModel

+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{ @"idRecipe": @"id", @"imageUrl": @"image", @"title": @"title", @"serving": @"serving", @"healthScore": @"healthScore", @"dishTypes": @"dishTypes" }];
}

// , @"ingredients":@"extendedIngredients", , @"steps": @"analyzedInstructions"
- (id)initWith:(NSDictionary *)data {
    self = [super init];
    if (self) {
        [self mergeFromDictionary:data useKeyMapping:true error:nil];
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dict error:(NSError **)err {
    self = [super init];
    if (self) {
        [self mergeFromDictionary:dict useKeyMapping:true error:nil];
    }
    return self;
}

- (void)fillFullRecipe:(NSDictionary *)data {
    [self mergeFromDictionary:data useKeyMapping:true error:nil];
    _ingredients = [IngredientModel arrayOfModelsFromDictionaries:data[@"extendedIngredients"] error:nil];
    _cookTime = [[CookTimeModel alloc] initWithDictionary:data error:nil];

    NSArray *analyzedInstructions = data[@"analyzedInstructions"];
    NSDictionary *dict = [analyzedInstructions firstObject];
    NSArray *steps = dict[@"steps"];
    _steps = [StepsModel arrayOfModelsFromDictionaries:steps error:nil];
}

@end
