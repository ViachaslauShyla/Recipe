//
//  StepsModel.m
//  OpenAPIClient
//
//  Created by Slava on 10/15/19.
//

#import "StepsModel.h"
#import "EquipmentModel.h"
#import "IngredientModel.h"

@implementation StepsModel

-(id) initWithResultRequest:(NSDictionary *)result {

    self = [super init];
    if (self) {
        _equipments = [NSArray array];
        _ingredients = [NSArray array];
        [self setDataIntoModel:result];
    }
    
    return self;
}

- (void)setDataIntoModel: (NSDictionary *)data {

    if ((NSNumber *)data[@"number"]) {
        _number = data[@"number"];
    }

    if ((NSString *)data[@"step"]) {
        _text = data[@"step"];
    }

    if ((NSArray<NSDictionary *> *)data[@"equipment"]) {
        NSMutableArray *equipments = [NSMutableArray array];

        for (NSDictionary *resultRequest in data[@"equipment"]) {
            EquipmentModel *equipment = [[EquipmentModel alloc] initWithResultRequest:resultRequest];
            [equipments addObject:equipment];
        }
        _equipments = [NSArray arrayWithArray:equipments];
    }

    if ((NSArray<NSDictionary *> *)data[@"ingredients"]) {
        NSMutableArray *ingredients = [NSMutableArray array];

        for (NSDictionary *resultRequest in data[@"ingredients"]) {
            IngredientModel *ingredient = [[IngredientModel alloc] initWithResultRequest:resultRequest];
            [ingredients addObject:ingredient];
        }
        _ingredients = [NSArray arrayWithArray:ingredients];
    }
}

@end
