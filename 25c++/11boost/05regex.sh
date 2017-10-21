 including <boost/regex.hpp> and have linked to the boost_regex library.


#include <iostream>
#include <string>
#include <boost/regex.hpp>

int main(){
  std::string str = "hellooooooooo";
  std::string newtext = "o Bob";
  boost::regex re("ooooooooo");
  std::cout << str << std::endl;

  std::string result = boost::regex_replace(str, re, newtext);
  std::cout << result << std::endl;
}

Output

hellooooooooo

hello Bob
