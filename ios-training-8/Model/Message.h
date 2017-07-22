//
//  Message.h
//  ios-training-8
//
//  Created by Manami Ichikawa on 7/22/17.
//  Copyright © 2017 Manami Ichikawa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Message : NSObject

@property (nonatomic) NSInteger commentId;
@property (nonatomic) NSString* title;
@property (nonatomic) NSDate* sentDate;

@end
