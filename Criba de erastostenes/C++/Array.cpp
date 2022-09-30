#include "Array.h"
#include <iostream>
#include <math.h>
using namespace std;
Array::Array(int n){
    size = n;
    ar = new int[size];

    for(int i=2; i<=size; i++){
        ar[i] = i;
    }
}

int Array::read(int x){
    return ar[x];
}

void Array::write(int x, int n){
    ar[x] = n;
}

void Array::print(){
    cout << "[ ";
    for(int i=2; i<=size; i++){
        cout << ar[i] << " ";
    }
    cout << " ]" << endl;
}

void Array::criba(){
   for(int i=2; i<=size; i++){
       for(int j=2; j<=size; j++){
           if((i*j)<=size){
               ar[i*j]=0;
           }           
       }
   }
   cout << endl;
}