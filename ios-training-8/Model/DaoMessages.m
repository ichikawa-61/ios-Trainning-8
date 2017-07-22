//
//  DaoMessages.m
//  ios-training-8
//
//  Created by Manami Ichikawa on 7/22/17.
//  Copyright © 2017 Manami Ichikawa. All rights reserved.
//

#import "DaoMessages.h"
#import "FMDB.h"

@interface DaoMessages()
@property(nonatomic,copy) NSString* db_path;

@end

@implementation DaoMessages

-(id)init{
    
    self = [super init];
    if(self){
        FMDatabase* db = [self getConnection];
        [db open];
        NSString *sql = @"CREATE TABLE IF NOT EXISTS t_message(comment_id INTEGER PRIMARY KEY AUTOINCREMENT, message_title TEXT, sent_date INTEGER); ";
        [db executeUpdate:sql];
        [db close];
    }
    return self;
}

-(NSMutableArray<Message*>*)showMessageList{
    
    FMDatabase *db = [self getConnection];
    NSString *sqlite = @"SELECT* FROM t_message ORDER BY sent_date ASC ";
    [db open];
    FMResultSet* results = [db executeQuery:sqlite];
    NSMutableArray *list = [[NSMutableArray alloc] init];
    
    while ([results next]){
        Message* message = [[Message alloc] init];
        
        message.commentId   = [results intForColumn:@"comment_id"];
        message.title       = [results stringForColumn:@"message_title"];
        message.sentDate    = [results dateForColumn:@"sent_date"];
        
        [list addObject:message];
    }
    [db close];
    return list;
    
}

-(void)addNewMessage:(Message*)message{
    
    //登録日
    NSDate *date = [NSDate date];
    message.sentDate = date;
    
    FMDatabase* db = [self getConnection];
    [db open];
    [db beginTransaction];
    
    NSString *sql = @"INSERT INTO t_message (message_title, sent_date) VALUES (?,?)";
    
    BOOL t = [db executeUpdate:sql, message.title, message.sentDate];
    NSLog(@"%d",t);
    
    if([self.delegate respondsToSelector:@selector(finishedAddingNewMessage)]){
        
        [self.delegate finishedAddingNewMessage];
    }

    [db commit];
    [db close];
    
}

+(NSString*)getDbFilePath{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
    NSLog(@"%@",paths);
    NSString *dir = [paths
                     objectAtIndex:0];
    return [dir stringByAppendingPathComponent:@"message.db"];
}

-(FMDatabase*)getConnection{
    if(self.db_path == nil){
        self.db_path = [DaoMessages getDbFilePath];
    }
    
    return [FMDatabase databaseWithPath:self.db_path];
};



@end
