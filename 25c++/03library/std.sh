STD:
    STL（Standard Template Library，标准模板库)是惠普实验室开发的一
            系列软件的统称
    
    STL的代码从广义上讲分为三类：algorithm（算法）、container（容器）和
            iterator（迭代器），几乎所有的代码都采用了模板类和模版函数的方式
            放到13个头文件中：
                <algorithm>、<deque>、<functional>、<iterator>、<vector>、
                <list>、<map>、 <memory>、<numeric>、<queue>、<set>、
                <stack> <utility>
    算法：
            算法部分主要由头文件<algorithm>，<numeric>和<functional>
                <algorithm>常用到的功能范围涉及到比较、交换、查找、遍历
                    操作、复制、 修改、移除、反转、排序、合并等等。
                <numeric>体积很小，只包括几个在序列上面进行简单数学运算的
                    模板函数，包括加法和乘法在序列上的一些操作。
                <functional>中则定义了一些模板类，用以声明函数对象。

    容器:
            主要由头文件<vector>,<list>,<deque>,<set>,<map>,<stack>和
                    <queue>组成
                
                向量(vector) 连续存储的元素<vector>
                列表(list)       由节点组成的双向链表，每个结点包含着一个
                        元素<list>
                双队列(deque) 连续存储的指向不同元素的指针所组成的数组
                        <deque>
                集合(set) 由节点组成的红黑树，每个节点都包含着一个元素，
                    节点之间以某种作用于元素对的谓词排列，没有两个不同的
                    元素能够拥有相同的次序 <set>
                多重集合(multiset) 允许存在两个次序相等的元素的集合 <set>
                栈(stack) 后进先出的值的排列 <stack>
                队列(queue) 先进先出的执的排列 <queue>
                优先队列(priority_queue) 元素的次序是由作用于所存储的值对
                    上的某种谓词决定的的一种队列 <queue>
                映射(map) 由{键，值}对组成的集合，以某种作用于键对上的谓词
                    排列 <map>
                多重映射(multimap) 允许键对有相等的次序的映射 <map>
    迭代器:
            主要由头文件<utility>,<iterator>和<memory>组成
            <utility>是一个很小的头文件，它包括了贯穿使用在STL中的几个
                    模板的声明，
            <iterator>中提供了迭代器使用的许多方法，
            <memory>它以不同寻常的方式为容器中的元素分配存储空间，同时也为
                某些算法执行期间产生的临时对象提供机制,<memory>中的主要部
                分是模板类allocator，它负责产生所有容器中的默认分配器









