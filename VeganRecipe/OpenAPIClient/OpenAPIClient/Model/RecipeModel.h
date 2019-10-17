//
//  RecipeModel.h
//  OpenAPIClient
//
//  Created by Slava on 10/15/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RecipeModel : NSObject

@property(strong, nonatomic) NSNumber* idRecipe;
@property(strong, nonatomic) NSString* imageUrl;
@property(strong, nonatomic) NSString* title;

- (id) initWithResultRequest: (NSDictionary *) result;
- (void)setDataIntoModel: (NSDictionary *)data;

@end

NS_ASSUME_NONNULL_END
