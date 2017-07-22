//
//  NSSet+Date.m
//  ios-training-8
//
//  Created by Manami Ichikawa on 7/22/17.
//  Copyright © 2017 Manami Ichikawa. All rights reserved.
//

#import "NSSet+Date.h"

@implementation NSSet (Date)

+(NSArray *)createNonDuplicateArray:(NSArray *)array{
    NSArray *dateList = [[NSMutableArray alloc]init];
    NSSet *set = [NSSet setWithArray:array];
    dateList = [set allObjects];
    
    return dateList;
}


@end
