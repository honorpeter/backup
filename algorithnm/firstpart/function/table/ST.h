/*符号表对外的接口          简单的符号表接口
 */
void STinit(int);       //初始化
int STcount();          //有多收
void STinsert(Item);    // 插入数据项　
Item STsearch(Key);     //根据关键字搜索
void STdelete(Item);    //删除数据项
Item STselect(int);     //返回第　int 大的数据项 
void STsort(void (*visit)(Item));   //顺序访问数据项







