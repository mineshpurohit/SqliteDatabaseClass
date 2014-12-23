
#import "SQLiteResult.h"


@implementation SQLiteResult

@synthesize errorCode, columnNames, columnTypes, rows, lastInsertedId;

+ (SQLiteResult*) createSQLiteResult
{
	SQLiteResult *res =  [[[SQLiteResult alloc] init] autorelease];
	res.errorCode = @"Uninitialized result";
	res.columnNames = [NSMutableArray arrayWithCapacity:10];
	res.columnTypes = [NSMutableArray arrayWithCapacity:10];
	res.rows = [NSMutableArray arrayWithCapacity:10];
    res.lastInsertedId = 0;
	return res;
}

@end
