package main

import "fmt"

func arr_eq(arr1, arr2 []int) bool {
	for i := range arr1 {
		if arr1[i] != arr2[i] {
			return false
		}
	}
	return true
}
func next(x *[]int, g []int) bool {
	if arr_eq(*x, g) {
		return false
	} else {
		var n, prev int
		for i := 0; i < len(*x); i++ {
			if (*x)[i] >= g[i] {
				continue
			}
			n = i
			prev = (*x)[i]
			break
		}
		for j := n; j >= 0; j-- {
			(*x)[j] = 1
		}
		(*x)[n] = prev + 1
		return true
	}
}
func cpy_arr(x *[]int, y []int) {
	for i := 0; i < len(y); i++ {
		(*x)[i] = y[i]
	}
}
func fill_rolls(inlen int, res *[][]int) int {
	var current []int
	for i := 0; i < inlen; i++ {
		current = append(current, 1)
	}
	var goal []int
	for i := 0; i < inlen; i++ {
		goal = append(goal, 6)
	}
	for i := 0; i < len(*res); i++ {
		cpy_arr(&(*res)[i], current)
		if next(&current, goal) {
			return 1
		}
	}
	return 0
}
func sum(inlen int, res []int, arr [][]int, bns int) {
	var sum int
	for i := 0; i < len(arr); i++ {
		sum = 0
		for j := 0; j < inlen; j++ {
			sum += arr[i][j]
		}
		res[i] = sum + bns
	}
}
func compare_arr(arr1 []int, arr2 []int) []int {
	res := []int{0, 0, 0}
	for i := 0; i < len(arr1); i++ {
		for j := 0; j < len(arr2); j++ {
			if arr1[i] == arr2[j] {
				res[1] += 1
			} else if arr1[i] < arr2[j] {
				res[2] += 1
			} else if arr1[i] > arr2[j] {
				res[0] += 1
			}
		}
	}
	return res
}

func main() {
	var dc1, bns1, dc2, bns2 int
	fmt.Scan(&dc1)
	fmt.Scan(&bns1)
	fmt.Scan(&dc2)
	fmt.Scan(&bns2)
}
