//
//  StepsModel.h
//  OpenAPIClient
//
//  Created by Slava on 10/15/19.
//

#import <Foundation/Foundation.h>

@class EquipmentModel;
@class IngredientModel;

NS_ASSUME_NONNULL_BEGIN

@interface StepsModel : NSObject

@property(strong, nonatomic) NSNumber *number;
@property(strong, nonatomic) NSString *text;
@property(strong, nonatomic) NSArray<EquipmentModel *> *equipments;
@property(strong, nonatomic) NSArray<IngredientModel *> *ingredients;

-(id) initWithResultRequest:(NSDictionary *)result;
- (void)setDataIntoModel: (NSDictionary *)data;

@end

NS_ASSUME_NONNULL_END
