//
//  IngredientModel.m
//  OpenAPIClient
//
//  Created by Slava on 10/16/19.
//

#import "IngredientModel.h"

@implementation IngredientModel

-(id) initWithResultRequest: (NSDictionary *)result {

    self = [super init];
    if (self) {
        [self setDataIntoModel:result];
    }

    return self;
}

- (void)setDataIntoModel: (NSDictionary *)data {

    if ((NSNumber *)data[@"id"]) {
        _idIngredient = data[@"id"];
    }

    if ((NSString *)data[@"image"]) {
        _imageName = data[@"image"];
    }

    if ((NSString *)data[@"name"]) {
        _title = data[@"name"];
    }

    if ((NSDictionary *)data[@"measures"]) {
        NSDictionary* dictResult = data[@"measures"];

        if ((NSDictionary *)dictResult[@"metric"]) {
            NSDictionary *dictMetric = dictResult[@"metric"];
            if ((NSNumber *)dictMetric[@"amount"]) {
                _metric.amount = dictMetric[@"amount"];
            }
            if ((NSNumber *)dictMetric[@"unitShort"]) {
                _metric.unitShort = dictMetric[@"unitShort"];
            }
        }

        if ((NSDictionary *)dictResult[@"us"]) {
            NSDictionary *dictUs = dictResult[@"us"];
            if ((NSNumber *)dictUs[@"amount"]) {
                _metric.amount = dictUs[@"amount"];
            }
            if ((NSNumber *)dictUs[@"unitShort"]) {
                _metric.unitShort = dictUs[@"unitShort"];
            }
        }
    }
}

@end
