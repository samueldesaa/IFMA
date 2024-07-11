#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <windows.h>

void insertionSort(int arr[], int n) {
    int i, key, j;
    double cont=0;
    for (j = 1; j < n; j++) {
        key = arr[j];
        i = j - 1;

        while (i >= 0 && arr[i] > key) {
            arr[i + 1] = arr[i];
            i--;
        }
        arr[i + 1] = key;
        cont+=1;
        //PORCENTAGEM
        //printf("%.2f\n",(cont/(double)n)*100);
    }
}

int main() {
    int n = 1000000;
    int *arr = (int *)malloc(n * sizeof(int));
    if (arr == NULL) {
        printf("Erro na alocação de memória.\n");
        return 1;
    }

    for (int i = 0; i < n; i++) {
        arr[i] = rand();
    }
    clock_t inicio = clock();

    insertionSort(arr, n);

    clock_t fim = clock();

    double tempo_total = (double)(fim - inicio)/CLOCKS_PER_SEC;

    //VER TODOS OS ELEMENTOS NO FINAL DO INSERTION SORT
    /*
    printf("Array ordenado (%d elementos):\n",n);
    for (int i = 0; i < n; i++) {
        printf("%d ", arr[i]);
    }
    */
    free(arr);

    printf("\n\nTempo de execucao do insertion sort: %.4f segundos\n", tempo_total);
    //Som pra avisar que terminou
    //Beep(523,2000);
    return 0;
}
