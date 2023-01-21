package test

import "fmt"

func factorial(n int) string {

	var result = 1
	for i := 1; i <= n; i++ {
		result *= i
	}
	return fmt.Sprintf("%v", result)
}
