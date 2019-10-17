//
//  EquipmentModel.m
//  OpenAPIClient
//
//  Created by Slava on 10/16/19.
//

#import "EquipmentModel.h"

@implementation EquipmentModel

-(id) initWithResultRequest: (NSDictionary *)result {
    
    self = [super init];
    if (self) {
        [self setDataIntoModel:result];
    }
    
    return self;
}

- (void)setDataIntoModel: (NSDictionary *)data {
    
    if ((NSNumber *)data[@"id"]) {
        _idEquipment = data[@"id"];
    }
    
    if ((NSString *)data[@"image"]) {
        _imageName = data[@"image"];
    }
    
    if ((NSString *)data[@"name"]) {
        _title = data[@"name"];
    }
}

@end
