#import "IngredientModel.h"
#import "Measures.h"

@implementation IngredientModel

+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{ @"idIngredient": @"id", @"imageName": @"image", @"title": @"name", @"metric": @"metric", @"us": @"us"  }];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict error:(NSError **)err {
    [self mergeFromDictionary:dict useKeyMapping:true error:err];

    NSDictionary *measures = dict[@"measures"];
    [self mergeFromDictionary:measures useKeyMapping:true error:err];

    return self;
}

@end
