问题
        很简单：给定一个数组，将其中的元素随机排列。比如给定数组
                    arry=>[1,2,3,4,5]。有A5-5种结果即5!=120种结果
解决
        a,选中第1个元素，将其与n个元素中的任意一个交换(包括第1个元素自己)
                这时排序后的第1个元素已经确定。
        b,选中第2个元素，将其与n-1个元素中作任意一个交换(包括第2个元素自己)
        c,重复上面步骤，直到剩1个元素为止

实现：
public static void Shuffle<T>(this IList<T> list)
{
    Random rng = new Random();
    int n = list.Count;
    while (n > 1)
    {
        n--;
        int k = rng.Next(n + 1);
        T value = list[k];
        list[k] = list[n];
        list[n] = value;
    }
}









