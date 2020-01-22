#import "Measures.h"

@implementation Measures

+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{ @"amount": @"amount", @"unitShort": @"unitShort", @"unitLong": @"unitLong"  }];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict error:(NSError **)err {
    [self mergeFromDictionary:dict useKeyMapping:true error:err];

    return self;
}

@end
