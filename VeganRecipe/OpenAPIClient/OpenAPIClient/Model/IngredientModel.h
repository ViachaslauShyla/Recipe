//
//  IngredientModel.h
//  OpenAPIClient
//
//  Created by Slava on 10/16/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface IngredientModel : NSObject

typedef struct { NSNumber *amount; NSString *unitShort; } Measures;

@property(strong, nonatomic) NSNumber *idIngredient;
@property(strong, nonatomic) NSString *title;
@property(strong, nonatomic) NSString *imageName;
@property(unsafe_unretained, nonatomic) Measures metric;
@property(unsafe_unretained, nonatomic) Measures us;

-(id) initWithResultRequest: (NSDictionary *)result;
- (void)setDataIntoModel: (NSDictionary *)data;

@end

NS_ASSUME_NONNULL_END
