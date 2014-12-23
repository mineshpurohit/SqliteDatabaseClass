//
//  SqliteServiceResult.h
//  TechMateInter
//
//  Created by Amit on 7/13/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SqliteServiceResult : NSObject {
	BOOL	isSuccess;
	NSMutableArray * rowsValue;
    NSMutableArray * colsName;
    NSInteger lastInsertedId;
}

@property (nonatomic, assign) BOOL	isSuccess;
@property (nonatomic, retain) NSMutableArray * rowsValue;
@property (nonatomic, retain) NSMutableArray * colsName;
@property (nonatomic, assign) NSInteger lastInsertedId;

@end
