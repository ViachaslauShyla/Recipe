//
//  Cache+CoreDataProperties.m
//  OpenAPIClient
//
//  Created by AppStore on 1/22/20.
//
//

#import "Cache+CoreDataProperties.h"

@implementation Cache (CoreDataProperties)

+ (NSFetchRequest<Cache *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Cache"];
}

@dynamic data;
@dynamic url;

@end
