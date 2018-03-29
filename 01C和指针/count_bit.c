Hamming weight BTW
    https://en.wikipedia.org/wiki/Hamming_weight

int NumberOfSetBits(int n){
  int count = 0;
  while(n){
    count += n & 1;
    n >>= 1;
  }
  return count;
}


//for 64 bit numbers
int NumberOfSetBits64(long long i)
{
    i = i - ((i >> 1) & 0x5555555555555555);
    i = (i & 0x3333333333333333) +
        ((i >> 2) & 0x3333333333333333);
    i = ((i + (i >> 4)) & 0x0F0F0F0F0F0F0F0F);
    return (i*(0x0101010101010101))>>56;
}
//for 32 bit integers
int NumberOfSetBits32(int i)
{
    i = i - ((i >> 1) & 0x55555555);
    i = (i & 0x33333333) + ((i >> 2) & 0x33333333);
    i = ((i + (i >> 4)) & 0x0F0F0F0F);
    return (i*(0x01010101))>>24;
}

指令集：
    The ARM architecture introduced the VCNT instruction as part of the Advanced SIMD (NEON) extensions.
    x86's popcnt
