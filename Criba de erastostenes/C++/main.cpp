#include <iostream>
#include "Array.h"

using namespace std;

int main(){
    Array array(1000);
    array.print();
    array.criba();    
    array.print();
    return 0;
}