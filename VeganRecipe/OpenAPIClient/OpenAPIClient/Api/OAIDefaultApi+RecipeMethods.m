
#import "OAIDefaultApi+RecipeMethods.h"
#import "OAIDefaultApi.h"
#import "OAIApiClient.h"
#import "CoreDataManager.h"

@implementation OAIDefaultApi (RecipeMethods)

- (void)loadRecipes:(NSInteger)offset completionHandler:(void (^)(NSArray<Recipe *> *_Nonnull recipes, NSError *_Nullable error))handler {
    NSDictionary *request = @{ @"sort": @"popularity",
                               @"diet": @"Vegan",
                               @"offset": @(offset) };
    [self searchRecipesComplexWithRequest:request completionHandler:handler];
}

- (NSURLSessionDataTask *)downloadImageFrom:(NSURL *)url progress:(nullable void (^)(NSProgress *progress))progressHandler completion:(void (^)(UIImage * _Nonnull image, BOOL isFromCache, NSError * _Nullable error))completionHandler {
    NSData *cachedData = [CoreDataManager.shared imageDataForUrl:url.absoluteString];
    UIImage *cachedImage = [UIImage imageWithData:cachedData] ?: [UIImage new];
    NSURLSessionDataTask *task =
        [self.apiClient dataTaskWithRequest:[NSURLRequest requestWithURL:url]
                             uploadProgress:nil
                           downloadProgress:progressHandler
                          completionHandler:^(NSURLResponse *_Nonnull response, id _Nullable responseObject, NSError *_Nullable error) {
        [CoreDataManager.shared saveImageDataFor:url.absoluteString data:responseObject];
        UIImage *img = [UIImage imageWithData:(NSData *)response] ?: [UIImage new];
        completionHandler(img, NO, error);
    }];

    if (cachedData) {
        completionHandler(cachedImage, YES, nil);
    } else {
        [task resume];
    }

    return task;
}

- (void)searchRecipesComplexWithRequest:(NSDictionary *)request completionHandler:(void (^)(NSArray<Recipe *> *_Nonnull recipes, NSError *_Nullable error))handler {
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
                      completionHandler:^(NSObject *output, NSError *error) {
        if (!handler) {
            return;
        }
        if (error) {
            handler(@[], error);
            return;
        }

        error = [NSError errorWithDomain:NSURLErrorDomain
                                    code:-1
                                userInfo:@{ NSLocalizedDescriptionKey: @"Responce is not a valid object. Aborting." }];
        if (![output isKindOfClass:NSDictionary.class]) {
            handler(@[], error);
            return;
        }

        NSDictionary *od = (NSDictionary *)output;
        NSMutableArray<NSNumber *> *recipesIDsList = [NSMutableArray new];
        if ([od[@"results"] isKindOfClass:NSArray.class]) {
            NSArray<NSDictionary *> *recipesDicts = od[@"results"];
            for (NSDictionary *recipe in recipesDicts) {
                BOOL isNotADict = ![recipe isKindOfClass:NSDictionary.class];
                BOOL isMissedId = isNotADict ? YES : !recipe[@"id"];
                if (isNotADict || isMissedId) {
                    handler(@[], error);
                    return;
                }

                [recipesIDsList addObject:recipe[@"id"]];
            }
        }

        [self getRecipeInformationBulkWithIds:[recipesIDsList componentsJoinedByString:@","]
                             includeNutrition:@(YES)
                            completionHandler:^(NSObject *output, NSError *e) {
            NSMutableArray<Recipe *> *recepisList = [Recipe arrayOfModelsFromDictionaries:(NSArray *)output error:&e];
            if (e) {
                handler(@[], e);
                return;
            }

            handler(recepisList, nil);
        }];
    }];
}

@end
