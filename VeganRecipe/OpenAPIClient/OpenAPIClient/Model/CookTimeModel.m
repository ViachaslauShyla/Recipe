#import "CookTimeModel.h"

@implementation CookTimeModel

+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{ @"inReady": @"readyInMinutes", @"cooking":@"cookingMinutes", @"preparetion":@"preparationMinutes" }];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict error:(NSError **)err {
    [self mergeFromDictionary:dict useKeyMapping:true error:err];

    return  self;
}

@end
