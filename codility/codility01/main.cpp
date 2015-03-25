#include <iostream>
using namespace std;

int a[10]={0};
bool use[10]={0};

void pout(int n)
{
   if(n>=9)
   {
       for(int i=0 ; i<9 ; ++i )
       {
        cout<<a[i];
        cout<<endl;
       }
   }

   for(int i=0 ; i<9 ; ++i )
   {
       if(use[i]) continue;
       use[i]=1;
       a[i]=a[i+1];
       pout(a[i+1]);
       use[i]=0;
   }
}

int main()
{
    pout(21);

    return 0;
}
