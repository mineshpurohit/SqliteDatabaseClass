

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "SQLiteResult.h"


@interface SQLite : NSObject {

}

+ (NSString*) filename;
+ (NSString*) fullFilePath;
+ (BOOL) initializeDB;
+ (BOOL) removeDB;
+ (SQLiteResult*) query:(NSString*)content;

@end
