//
//  NutritionModel.m
//  OpenAPIClient
//
//  Created by Slava on 10/16/19.
//

#import "NutritionModel.h"

@implementation NutritionModel

-(id) initWithResultRequest: (NSDictionary *)result {

    self = [super init];
    if (self) {
        [self setDataIntoModel:result];
    }

    return  self;
}
- (void)setDataIntoModel: (NSDictionary *)data {

    if ((NSString *)data[@"calories"]) {
        _calories = data[@"calories"];
    }

    if ((NSString *)data[@"carbs"]) {
        _carbs = data[@"carbs"];
    }

    if ((NSString *)data[@"fat"]) {
        _fat = data[@"fat"];
    }

    if ((NSString *)data[@"protein"]) {
        _protein = data[@"protein"];
    }
}

@end
