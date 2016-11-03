大端(Big Endian)与小端(Little Endian)详解:
    Byte Endian是指字节在内存中的组织:
        对于数据中跨越多个字节的对象， 我们必须为它建立这样的约定:
        (1) 它的地址是多少?(2) 它的字节在内存中是如何组织的?
        多字节对象在内存中的组织有一般有两种约定:
        Big endian machine: It thinks the first byte it reads is the biggest
        Little endian machine: It thinks the first byte it reads is 
                the littlest.

        举个例子，从内存地址0x0000开始有以下数据:
            0x0000     0x12

            0x0001     0x34
            
            0x0002     0xab

            0x0003     0xcd
        如果我们去读取一个地址为0x0000的四个字节变量，若字节序为
                big-endian，则读出结果为0x1234abcd；若字节序位little-endian
                则读出结果为0xcdab3412.

        如果我们将0x12345678写入到以0x0000开始的内存中，则结果为
                            big-endian     little-endian

                            0x0000     0x12              0x78

                            0x0001     0x23              0x56

                            0x0002     0x56              0x34

                            0x0003     0x78              0x12
                                        

                        以字节为单位 不用考虑字节内的 实际存放的时候小端
                            一个字节内还不样　两个顺序相反 倒过来就行了 
                        如果使用整形读取出来的话大端不用改变
                            整形的存放方式和大端一样
                            小端的存放方式 使用下面的变换 改过来

        x86系列CPU都是little-endian的字节序, Little-Endian主要用在我们现在
            的PC的CPU中,Big-Endian则应用在目前的Mac机器中
            (注意:是指Power系列 处理器).
        主机字节序（host   byte   order），跟芯片有关，如Intel就是低位在前
                高位在后 ；  
        网络字节顺序（network   byte   order）跟芯片无关，高位在前，低位在后
        有四个函数可互相转换htons,htonl,ntohs,ntohl 
                 #include   <netinet/in.h>   
                uint16_t   htons(uint16_t   host16bitvalue);   
                //网络字节顺序到主机字节顺序 n代表net, h代表host, s代表short
                uint32_t   htonl(uint32_t   host32bitvalue);   
                //主机字节顺序到网络字节顺序 n代表net, h代表host, s代表short
                /*s上面两个函数返回网络字节序*/   
                uint16_t   ntohs(unit16_t   net16bitvalue);   
                //网络字节顺序到主机字节顺序 n代表net, h代表host, s代表short
                uint32_t   ntohl(unit32_t   net32bitvalue); 
                //网络字节顺序到主机字节顺序 n代表net, h代表host, s代表 long
                /*s上面两个函数返回主机字节序*/   


转换： 
#include <stdint.h>

//! Byte swap unsigned short
uint16_t swap_uint16( uint16_t val ) 
{
    return (val << 8) | (val >> 8 );
}

//! Byte swap short
int16_t swap_int16( int16_t val ) 
{
    return (val << 8) | ((val >> 8) & 0xFF);
}

//! Byte swap unsigned int
uint32_t swap_uint32( uint32_t val )
{
    val = ((val << 8) & 0xFF00FF00 ) | ((val >> 8) & 0xFF00FF ); 
    return (val << 16) | (val >> 16);
}

//! Byte swap int
int32_t swap_int32( int32_t val )
{
    val = ((val << 8) & 0xFF00FF00) | ((val >> 8) & 0xFF00FF ); 
    return (val << 16) | ((val >> 16) & 0xFFFF);
}
Update : Added 64bit byte swapping

int64_t swap_int64( int64_t val )
{
    val = ((val << 8) & 0xFF00FF00FF00FF00ULL ) | ((val >> 8) & 0x00FF00FF00FF00FFULL );
    val = ((val << 16) & 0xFFFF0000FFFF0000ULL ) | ((val >> 16) & 0x0000FFFF0000FFFFULL );
    return (val << 32) | ((val >> 32) & 0xFFFFFFFFULL);
}

uint64_t swap_uint64( uint64_t val )
{
    val = ((val << 8) & 0xFF00FF00FF00FF00ULL ) | ((val >> 8) & 0x00FF00FF00FF00FFULL );
    val = ((val << 16) & 0xFFFF0000FFFF0000ULL ) | ((val >> 16) & 0x0000FFFF0000FFFFULL );
    return (val << 32) | (val >> 32);
}
            









