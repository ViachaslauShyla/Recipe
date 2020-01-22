//
//  Cache+CoreDataProperties.h
//  OpenAPIClient
//
//  Created by AppStore on 1/22/20.
//
//

#import "Cache+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Cache (CoreDataProperties)

+ (NSFetchRequest<Cache *> *)fetchRequest;

@property (nullable, nonatomic, retain) NSObject *data;
@property (nullable, nonatomic, copy) NSString *url;

@end

NS_ASSUME_NONNULL_END
