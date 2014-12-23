

#import "SQLite.h"


@implementation SQLite

+ (NSString*) filename {
	return @"MLeadAppDb.sqlite";
}

+ (NSString*) fullFilePath {
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES); 
	NSString *documentsDirectory = [paths objectAtIndex:0];
	return [documentsDirectory stringByAppendingFormat:@"%@%@",@"/",[SQLite filename]];
}

+ (BOOL) initializeDB {
	BOOL success;
	NSFileManager *fileManager = [NSFileManager defaultManager];
	success = [fileManager fileExistsAtPath:[SQLite fullFilePath]];
	if(success) return NO;
    NSError * error = nil;
    success = [fileManager createFileAtPath:[SQLite fullFilePath] contents:nil attributes:nil];
    
    NSLog(@"%@",[error localizedDescription]);
    
	return success;
}

+ (BOOL) removeDB {
	NSFileManager *fileManager = [NSFileManager defaultManager];
	if(![fileManager fileExistsAtPath:[SQLite fullFilePath]]) return YES;
	return [fileManager removeItemAtPath:[SQLite fullFilePath] error:nil];
}

BOOL isDatabaseOpen = NO;
sqlite3 *database;

+ (BOOL) isOpenDatabase
{
    if (isDatabaseOpen) {
        [self closeDatabase];
    }
    
    if(sqlite3_open([[SQLite fullFilePath] UTF8String], &database) == SQLITE_OK)
    {
        isDatabaseOpen = YES;
    }
    else
    {
        isDatabaseOpen = NO;
        NSLog(@"SQLite Database failed to open");
    }
    return isDatabaseOpen;
}

+ (void) closeDatabase
{
    sqlite3_close(database);
}

+ (SQLiteResult*) query:(NSString*)content {
	
	// Takes a query NSString and returns a SQLiteResult result object.
	
	SQLiteResult *result = [SQLiteResult createSQLiteResult];
	if([self isOpenDatabase])
    {
		const char *sqlStatement = [content cStringUsingEncoding:NSUTF8StringEncoding];
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
        {
			int colCount = sqlite3_column_count(compiledStatement);
			for(int i=0;i<colCount;i++)
            {
				if(i == 0)
                {
					//result.tableName = [NSString stringWithCString:sqlite3_column_table_name(compiledStatement, 0) encoding:NSUTF8StringEncoding];
					//result.databaseName = [NSString stringWithCString:sqlite3_column_database_name(compiledStatement, 0) encoding:NSUTF8StringEncoding];
				}
                
				if (sqlite3_column_name(compiledStatement, i) != nil)
                {
					[result.columnNames addObject:[NSString stringWithCString:sqlite3_column_name(compiledStatement, i) encoding:NSUTF8StringEncoding]];
				}
                
				if (sqlite3_column_decltype(compiledStatement, i) != nil) {
					[result.columnTypes addObject:[NSString stringWithCString:sqlite3_column_decltype(compiledStatement, i) encoding:NSUTF8StringEncoding]];
				}
			}
            
			while(sqlite3_step(compiledStatement) == SQLITE_ROW)
            {
				// Read the data from the result row
				NSMutableArray *row = [NSMutableArray arrayWithCapacity:colCount];
                
				for(int i=0;i<colCount;i++)
                {
					if (sqlite3_column_text(compiledStatement, i) != nil)
                    {
						NSString * text = [[NSString alloc] initWithFormat:@"%@",[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, i)]];
						
                        if (![text isEqual:[NSNull null]] && text != nil)
                        {
							[row addObject:text];
						}
                        else
                        {
							[row addObject:@""];
						}
						[text release];
                        text = nil;
					}
                    else
                    {
                        [row addObject:@""];
                    }
				}
				[result.rows addObject:row];
			}
			result.errorCode = @"OK";
		}
		else
        {
            result.errorCode = @"SQL Statement failed to execute";
        }
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);
		result.lastInsertedId = (int)sqlite3_last_insert_rowid(database);
	}
	else
    {
        result.errorCode = @"SQLite Database failed to open";    
    }
	
    [self closeDatabase];
	return result;
}

@end
