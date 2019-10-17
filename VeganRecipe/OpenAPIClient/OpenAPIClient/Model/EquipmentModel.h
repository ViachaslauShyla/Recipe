//
//  EquipmentModel.h
//  OpenAPIClient
//
//  Created by Slava on 10/16/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface EquipmentModel : NSObject

@property(strong, nonatomic) NSNumber *idEquipment;
@property(strong, nonatomic) NSString *title;
@property(strong, nonatomic) NSString *imageName;

-(id) initWithResultRequest: (NSDictionary *)result;
- (void)setDataIntoModel: (NSDictionary *)data;

@end

NS_ASSUME_NONNULL_END
