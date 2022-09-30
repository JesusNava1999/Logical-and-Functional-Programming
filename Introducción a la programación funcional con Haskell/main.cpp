#include <iostream>

using namespace std;

int main() {
    int n;
   
    auto f = [&](int& a) -> int {
        int i = 1;
        while(i<=a){
            if((i%2)==0){
                cout << i << "\n";
            }
            i++;
        }
    };
    cin >> n;
    f(n);
    return 0;
}