//
//  MassageDataProvider.h
//  ios-training-8
//
//  Created by Manami Ichikawa on 7/21/17.
//  Copyright © 2017 Manami Ichikawa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MessageDataProvider : NSObject <UITableViewDataSource>
@property(nonatomic, strong) NSMutableArray *items;
@property(nonatomic, strong) NSArray *dateArray;
@end
