

#import <Foundation/Foundation.h>


@interface SQLiteResult : NSObject {
	NSString *errorCode;
	NSMutableArray *columnNames;
	NSMutableArray *columnTypes;
	NSMutableArray *rows;
    NSInteger lastInsertedId;
}

@property(copy) NSString *errorCode;
@property(assign) NSMutableArray *columnNames;
@property(assign) NSMutableArray *columnTypes;
@property(assign) NSMutableArray *rows;
@property(assign) NSInteger lastInsertedId;

+ (SQLiteResult*) createSQLiteResult;

@end
