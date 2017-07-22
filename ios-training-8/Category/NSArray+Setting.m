//
//  NSArray+Setting.m
//  ios-training-8
//
//  Created by Manami Ichikawa on 7/22/17.
//  Copyright © 2017 Manami Ichikawa. All rights reserved.
//

#import "NSArray+Setting.h"

@implementation NSArray (Setting)

-(NSArray *)createNonDuplicateArray:(NSArray *)array{
    NSArray *dateList = [[NSArray alloc]init];
    [dateList nonDuplicateArray:array];
return
}

@end
