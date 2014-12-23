SqliteDatabaseClass
===================

these classes use for handling select, insert, update &amp; delete request in Sqlite Database.

For Select any data from database:

    SqliteServiceResult * selectResponse = [self execQuery:query];
    if ([selectResponse.rowsValue count] > 0)
    {
      for (int i= 0; i < [selectResponse.rowsValue count]; i++)
      {
		      // Write a code for Fetch data from table cols.
      } 
    }
    

For Insert, Update & Delete User below Method:

    BOOL isSucceed = [self performModifyQuery:strQuery];
    if (!isSucceed) {
      NSLog(@"Error in perform query");
    }
