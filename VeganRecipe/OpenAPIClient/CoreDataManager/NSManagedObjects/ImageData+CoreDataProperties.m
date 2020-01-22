//
//  ImageData+CoreDataProperties.m
//  OpenAPIClient
//
//  Created by AppStore on 1/22/20.
//
//

#import "ImageData+CoreDataProperties.h"

@implementation ImageData (CoreDataProperties)

+ (NSFetchRequest<ImageData *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"ImageData"];
}

@dynamic data;
@dynamic url;

@end
