//
//  DaoMessages.h
//  ios-training-8
//
//  Created by Manami Ichikawa on 7/22/17.
//  Copyright © 2017 Manami Ichikawa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Message.h"

@protocol DaoMessageDelegate<NSObject>

@optional
-(void)finishedAddingNewMessage;

@end

@interface DaoMessages : NSObject

@property (weak, nonatomic) id <DaoMessageDelegate> delegate;
-(void)addNewMessage:(Message*)message;
-(NSMutableArray<Message*>*)showMessageList;
-(id)init;

@end
