//
//  ImageData+CoreDataProperties.h
//  OpenAPIClient
//
//  Created by AppStore on 1/22/20.
//
//

#import "ImageData+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface ImageData (CoreDataProperties)

+ (NSFetchRequest<ImageData *> *)fetchRequest;

@property (nullable, nonatomic, retain) NSData *data;
@property (nullable, nonatomic, copy) NSString *url;

@end

NS_ASSUME_NONNULL_END
