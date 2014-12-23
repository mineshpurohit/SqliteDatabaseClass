//
//  SQLConstant.h
//  TechMateInter
//
//  Created by Amit on 7/13/12.
//  Copyright 2012. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SQLite.h"
#import "SQLiteResult.h"
#import "SqliteServiceResult.h"
#import "SqliteDatabaseService.h"

#define EncodeSingleComma(str) [[str stringByReplacingOccurrencesOfString:@"(null)" withString:@""] stringByReplacingOccurrencesOfString:@"," withString:@"&#59#"]
#define DecodeSingleComma(str) [[str stringByReplacingOccurrencesOfString:@"(null)" withString:@""] stringByReplacingOccurrencesOfString:@"&#59#" withString:@","]

#define removeSlash(str) [[str stringByReplacingOccurrencesOfString:@"(null)" withString:@""] stringByReplacingOccurrencesOfString:@"\"" withString:@""]

#define SELECT_METHOD 0
#define UPDATE_METHOD 1
#define INSERT_METHOD 2
#define DELETE_METHOD 3

@protocol SQLConstant


@end
