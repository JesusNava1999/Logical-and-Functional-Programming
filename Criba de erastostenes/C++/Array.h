#ifndef Array_h
#define Array_h
class Array{
    int* ar;
    int size;
public:
    Array(int);
    int read(int);
    void write(int,int);
    void print(); 

    void criba();   
};
#endif 