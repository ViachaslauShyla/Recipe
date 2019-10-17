//
//  CoreDataManager.h
//  OpenAPIClient
//
//  Created by Slava on 10/4/19.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface CoreDataManager : NSObject

@property (readonly, strong) NSPersistentContainer *persistentContainer;

+ (CoreDataManager *)shared;

- (NSDictionary *) dataSourceForUrl: (NSString *)url;
- (void) saveIntoDataSourceFor: (NSString *)key data: (NSObject *)data;
- (void) deleteData;

@end

NS_ASSUME_NONNULL_END
