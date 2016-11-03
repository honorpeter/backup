
/*
 * goto的典型用法 做错误处理
 * 几个相同的错误处理
 */
HRESULT     HrDoSomething(int parameter)
{
    if (somecode() != 0){
        //set HR value
        goto Error;
    }
    if (somecode != 1) {
        //set HR value
        goto Error;
    }

Error :
    return hr;

}
