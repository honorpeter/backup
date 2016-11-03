lmdb:
    some excellent properties:
        Ordered map interface (keys are always lexicographically sorted).
        Reader/writer transactions: readers don’t block writers, writers
            don’t block readers. Each environment supports one concurrent
            write transaction.
        Read transactions are extremely cheap.
        Environments may be opened by multiple processes on the same host
        Multiple named databases may be created with transactions covering 
            all named databases.
        No application-level caching is required: LMDB fully exploits the 
            operating system’s buffer cache.

Named Databases:
        Named databases require the max_dbs= parameter to be provided when 
            calling lmdb.open() or lmdb.Environment. This must be done by 
            the first process or thread opening the environment.
        Once a correctly configured Environment is created, new named 
            databases may be created via Environment.open_db().

Storage efficiency & limits:
        Space usage can be monitored using Environment.stat():
            >>> pprint(env.stat())
            {'branch_pages': 1040L,
            'depth': 4L,
            'entries': 3761848L,
            'leaf_pages': 73658L,
            'overflow_pages': 0L,
            'psize': 4096L}
            This database contains 3,761,848 records and no values were 
                spilled (overflow_pages).
            By default record keys are limited to 511 bytes in length 
                compile-time key length can be queried via 
                Environment.max_key_size().

Memory usage:
         Environment.sync() 将内存中的数据 同步到disk
         

Bytestrings:
         bytestring to mean either the Python<=2.7 str() type, or the 
                Python>=3.0 bytes() type
        字符集 

Buffers:
    
        return buffer() objects instead of bytestrings by passing 
                buffers=True to Environment.begin() or Transaction.

        >>> txn = env.begin(buffers=True)
        >>> buf = txn.get('somekey')
        >>> buf
        <read-only buffer ptr 0x12e266010, size 4096 at 0x10d93b970>
        
        >>> len(buf)
        4096
        >>> buf[0]
        'a'
        >>> buf[:2]
        'ab'
        >>> value = bytes(buf)
        >>> len(value)
        4096
        >>> type(value)
        <type 'bytes'>

writemap mode:
        When Environment or open() is invoked with writemap=True, 
            the library will use a writeable memory mapping to directly 
            update storage
    

Resource Management:
        Environment, Transaction, and Cursor support the context manager 
                protocol
            with env.begin() as txn:
                with txn.cursor() as curs:
                    # do stuff
                    print 'key is:', curs.get('key')

Transaction management:
        

...

Data Structures:
    struct  	MDB_val
            size_t 	mv_size         size of the data item
            void * 	mv_data         address of the data item

    struct  	MDB_stat
            unsigned int 	ms_psize    Size of a database page. This is 
                                    currently the same for all databases.
            unsigned int 	ms_depth    Depth (height) of the B-tree
            size_t 	ms_branch_pages     Number of internal (non-leaf) pages
            size_t 	ms_leaf_pages       Number of leaf pages
            size_t 	ms_overflow_pages   Number of overflow pages
            size_t 	ms_entries          Number of data items
    struct  	MDB_envinfo
        .....

Start:
        Everything starts with an environment, created by mdb_env_create().
             Once created, this environment must also be opened with 
             mdb_env_open().
        mdb_env_open() 
                gets passed a name which is interpreted as a directory path
                this directory must exist already
                Within that directory, a lock file and a storage file will 
                        be generated
                 If you don't want to use a directory, you can pass the 
                    MDB_NOSUBDIR option instead of directly path the path 
                    you provided is used directly as the data file, and 
                    another file with a "-lock" suffix added will be used 
                    for the lock file.'
        Once the environment is open, a transaction can be created within 
                it using mdb_txn_begin().
                Transactions may be read-write or read-only,
                A transaction must only be used by one thread at a time. 
                    Transactions are always required, even for read-only 
                    access.
        Once a transaction has been created, a database can be opened 
                within it using mdb_dbi_open().
                If only one database will ever be used in the environment,
                         a NULL can be passed as the database name
                For named databases, the MDB_CREATE flag must be used to 
                        create the database
                mdb_env_set_maxdbs() must be called after mdb_env_create() 
                        and before mdb_env_open() to set the maximum number
                        of named databases you want to support.

        Within a transaction, mdb_get() and mdb_put() can store single 
                key/value pairs if that is all you need to do
        A key/value pair is expressed as two MDB_val structures. This 
                struct has two fields, mv_size and mv_data. The data is a 
                void pointer to an array of mv_size bytes.

        Note: a single transaction can open multiple databases. Generally 
                databases should only be opened once, by the first 
                transaction in the process. After the first transaction 
                completes, the database handles can freely be used by all 
                subsequent transactions.
                Once a transaction is closed, the values can no longer be 
                   used, so make a copy if you need to keep them after that.

Cursors:      to do more things
         a cursor can be created with mdb_cursor_open(), Within the 
                        transaction.
        cursor can store/retrieve/delete (multiple) values using 
                mdb_cursor_get(), mdb_cursor_put(), and mdb_cursor_del().
        mdb_cursor_get() positions itself depending on the cursor operation 
            requested, and for some operations, on the supplied key. 
            For example, to list all key/value pairs in a database, use 
            operation MDB_FIRST for the first call to mdb_cursor_get(), 
            and MDB_NEXT on subsequent calls, until the end is hit.
        To retrieve all keys starting from a specified key value, 
            use MDB_SET.
        When using mdb_cursor_put(), either the function will position the 
            cursor for you based on the key, or you can use operation 
            MDB_CURRENT to use the current position of the cursor. 
            Note that key must then match the current position's key.'

Summarizing the Opening:
        So we have a cursor in a transaction which opened a database in an 
            environment which is opened from a filesystem after it was 
            separately created.

        Or, we create an environment, open it from a filesystem, create a 
            transaction within it, open a database within that transaction,
            and create a cursor within all of the above.

Duplicate Keys:
        If there are multiple values for a key, mdb_get() will only return 
                the first value.
        When multiple values for one key are required, pass the MDB_DUPSORT 
                flag to mdb_dbi_open(). 
                in the case,by default mdb_put() will not replace the value 
                        for a key if the key existed already. 
                mdb_del() will pay attention to the value field too, 
                    allowing for specific values of a key to be deleted.
Some Optimization:
        

        
Cleaning Up:
        For read-only transactions, any cursors created within it must be 
                closed using mdb_cursor_close().


        
MDB_env *mdb_env;
MDB_dbi mdb_dbi;
MDB_val mdb_key, mdb_data;
MDB_txn *mdb_txn;

char *db_path="long";
CHECK_EQ(mkdir(db_path, 0744), 0)
    << "mkdir " << db_path << "failed";
//创建 env
CHECK_EQ(mdb_env_create(&mdb_env), MDB_SUCCESS) << "mdb_env_create failed";

CHECK_EQ(mdb_env_set_mapsize(mdb_env, 1099511627776), MDB_SUCCESS)  // 1TB
    << "mdb_env_set_mapsize failed";
CHECK_EQ(mdb_env_open(mdb_env, db_path, 0, 0664), MDB_SUCCESS)
    << "mdb_env_open failed";
CHECK_EQ(mdb_txn_begin(mdb_env, NULL, 0, &mdb_txn), MDB_SUCCESS)
    << "mdb_txn_begin failed";
CHECK_EQ(mdb_open(mdb_txn, NULL, 0, &mdb_dbi), MDB_SUCCESS)
    << "mdb_open failed. Does the lmdb already exist? ";


mdb_data.mv_size = value.size();
mdb_data.mv_data = reinterpret_cast<void*>(&value[0]);
mdb_key.mv_size = key_str.size();
mdb_key.mv_data = reinterpret_cast<void*>(&key_str[0]);
CHECK_EQ(mdb_put(mdb_txn, mdb_dbi, &mdb_key, &mdb_data, 0), MDB_SUCCESS)
    << "mdb_put failed";

CHECK_EQ(mdb_txn_commit(mdb_txn), MDB_SUCCESS)
    << "mdb_txn_commit failed";

    











