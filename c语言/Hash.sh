通过哈希函数将key和value对应起来
    使用哈希函数通过key来创建索引
    哈希冲突(hash collision)：哈希函数将两个不同的key映射到同一个索引的情况
        链接法:
            本例就是        就是将bucket的做成链表 来存放
        开放寻址法：
            寻找下一个槽， 如果该槽也被占用了则继续寻找下一个槽
    简单实现：
        数据结构：
            typedef struct _Bucket
            {
                char *key;
                void *value;
                struct _Bucket *next;
            } Bucket;
             
            typedef struct _HashTable
            {
                int size;       存放一共可以存放几个元素    几个值
                int elem_num;   存放现在存放了几个元素 
                Bucket** buckets;
            } HashTable;    这个哈希表   buckets指针的指针
                            指向多个 bucket的指针   这些指针在指向实体
                            这样可以 需要时再分配空间 也利用查找


        哈希函数：
            使用哈希函数来创建索引
            static int hash_str(char *key)
            {
                int hash = 0;
             
                char *cur = key;
             
                while(*cur != '\0') {
                    hash += *cur;
                    ++cur;
                }
             
                return hash;
            }
             
            // 使用这个宏来求得key在哈希表中的索引
            #define HASH_INDEX(ht, key) (hash_str((key)) % (ht)->size)

        操作接口：
            int hash_init(HashTable *ht);                // 初始化哈希表
            int hash_lookup(HashTable *ht, char *key, void **result);
                                                       // 根据key查找内容
            int hash_insert(HashTable *ht, char *key, void *value);
                                                     // 将内容插入到哈希表中
            int hash_remove(HashTable *ht, char *key);
                                                    // 删除key所指向的内容
            int hash_destroy(HashTable *ht);

            int hash_init(HashTable *ht)
            {
                ht->size        = HASH_TABLE_INIT_SIZE;
                ht->elem_num    = 0;
                ht->buckets = (Bucket **)calloc(ht->size, sizeof(Bucket *));
                    这里只是创建了几个 指向 实体的指针
             
                if(ht->buckets == NULL) return FAILED;
             
                LOG_MSG("[init]\tsize: %i\n", ht->size);
             
                return SUCCESS;
            }


            int hash_insert(HashTable *ht, char *key, void *value)
            {
                // check if we need to resize the hashtable
                resize_hash_table_if_needed(ht);
             
                int index = HASH_INDEX(ht, key);
             
                Bucket *org_bucket = ht->buckets[index];
                Bucket *tmp_bucket = org_bucket;
             
                // check if the key exits already
                while(tmp_bucket)
                {
                    if(strcmp(key, tmp_bucket->key) == 0)
                    {
                        LOG_MSG("[update]\tkey: %s\n", key);
                        tmp_bucket->value = value;
             
                        return SUCCESS;
                    }
             
                    tmp_bucket = tmp_bucket->next;
                }
             
                Bucket *bucket = (Bucket *)malloc(sizeof(Bucket));
             
                bucket->key   = key;
                bucket->value = value;
                bucket->next  = NULL;
             
                ht->elem_num += 1;
             
                if(org_bucket != NULL)
                {
                    LOG_MSG("[collision]\tindex:%d key:%s\n", index, key);
                    bucket->next = org_bucket;
                }
             
                ht->buckets[index]= bucket;
             
                LOG_MSG("[insert]\tindex:%d key:%s\tht(num:%d)\n",
                    index, key, ht->elem_num);
             
                return SUCCESS;
            }


            static void resize_hash_table_if_needed(HashTable *ht)
            {
                if(ht->size - ht->elem_num < 1)
                {
                    hash_resize(ht);
                }
            }
             
            static int hash_resize(HashTable *ht)
            {
                // double the size
                int org_size = ht->size;
                ht->size = ht->size * 2;
                ht->elem_num = 0;
             
                LOG_MSG("[resize]\torg size: %i\tnew size: %i\n", org_size, ht->size);
             
                Bucket **buckets = (Bucket **)calloc(ht->size, sizeof(Bucket *));
             
                Bucket **org_buckets = ht->buckets;
                ht->buckets = buckets;
             
                int i = 0;
                for(i=0; i < org_size; ++i)
                {
                    Bucket *cur = org_buckets[i];
                    Bucket *tmp;
                    while(cur)
                    {
                        // rehash: insert again
                        hash_insert(ht, cur->key, cur->value);
             
                        // free the org bucket, but not the element
                        tmp = cur;
                        cur = cur->next;
                        free(tmp);
                    }
                }
                free(org_buckets);
             
                LOG_MSG("[resize] done\n");
             
                return SUCCESS;
            }

            int hash_lookup(HashTable *ht, char *key, void **result)
            {
                int index = HASH_INDEX(ht, key);
                Bucket *bucket = ht->buckets[index];
             
                if(bucket == NULL) goto failed;
             
                while(bucket)
                {
                    if(strcmp(bucket->key, key) == 0)
                    { 
                        LOG_MSG("[lookup]\t found %s\tindex:%i value: %p\n",
                            key, index, bucket->value);
                        *result = bucket->value;
             
                        return SUCCESS;
                    } 
             
                    bucket = bucket->next;
                }
             
            failed:
                LOG_MSG("[lookup]\t key:%s\tfailed\t\n", key);
                return FAILED;
            }


几种经典的hash函数：
    PHP中出现的字符串Hash函数：
        static unsigned long hashpjw(char *arKey, unsigned int nKeyLength)
        {
                unsigned long h = 0, g;
                char *arEnd=arKey+nKeyLength; 
        
                while (arKey < arEnd) {
                        h = (h << 4) + *arKey++;
                        if ((g = (h & 0xF0000000))) {
                                h = h ^ (g >> 24);
                                h = h ^ g;
                        }
                }
                return h;
        }

OpenSSL中出现的字符串Hash函数:
        unsigned long lh_strhash(char *str)
        {
        int i,l;
        unsigned long ret=0;
        unsigned short *s; 

        if (str == NULL) return(0);
        l=(strlen(str)+1)/2;
        s=(unsigned short *)str; 

        for (i=0; i
        ret^=(s[i]<<(i&0x0f));
        return(ret);
        } 

        /* The following hash seems to work very well on normal text strings 
        * no collisions on /usr/dict/words and it distributes on %2^n quite 
        * well, not as good as MD5, but still good. 
        */
        unsigned long lh_strhash(const char *c)
        {
        unsigned long ret=0;
        long n;
        unsigned long v;
        int r; 

        if ((c == NULL) || (*c == '\0'))
        return(ret);
        /*
        unsigned char b[16]; 
        MD5(c,strlen(c),b); 
        return(b[0]|(b[1]<<8)|(b[2]<<16)|(b[3]<<24)); 
        */ 

        n=0x100;
        while (*c)
        {
        v=n|(*c);
        n+=0x100;
        r= (int)((v>>2)^v)&0x0f;
        ret=(ret(32-r));
        ret&=0xFFFFFFFFL;
        ret^=v*v;
        c++;
        } 

        return((ret>>16)^ret);
        }



        MySql中出现的字符串Hash函数:
                #ifndef NEW_HASH_FUNCTION 

        /* Calc hashvalue for a key */
        static uint calc_hashnr(const byte *key,uint length)
        {
        register uint nr=1, nr2=4; 

        while (length--)
        {
        nr^= (((nr & 63)+nr2)*((uint) (uchar) *key++))+ (nr << 8);
        nr2+=3;
        } 

        return((uint) nr);
        } 

        /* Calc hashvalue for a key, case indepenently */
        static uint calc_hashnr_caseup(const byte *key,uint length)
        {
        register uint nr=1, nr2=4; 

        while (length--)
        {
        nr^= (((nr & 63)+nr2)*((uint) (uchar) toupper(*key++)))+ (nr << 8);
        nr2+=3;
        } 

        return((uint) nr);
        }
        #else
        /* 
        * Fowler/Noll/Vo hash 
        * 
        * The basis of the hash algorithm was taken from an idea sent by email to the 
        * IEEE Posix P1003.2 mailing list from Phong Vo (kpv@research.att.com) and 
        * Glenn Fowler (gsf@research.att.com). Landon Curt Noll (chongo@toad.com) 
        * later improved on their algorithm. 
        * 
        * The magic is in the interesting relationship between the special prime 
        * 16777619 (2^24 + 403) and 2^32 and 2^8. 
        * 
        * This hash produces the fewest collisions of any function that we've seen so 
        * far, and works well on both numbers and strings. 
        */
        uint calc_hashnr(const byte *key, uint len)
        {
        const byte *end=key+len;
        uint hash; 

        for (hash = 0; key < end; key++)
        {
        hash *= 16777619;
        hash ^= (uint) *(uchar*) key;
        } 

        return (hash);
        } 

        uint calc_hashnr_caseup(const byte *key, uint len)
        {
        const byte *end=key+len;
        uint hash; 

        for (hash = 0; key < end; key++)
        {
        hash *= 16777619;
        hash ^= (uint) (uchar) toupper(*key);
        } 

        return (hash);
        }
        #endif

        Mysql中对字符串Hash函数还区分了大小写
另一个经典字符串Hash函数:
        unsigned int hash(char *str)
        {
            register unsigned int h;
            register unsigned char *p; 

            for(h=0, p = (unsigned char *)str; *p ; p++)
            h = 31 * h + *p; 

            return h;
        }











