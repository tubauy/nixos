#include <stdio.h>
#include <math.h>
#include <stdlib.h>
#include <stdbool.h>
int** alloc_td_arr(int x, int y) {
  int** res;
  res = malloc(x * sizeof(*res));
  for (int i = 0; i < x; i++) {
    res[i] = malloc(y * sizeof(res[0]));
  }
  return res;
}
void free_td_arr(int x, int** arr) {
  for (int i = 0; i < x; i++) {
    free(arr[i]);
  }
  free(arr);
}
bool eq_arr(int len, int* arr1, int* arr2) {
  for (int i=0; i<len; i++) {
    if (arr1[i] != arr2[i]) {return false;};
  }
  return true;
}

int next(int len, int* arr, int* goal) {
  if (eq_arr(len, arr, goal)) {
    return 1;
  } 
  else {
    int n;
    int prev;
    for (int i=0; i<len; i++) {
      if (arr[i] >= goal[i]) {continue;}
      n = i;
      prev = arr[i];
      break;
    }
    for (int j=n; j>=0;j--) {
      arr[j] = 1; 
    }
    arr[n] = prev+1;
    return 0;
  }
}
int cpy_arr(int len, int* x, int* y) {
  for (int i=0; i<len; i++) {
    y[i] = x[i];
  }
}
int fill_rolls(int inlen, int len, int** res) {
  int current[inlen];
  int goal[inlen];
  for (int i=0; i<inlen; i++) {
    current[i]=1;
  }
  for (int i=0; i<inlen; i++) {
    goal[i]=6;
  }
  for (int i=0; i<len; i++) {
    cpy_arr(inlen, current, res[i]);
    if (next(inlen, current, goal)==1) {
      return 1;
    }
  }
  return 0;
}
void sum(int inlen, int len, int* res, int** arr, int bns) {
  int sum;
  for (int i=0;i<len;i++) {
    sum = 0;
    for (int j=0;j<inlen;j++) {
      sum += arr[i][j];
    }
    res[i] = sum+bns;
  }
}
void compare_arr(int len1, int* arr1, int len2, int* arr2, int* res) {
  for (int i=0; i<len1; i++) {
    for (int j=0; j<len2; j++){
      if (arr1[i] == arr2[j]) {
        res[1] += 1; 
      }
      else if (arr1[i] < arr2[j]) {
        res[2] += 1;
      }
      else if (arr1[i]>arr2[j]){
        res[0] += 1;
      }
    }
  }
}
int main() {
  int dc1;
  printf("First players dice count: ");
  scanf("%d", &dc1);

  int bns1;
  printf("First players bonus: ");
  scanf("%d", &bns1);
  
  int dc2;
  printf("Second players dice count: ");
  scanf("%d", &dc2);

  int bns2;
  printf("First players bonus: ");
  scanf("%d", &bns2);

  int pc1 = (int) pow(6, dc1);

  int pc2 = (int) pow(6, dc2);

  int** er1;
  er1 = alloc_td_arr(pc1, dc1);
  
  int** er2;
  er2 = alloc_td_arr(pc2, dc2);

  int r1[pc1];
    //printf("%d\n", sizeof(rs1));
  int r2[pc2];
    //printf("%d\n", sizeof(rs2));
  fill_rolls(dc1, pc1, er1);
  sum(dc1,pc1,r1,er1,bns1);
  
  fill_rolls(dc2, pc2, er2);
  sum(dc2,pc2,r2,er2,bns2);
  
  unsigned int result[3] = {0,0,0};
  compare_arr(pc1,r1,pc2,r2,result);

  for (int i=0; i<3;i++){
    printf("%d,\n", result[i]);
  }

  free_td_arr(pc1, er1);

  free_td_arr(pc2, er2);

  return 0;
}

