//
//  CookTimeModel.h
//  OpenAPIClient
//
//  Created by Slava on 10/16/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CookTimeModel : NSObject

@property(strong, nonatomic) NSNumber *inReady;
@property(strong, nonatomic) NSNumber *cooking;
@property(strong, nonatomic) NSNumber *preparetion;

-(id) initWithResultRequest: (NSDictionary *)result;
- (void)setDataIntoModel: (NSDictionary *)data;

@end

NS_ASSUME_NONNULL_END
