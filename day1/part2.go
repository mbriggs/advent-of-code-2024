package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
	"strings"

	"github.com/mbriggs/advent-of-code-2024/cmds"
)

func Part2(input *os.File) error {
	defer input.Close()

	var list1 []int
	list2Freq := make(map[int]int)

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
		list2Freq[id2]++
	}

	if err := scanner.Err(); err != nil {
		return fmt.Errorf("scanning file: %w", err)
	}

	var total int

	for _, id := range list1 {
		dist := id * list2Freq[id]
		total += dist
	}

	cmds.Successf("similarity: %d\n", total)

	return nil
}
