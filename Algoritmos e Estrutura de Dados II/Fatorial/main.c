#include <stdio.h>
#include <stdlib.h>

//SAMUEL CHAVES DE SÁ

void fatorialseq(int num){
    int i=num;
    double fat=1;
    while(i>1){
        fat=fat*i;
        i-=1;
    }
    printf("%.0f",fat);
}

double calcula_fatorialrec(double num){
    if(num<=1)
        return 1;
    else
        return num*calcula_fatorialrec(num-1);
}

int main()
{
    int n = 170;
    printf("n = %d\n",n);

    //MÁXIMO INT 170
    fatorialseq(n);

    printf("\n\n");

    //MÁXIMO INT 170
    printf("%.0f\n", calcula_fatorialrec(n));

    n = 171;
    printf("\nn = %d\n",n);

    //MÁXIMO INT 170
    fatorialseq(n);

    printf("\n\n");

    //MÁXIMO INT 170
    printf("%.0f", calcula_fatorialrec(n));

    //FATORIAL DE TODOS OS VALORES ATE N

    /*
    for(int i=0;i<=n;i++){
        printf("n = %d\n",i);

        fatorialseq(i);
        printf("\n\n");
        printf("%.0f", calcula_fatorialrec(i));
        printf("\n\n");
    }
    */
    return 0;
}



