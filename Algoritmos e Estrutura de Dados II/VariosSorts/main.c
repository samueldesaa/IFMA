#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <windows.h>

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

int findMax(int arr[], int n) {
    int max = arr[0];
    for (int i = 1; i < n; i++) {
        if (arr[i] > max) {
            max = arr[i];
        }
    }
    return max;
}

void radixSort(int arr[], int n) {
    int max = findMax(arr, n);
    int exp;
    for (exp = 1; max / exp > 0; exp *= 10) {
        int output[n];
        int count[10] = {0};

        for (int i = 0; i < n; i++) {
            count[(arr[i] / exp) % 10]++;
        }

        for (int i = 1; i < 10; i++) {
            count[i] += count[i - 1];
        }

        for (int i = n - 1; i >= 0; i--) {
            output[count[(arr[i] / exp) % 10] - 1] = arr[i];
            count[(arr[i] / exp) % 10]--;
        }

        for (int i = 0; i < n; i++) {
            arr[i] = output[i];
        }
    }
}

int main()
{
    int n = 500000;
    int *arr = (int *)malloc(n * sizeof(int));
    if (arr == NULL) {
        printf("Erro na alocação de memória.\n");
        return 1;
    }

    int *arr2 = (int *)malloc(n * sizeof(int));
    if (arr2 == NULL) {
        printf("Erro na alocação de memória.\n");
        return 1;
    }

    int *arr3 = (int *)malloc(n * sizeof(int));
    if (arr3 == NULL) {
        printf("Erro na alocação de memória.\n");
        return 1;
    }


    for (int i = 0; i < n; i++) {
        arr[i] = rand();
        arr2[i] = rand();
        arr3[i] = rand();
    }

    clock_t inicio = clock();

    radixSort(arr, n);

    clock_t fim = clock();

    double tempo_total = (double)(fim - inicio)/CLOCKS_PER_SEC;

    printf("O Radix Sort ordenou em: %.3f segundos\n",tempo_total);
    free(arr);

    inicio = clock();

    mergeSort(arr2, 0, n);

    fim = clock();

    tempo_total = (double)(fim - inicio)/CLOCKS_PER_SEC;

    printf("O Merge Sort ordenou em: %.3f segundos\n",tempo_total);
    free(arr2);

    inicio = clock();

    insertionSort(arr3, n);

    fim = clock();

    tempo_total = (double)(fim - inicio)/CLOCKS_PER_SEC;

    printf("O Insertion Sort ordenou em: %.3f segundos",tempo_total);
    free(arr3);

    //VER TODOS OS ELEMENTOS NO FINAL DO INSERTION SORT
    /*
    printf("\nArray ordenado (%d elementos):\n",n);
    for (int i = 0; i < n; i++) {
        printf("%d ", arr2[i]);
    }
    */

    //Beep(500,3000);

    return 0;
}
