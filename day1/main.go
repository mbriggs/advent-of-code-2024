package main

import (
	"errors"

	"github.com/mbriggs/advent-of-code-2024/cmds"
)

func main() {
	cmds.FilePath = "day1/day1_data.txt"
	cmds.Register("pt1", Part1)
	cmds.Register("pt2", Part2)

	cmds.Run()
}

var ErrTooManyIDs = errors.New("did not get two ids on line")

func abs(x int) int {
	if x < 0 {
		return -x
	}
	return x
}
