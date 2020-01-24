#import <UIKit/UIKit.h>
#import "OAIDefaultApi.h"
#import "Models.h"

NS_ASSUME_NONNULL_BEGIN

@interface OAIDefaultApi (RecipeMethods)

- (void)loadRecipes:(NSInteger)offset completionHandler:(void (^)(NSArray<Recipe *> * _Nonnull recipes, NSError * _Nullable error))handler;

- (NSURLSessionDataTask *)downloadImageFrom:(NSURL *)url
                                   progress:(nullable void (^)(NSProgress *progress))progressHandler
                                 completion:(void (^)(UIImage * _Nonnull image, BOOL isFromCache, NSError * _Nullable error))completionHandler;

@end

NS_ASSUME_NONNULL_END
