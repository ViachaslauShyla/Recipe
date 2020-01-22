#import <Foundation/Foundation.h>
#import "OAIObject.h"

@class Measures;

NS_ASSUME_NONNULL_BEGIN

@interface IngredientModel : OAIObject

@property (strong, nonatomic) NSNumber *idIngredient;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *imageName;
@property (unsafe_unretained, nonatomic) Measures *metric;
@property (unsafe_unretained, nonatomic) Measures *us;

- (instancetype)initWithDictionary:(NSDictionary *)dict error:(NSError **)err;

@end

NS_ASSUME_NONNULL_END
