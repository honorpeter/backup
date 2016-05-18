随机数产生方法：
    1 硬件产生
         Linux中的随机数可以从两个特殊的文件中产生，
                一个是/dev/urandom.另外一个是/dev/random
        原理是利用当前系统的熵池来计算出一定数量的随机比特，然后将这些比特
            作为字节流返回。熵池就是当前系统的环境噪音，熵指的是一个系统的
            混乱程度，系统噪音可以通过很多参数来评估，如内存的使用，文件
            的使用量，不同类型的进程数量等等。如果当前环境噪音变化的不是很
            剧烈或者当前环境噪音很小，比如刚开机的时候，而当前需要大量的随
            机比特，这时产生的随机数的随机效果就不是很好了。
       /dev/urandom和/dev/random后者在不能产生新的随机数时会阻塞程序，而前
            者不会（ublock），当然前者产生的随机数效果就不太好了.
            /dev/random会阻塞当前的程序，直到根据熵池产生新的随机字节之后
            才返回，所以使用/dev/random比使用/dev/urandom产生大量随机数的
            速度要慢。 
            
    2 软件产生
        余弦发生器 。。。。 产生均匀随机分布 
        依据均匀随机分布 产生其他的分布 数学公式

产生函数：
#include <boost/thread.hpp> //包含各种线程函数
#include <cmath>
#include <cstdio>
#include <ctime>
#include<iostream>


using namespace std;


int64_t cluster_seedgen(void) {
  int32_t s, seed, pid;
  FILE* f = fopen("/dev/urandom", "rb");
  if (f && fread(&seed, 1, sizeof(seed), f) == sizeof(seed)) {
    fclose(f);
    return seed;
  }

  cout << "System entropy source not available, "
              "using fallback algorithm to generate seed instead.";
  if (f)
    fclose(f);

  pid = getpid();
  s = time(NULL);
  //处理一下 让输出的值包含在特定的范围
  seed = std::abs(((s * 181) * ((pid - 83) * 359)) % 104729);
  return seed;
}


int main(int argc, const char *argv[])
{
    
    int64_t rand = cluster_seedgen();
    cout << rand;
    return 0;
}











