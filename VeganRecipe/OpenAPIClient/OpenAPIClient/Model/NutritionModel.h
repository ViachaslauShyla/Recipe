//
//  NutritionModel.h
//  OpenAPIClient
//
//  Created by Slava on 10/16/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NutritionModel : NSObject

@property(strong, nonatomic) NSString *calories;
@property(strong, nonatomic) NSString *carbs;
@property(strong, nonatomic) NSString *fat;
@property(strong, nonatomic) NSString *protein;

-(id) initWithResultRequest: (NSDictionary *)result;
- (void)setDataIntoModel: (NSDictionary *)data;

@end

NS_ASSUME_NONNULL_END
