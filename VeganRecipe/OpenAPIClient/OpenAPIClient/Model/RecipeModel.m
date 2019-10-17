//
//  RecipeModel.m
//  OpenAPIClient
//
//  Created by Slava on 10/15/19.
//

#import "RecipeModel.h"


@implementation RecipeModel

-(id) initWithResultRequest: (NSDictionary *)result {

    self = [super init];
    if (self) {
        [self setDataIntoModel:result];
    }

    return self;
}

- (void)setDataIntoModel: (NSDictionary *)data {

    if ((NSNumber *)data[@"id"]) {
        _idRecipe = data[@"id"];
    }

    if ((NSString *)data[@"image"]) {
        _imageUrl = data[@"image"];
    }

    if ((NSString *)data[@"title"]) {
        _title = data[@"title"];
    }

}


@end
