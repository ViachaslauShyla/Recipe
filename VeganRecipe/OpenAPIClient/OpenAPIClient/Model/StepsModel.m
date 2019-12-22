#import "StepsModel.h"
#import "EquipmentModel.h"
#import "IngredientModel.h"

@implementation StepsModel

+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{ @"number": @"number", @"text":@"step" }];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict error:(NSError **)err {
    [self mergeFromDictionary:dict useKeyMapping:true error:err];
    _ingredients = [IngredientModel arrayOfModelsFromDictionaries:dict[@"ingredients"] error:nil];
    _equipments = [EquipmentModel arrayOfModelsFromDictionaries:dict[@"equipment"] error:nil];
    
    return self;
}

@end

