package main

import (
	"bufio"
	"errors"
	"fmt"
	"os"
	"sort"
	"strconv"
	"strings"

	"github.com/mbriggs/advent-of-code-2024/cmds"
)

func main() {
	cmds.FilePath = "day1/day1_data.txt"
	cmds.Register("pt1", Part1)

	cmds.Run()
}

var ErrTooManyIDs = errors.New("did not get two ids on line")

func Part1(input *os.File) error {
	defer input.Close()

	var list1, list2 []int

	scanner := bufio.NewScanner(input)
	for scanner.Scan() {
		line := scanner.Text()
		ids := strings.Fields(line)

		if len(ids) != 2 {
			return fmt.Errorf("%s: %w", line, ErrTooManyIDs)
		}

		id1, err := strconv.Atoi(ids[0])
		if err != nil {
			return fmt.Errorf("parsing id1 from line %s: %w", line, err)
		}

		id2, err := strconv.Atoi(ids[1])
		if err != nil {
			return fmt.Errorf("parsing id2 from line %s: %w", line, err)
		}

		list1 = append(list1, id1)
		list2 = append(list2, id2)
	}

	if err := scanner.Err(); err != nil {
		return fmt.Errorf("scanning file: %w", err)
	}

	sort.Ints(list1)
	sort.Ints(list2)

	var total int

	for i := 0; i < len(list1); i++ {
		dist := abs(list1[i] - list2[i])
		total += dist
	}

	cmds.Successf("total distance: %d\n", total)

	return nil
}

func abs(x int) int {
	if x < 0 {
		return -x
	}
	return x
}
