#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <windows.h>

//SAMUEL CHAVES DE SÁ(20231SI0011)

void merge(int arr[], int p, int q, int r) {
    int n1 = q - p + 1;
    int n2 = r - q;
    int *L = (int *)malloc(n1 * sizeof(int));
    int *R = (int *)malloc(n2 * sizeof(int));

    for (int i = 0; i < n1; i++)
        L[i] = arr[p + i];
    for (int j = 0; j < n2; j++)
        R[j] = arr[q + 1 + j];

    int i = 0, j = 0, k = p;
    while (i < n1 && j < n2) {
        if (L[i] <= R[j]) {
            arr[k] = L[i];
            i++;
        } else {
            arr[k] = R[j];
            j++;
        }
        k++;
    }

    while (i < n1) {
        arr[k] = L[i];
        i++;
        k++;
    }

    while (j < n2) {
        arr[k] = R[j];
        j++;
        k++;
    }

    free(L);
    free(R);
}

void mergeSort(int arr[], int p, int r) {
    if (p < r) {
        int q = (p + r) / 2;
        mergeSort(arr, p, q);
        mergeSort(arr, q + 1, r);
        merge(arr, p, q, r);
    }
}

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
    }
}

int main()
{
    int n =1000000, p=0;

    int *arr1,*arr2;
    //memset(&arr, 0, sizeof(int));
    arr1 = (int *)malloc(n * sizeof(int));
    if (arr1 == NULL) {
        printf("Erro na alocação de memória.\n");
        return 1;
    }
    arr2 = (int *)malloc(n * sizeof(int));
    if (arr2 == NULL) {
        printf("Erro na alocação de memória.\n");
        return 1;
    }

    for (int i = 0; i < n; i++) {
        int r = rand();
        arr1[i] = r;
        arr2[i] = r;
    }

    clock_t inicioM = clock();

    mergeSort(arr1,p,n-1);

    clock_t fimM = clock();

    double tempo_totalM = (double)(fimM - inicioM)/CLOCKS_PER_SEC;

    printf("\n\nTempo de execucao do merge sort: %.4f segundos\n", tempo_totalM);

    clock_t inicioI = clock();

    insertionSort(arr2,n);

    clock_t fimI = clock();

    double tempo_totalI = (double)(fimI - inicioI)/CLOCKS_PER_SEC;

    printf("\n\nTempo de execucao do insertion sort: %.4f segundos\n", tempo_totalI);

    //VER TODOS OS ELEMENTOS NO FINAL DO INSERTION SORT
    /*
    printf("Array ordenado (%d elementos):\n",n);
    for (int i = 0; i < n; i++) {
        printf("%d ", arr[i]);
    }
    */

    free(arr1);
    free(arr2);

    //Som pra avisar que terminou
    //Beep(523,2000);
    return 0;
}
