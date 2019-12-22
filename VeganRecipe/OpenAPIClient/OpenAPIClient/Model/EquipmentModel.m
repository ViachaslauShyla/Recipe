#import "EquipmentModel.h"

@implementation EquipmentModel

+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{ @"idEquipment": @"id", @"imageName":@"image", @"title":@"name" }];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict error:(NSError **)err {
    [self mergeFromDictionary:dict useKeyMapping:dict error:err];

    return self;
}


@end
