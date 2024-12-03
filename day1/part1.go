package main

import (
	"bufio"
	"fmt"
	"os"
	"sort"
	"strconv"
	"strings"

	"github.com/mbriggs/advent-of-code-2024/cmds"
)

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
