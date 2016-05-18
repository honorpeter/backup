    在新的C++标准中，生成新头文件的方法仅仅是将现有C++头文件名中的.h去掉。
            例如，<iostream.h>变成了< iostream>，<complex.h>变成了
            <complex>，等等。对于C头文件，采用同样的方法，但在每个名字前
            还要添加一个c。所以C的<string.h>变成了<cstring>，<stdio.h>
            变成了< cstdio>，等等。     
    下面是C++头文件的现状：     
            旧的C++头文件名如<iostream.h>将会继续被支持，尽管它们不在官方
                标准中。这些头文件的内容不在名字空间std中。     
            新的C++头文件如<iostream>包含的基本功能和对应的旧头文件相同，
                但头文件的内容在名字空间std中。（在标准化的过程中，库中有
                些部分的细节被修改了，所以旧头文件和新头文件中的实体不一定
                完全对应。）     
            标准C头文件如<stdio.h>继续被支持。头文件的内容不在std中。     
            具有C库功能的新C++头文件具有如<cstdio>这样的名字。它们提供的内
                容和相应的旧C头文件相同，只是内容在std中。

C++语言ctime库:
        1. 类型
            clock_t: 是个long型，用来记录一段时间内的时钟计时单元数，
                    即CPU的运行单元时间。
            size_t: 标准C库中定义的，应为unsigned int，在64位系统中为
                    long unsigned int。
            time_t: 从1970年1月1日0时0分0秒到该时间点所经过的秒数。

            struct tm {
                int tm_sec;       /* 秒 – 取值区间为[0,59] */
                int tm_min;       /* 分 - 取值区间为[0,59] */
                int tm_hour;      /* 时 - 取值区间为[0,23] */
                int tm_mday;      /* 一个月中的日期 - 取值区间为[1,31] */
                int tm_mon;       /* 月份（从一月开始，0代表一月） - 
                                    取值区间为[0,11] */
                int tm_year;      /* 年份，其值等于实际年份减去1900 */
                int tm_wday;      /* 星期 – 取值区间为[0,6]，其中0代表星
                                    期天，1代表星期一，以此类推 */
                int tm_yday;      /* 从每年的1月1日开始的天数 – 取值区间
                        为[0,365]，其中0代表1月1日，1代表1月2日，以此类推 */
                int tm_isdst;     /* 夏令时标识符，实行夏令时
                            的时候，tm_isdst为正。不实行夏令时的进候，
                            tm_isdst为0；不了解情况时，tm_isdst()为负。*/
            };
        时间的操作:
            clock: 返回时钟计时单元数，自从这个程序开始运行。
            time: 返回当前的time_t。
            difftime: 计算time_t两个之间的时间差。
        3. 转换
            mktime: 转换tm structure成time_t
            asctime: 转换tm structure成字符串
            ctime: 转换time_t成字符串
            gmtime: 转换time_t成tm as UTC time
            localtime: 转换time_t成tm as local time
            strftime: 格式时间成字符串
            转换成字符串的几个函数：asctime, ctime, strftime
        4. 宏
            CLOCKS_PER_SEC: 它用来表示一秒钟会有多少个时钟计时单元









