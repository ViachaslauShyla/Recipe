//
//  CoreDataManager.m
//  OpenAPIClient
//
//  Created by Slava on 10/4/19.
//

#import "CoreDataManager.h"

@implementation CoreDataManager

+ (CoreDataManager *)shared {
    static CoreDataManager *singleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        singleton = [[CoreDataManager alloc] init];
    });
    return singleton;
}

- (NSDictionary *) dataSourceForUrl: (NSString *)url {
    NSEntityDescription *description = [NSEntityDescription entityForName:@"Cache" inManagedObjectContext:self.persistentContainer.viewContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:description];
    [request setPredicate:[NSPredicate predicateWithFormat:@"url==%@",url]];
    NSError *error;
    NSArray *result = [self.persistentContainer.viewContext executeFetchRequest:request error:&error];
    NSManagedObject *object = result.firstObject;
    NSDictionary* data = [object valueForKey:@"data"];
    return  data;
}

- (void) saveIntoDataSourceFor: (NSString *)key data: (NSObject *)data {
    NSEntityDescription *description = [NSEntityDescription entityForName:@"Cache" inManagedObjectContext:self.persistentContainer.viewContext];
    NSManagedObject *object = [[NSManagedObject alloc] initWithEntity:description insertIntoManagedObjectContext:self.persistentContainer.viewContext];
    [object setValue:key forKey:@"url"];
    [object setValue:data forKey:@"data"];
    
    [self saveContext];
}

- (void) deleteData {
    NSEntityDescription *description = [NSEntityDescription entityForName:@"Cache" inManagedObjectContext:self.persistentContainer.viewContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:description];
    NSError *error;
    NSArray *result = [self.persistentContainer.viewContext executeFetchRequest:request error:&error];
    for (NSManagedObject* object in result) {
        [self.persistentContainer.viewContext deleteObject:object];
    }
}


#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            NSBundle *b = [NSBundle bundleWithIdentifier:@"org.cocoapods.OpenAPIClient"];
            NSURL *bu = [b URLForResource:@"Model" withExtension:@"momd"];
            NSManagedObjectModel *m = [[NSManagedObjectModel alloc] initWithContentsOfURL:bu];
            
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"Storage" managedObjectModel:m];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                     */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

@end
