//
//  CookTimeModel.m
//  OpenAPIClient
//
//  Created by Slava on 10/16/19.
//

#import "CookTimeModel.h"

@implementation CookTimeModel

-(id) initWithResultRequest: (NSDictionary *)result {

    self = [super init];
    if (self) {
        [self setDataIntoModel:result];
    }

    return  self;
}

- (void)setDataIntoModel: (NSDictionary *)data {

    if ((NSNumber *)data[@"readyInMinutes"]) {
        _inReady = data[@"readyInMinutes"];
    }

    if ((NSNumber *)data[@"cookingMinutes"]) {
        _cooking = data[@"cookingMinutes"];
    }

    if ((NSNumber *)data[@"preparationMinutes"]) {
        _preparetion = data[@"preparationMinutes"];
    }
}

@end
