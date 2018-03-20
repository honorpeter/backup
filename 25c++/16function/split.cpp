#include <iostream>
using std::cout; using std::getline;
#include <iterator>
using std::ostream_iterator;
#include <string>
using std::string;
#include <sstream>
using std::istringstream;
#include <vector>
using std::vector;
#include <algorithm>
using std::copy;

vector<string> &split(const string &str, char delim, vector<string> &elems, bool skip_empty = true) {
    istringstream iss(str);
    for (string item; getline(iss, item, delim); )
        if (skip_empty && item.empty()) continue;
        else elems.push_back(item);
    return elems;
}

int main()
{
    string str("Windows,Linux,,MacOS,");
    vector<string> result;
    split(str, ',', result);
    copy(result.begin(), result.end(), ostream_iterator<string>(cout, "\n"));
    return 0;
}
