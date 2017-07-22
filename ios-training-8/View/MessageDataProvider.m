//
//  MassageDataProvider.m
//  ios-training-8
//
//  Created by Manami Ichikawa on 7/21/17.
//  Copyright © 2017 Manami Ichikawa. All rights reserved.
//

#import "MessageDataProvider.h"
#import "MessageCell.h"
#import "Message.h"
#import "NSSet+Date.h"

@implementation MessageDataProvider

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    self.dateArray = [[NSArray alloc] init];
    NSMutableArray *array = [[NSMutableArray alloc]init];
    for( Message* message in self.items )
    {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy/MM/dd"];
        NSString *stringDate = [formatter stringFromDate:message.sentDate];
        [array addObject:stringDate];
    }
    NSArray *arrayDateList = [array copy];
    arrayDateList = [NSSet createNonDuplicateArray:array];
    
    self.dateArray = arrayDateList;

    return self.dateArray.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    return [self.dateArray objectAtIndex:section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
//    NSArray *stringItems = [self.items copy];
//    NSArray* commentsByDate = [stringItems objectForKey:[self.dateArray objectAtIndex:section]];
//    return commentsByDate.count;
    return self.items.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MessageCell" forIndexPath:indexPath];
    
    Message *message = [self.items objectAtIndex:indexPath.row];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm"];
    NSString *createdDate = [formatter stringFromDate:message.sentDate];
    if(message.title){
        cell.titleLabel.backgroundColor = [UIColor cyanColor];
    }
    cell.titleLabel.text = message.title;
    cell.timeLabel.text = createdDate;
    
    return cell;
}


@end
