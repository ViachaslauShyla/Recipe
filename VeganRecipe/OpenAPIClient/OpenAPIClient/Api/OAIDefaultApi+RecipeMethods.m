
#import "OAIDefaultApi+RecipeMethods.h"
#import "OAIDefaultApi.h"
#import "OAIApiClient.h"
#import "CoreDataManager.h"
#import "RecipeModel.h"


@implementation OAIDefaultApi (RecipeMethods)

- (void)initialSearchComplexRecipe: (void (^)(NSArray<RecipeModel *> *recipes, NSError* error)) handler {
    NSDictionary* request = @{@"sort": @"popularity",
                              @"diet": @"Gluten Free",
                              @"offset": [NSNumber numberWithInteger:0]};
    [self searchRecipesComplexWithRequest:request complitionHandler:handler];
}

- (void)nextSearchComplexRecipe: (NSInteger) offset complitionHandler: (void (^)(NSArray<RecipeModel *> *recipes, NSError* error)) handler {
    NSDictionary* request = @{@"sort": @"popularity",
                              @"diet": @"Gluten Free",
                              @"offset": [NSNumber numberWithInteger:offset]};
    [self searchRecipesComplexWithRequest:request complitionHandler:handler];
}

- (void) fillFullRecipeInformational: (RecipeModel *) recipe complitionHandler: (void (^)(BOOL finish)) handler {
    [self getRecipeInformationWithId:recipe.idRecipe includeNutrition:[NSNumber numberWithBool:NO] completionHandler:^(NSObject *output, NSError *error) {

        [recipe fillFullRecipe:(NSDictionary *)output];
        
    }];
}


- (NSURLSessionDataTask *)downloadImageDataBy:(NSURL *) url
                             downloadProgress:(void (^)(NSProgress *downloadProgress)) downloadProgressBlock
                            completionHandler:(void (^)(NSData * _Nullable responseData, BOOL isCache,  NSError * _Nullable error)) completionHandler {

    NSURLSessionDataTask *task = nil;

    NSData *imageData = [CoreDataManager.shared imageDataForUrl: [NSString stringWithFormat:@"%@",url]];
    if (imageData) {
        completionHandler(imageData, YES, nil);
    } else {

        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        task = [self.apiClient dataTaskWithRequest:request
                                    uploadProgress:nil
                                  downloadProgress:downloadProgressBlock
                                 completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {

            [CoreDataManager.shared saveImageDataFor:[NSString stringWithFormat:@"%@",url] data:responseObject];
            completionHandler(responseObject, NO, error);
        }];
        [task resume];
    }
    return task;
}

- (void)searchRecipesComplexWithRequest: (NSDictionary* )request complitionHandler: (void (^)(NSArray<RecipeModel *> *recipes, NSError* error)) handler {

    [self searchRecipesComplexWithQuery:@"query"
                                cuisine:request[@"cuisine"]
                         excludeCuisine:request[@"excludeCuisine"]
                                   diet:request[@"diet"]
                           intolerances:request[@"intolerances"]
                              equipment:request[@"equipment"]
                     includeIngredients:request[@"includeIngredients"]
                     excludeIngredients:request[@"excludeIngredients"]
                                   type:request[@"type"]
                   instructionsRequired:request[@"instructionsRequired"]
                        fillIngredients:request[@"fillIngredients"]
                   addRecipeInformation:request[@"addRecipeInformation"]
                                 author:request[@"author"]
                                   tags:request[@"tags"]
                             titleMatch:request[@"titleMatch"]
                                   sort:request[@"sort"]
                          sortDirection:request[@"sortDirection"]
                               minCarbs:request[@"minCarbs"]
                               maxCarbs:request[@"maxCarbs"]
                             minProtein:request[@"minProtein"]
                             maxProtein:request[@"maxProtein"]
                            minCalories:request[@"minCalories"]
                            maxCalories:request[@"maxCalories"]
                                 minFat:request[@"minFat"]
                                 maxFat:request[@"maxFat"]
                             minAlcohol:request[@"minAlcohol"]
                             maxAlcohol:request[@"maxAlcohol"]
                            minCaffeine:request[@"minCaffeine"]
                            maxCaffeine:request[@"maxCaffeine"]
                              minCopper:request[@"minCopper"]
                              maxCopper:request[@"maxCopper"]
                             minCalcium:request[@"minCalcium"]
                             maxCalcium:request[@"maxCalcium"]
                             minCholine:request[@"minCholine"]
                             maxCholine:request[@"maxCholine"]
                         minCholesterol:request[@"minCholesterol"]
                         maxCholesterol:request[@"maxCholesterol"]
                            minFluoride:request[@"minFluoride"]
                            maxFluoride:request[@"maxFluoride"]
                        minSaturatedFat:request[@"minSaturatedFat"]
                        maxSaturatedFat:request[@"maxSaturatedFat"]
                            minVitaminA:request[@"minVitaminA"]
                            maxVitaminA:request[@"maxVitaminA"]
                            minVitaminC:request[@"minVitaminC"]
                            maxVitaminC:request[@"maxVitaminC"]
                            minVitaminD:request[@"minVitaminD"]
                            maxVitaminD:request[@"maxVitaminD"]
                            minVitaminE:request[@"minVitaminE"]
                            maxVitaminE:request[@"maxVitaminE"]
                            minVitaminK:request[@"minVitaminK"]
                            maxVitaminK:request[@"maxVitaminK"]
                           minVitaminB1:request[@"minVitaminB1"]
                           maxVitaminB1:request[@"maxVitaminB1"]
                           minVitaminB2:request[@"minVitaminB2"]
                           maxVitaminB2:request[@"maxVitaminB2"]
                           minVitaminB5:request[@"minVitaminB5"]
                           maxVitaminB5:request[@"maxVitaminB5"]
                           minVitaminB3:request[@"minVitaminB3"]
                           maxVitaminB3:request[@"maxVitaminB3"]
                           minVitaminB6:request[@"minVitaminB6"]
                           maxVitaminB6:request[@"maxVitaminB6"]
                          minVitaminB12:request[@"minVitaminB12"]
                          maxVitaminB12:request[@"maxVitaminB12"]
                               minFiber:request[@"minFiber"]
                               maxFiber:request[@"maxFiber"]
                              minFolate:request[@"minFolate"]
                              maxFolate:request[@"maxFolate"]
                           minFolicAcid:request[@"minFolicAcid"]
                           maxFolicAcid:request[@"maxFolicAcid"]
                              minIodine:request[@"minIodine"]
                              maxIodine:request[@"maxIodine"]
                                minIron:request[@"minIron"]
                                maxIron:request[@"maxIron"]
                           minMagnesium:request[@"minMagnesium"]
                           maxMagnesium:request[@"maxMagnesium"]
                           minManganese:request[@"minManganese"]
                           maxManganese:request[@"maxManganese"]
                          minPhosphorus:request[@"minPhosphorus"]
                          maxPhosphorus:request[@"maxPhosphorus"]
                           minPotassium:request[@"minPotassium"]
                           maxPotassium:request[@"maxPotassium"]
                            minSelenium:request[@"minSelenium"]
                            maxSelenium:request[@"maxSelenium"]
                              minSodium:request[@"minSodium"]
                              maxSodium:request[@"maxSodium"]
                               minSugar:request[@"minSugar"]
                               maxSugar:request[@"maxSugar"]
                                minZinc:request[@"minZinc"]
                                maxZinc:request[@"maxZinc"]
                                 offset:request[@"offset"]
                                 number:request[@"number"]
                           limitLicense:request[@"limitLicense"]
                      completionHandler:^(NSObject* output, NSError *error) {
        if (error) {
            handler(nil, error);
        } else {
            if ([output isKindOfClass:[NSArray<RecipeModel *> class]]) {
                handler((NSArray<RecipeModel *> *)output, nil);
            }
        }
    }];
}

@end
