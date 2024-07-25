package main

import (
	"math"
)

func next(current []int, target []int) []int {
	if len(current) != len(target) {
		return nil
	}
	length := len(current)
	for i, e := range current {
		if e == target[i] {
			if i+1 == length {
				return target
			}
			current[i] = 1
			continue
		} else if e < target[i] {
			result := current
			result[i]++
			return result
		}
	}
	return nil
}

func sum(arr []int) int {
	res := 0
	for _, j := range arr {
		res = res + j
	}
	return res
}

func rollsums(diceCount int, bonus int) []int {
	current := make([]int, diceCount)
	target := make([]int, diceCount)
	result := make([]int, int(math.Pow(float64(6), float64(diceCount))))
	for i := 0; i < diceCount; i++ {
		current[i] = 1
		target[i] = 6
	}
	for i := 0; i < int(math.Pow(float64(6), float64(diceCount))); i++ {
		result[i] = sum(current) + bonus
		current = next(current, target)
	}
	return result

}

func compare(x []int, y []int) []int {
	wins := 0
	draws := 0
	loses := 0
	for i := range x {
		for j := range y {
			if x[i] > y[j] {
				wins++
			} else if x[i] == y[j] {
				draws++
			} else if x[i] < y[j] {
				loses++
			}
		}
	}
	return []int{wins, draws, loses}
}

func prarray(input []int) {
	for _, j := range input {
		println(j)
	}
}

func main() {
	res1 := rollsums(3, 4)
	res2 := rollsums(4, 0)
	if res1 == nil || res2 == nil {
		prarray(res1)
		println("")
		prarray(res2)

		println("function failed somehow")
	}
	prarray(compare(res1, res2))
}
