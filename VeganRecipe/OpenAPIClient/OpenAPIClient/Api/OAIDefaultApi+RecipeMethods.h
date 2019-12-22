#import <Foundation/Foundation.h>
#import "OAIDefaultApi.h"
@class RecipeModel;

NS_ASSUME_NONNULL_BEGIN

@interface OAIDefaultApi (RecipeMethods)

- (void)initialSearchComplexRecipe: (void (^)(NSArray<RecipeModel *> *recipes, NSError* error)) handler;

- (void)nextSearchComplexRecipe: (NSInteger) offset complitionHandler: (void (^)(NSArray<RecipeModel *> *recipes, NSError* error)) handler;

- (void)searchRecipesComplexWithRequest: (NSDictionary* )request complitionHandler: (void (^)(NSArray<RecipeModel *> *recipe, NSError* error)) handler;

- (void) fillFullRecipeInformational: (RecipeModel *) recipe complitionHandler: (void (^)(BOOL finish)) handler;

- (NSURLSessionDataTask *)downloadImageDataBy:(NSURL *) url
 downloadProgress:(void (^)(NSProgress *downloadProgress)) downloadProgressBlock
completionHandler:(void (^)(NSData * responseData, BOOL isCache,  NSError * error))completionHandler;

@end

NS_ASSUME_NONNULL_END
