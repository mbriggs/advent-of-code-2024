package cmds

import (
	"errors"
	"fmt"
	"os"
)

var ErrCommandNotFound = errors.New("command not found in registry")
var ErrFilePathNotSet = errors.New("cmds.FilePath not set")

// Command to run an advent of code problem. Takes a file handle for the input
// of the current day.
type Command func(*os.File) error

var registry = make(map[string]Command)
var FilePath string

// Register a command to run by name
func Register(name string, cmd Command) {
	registry[name] = cmd
}

// RunCommand by name, returning ErrCommandNotFound if not found,
// ErrFilePathNotSet if FilePath was not set before running, and any error the
// command itself may return
func RunCommand(name string) error {
	cmd, found := registry[name]

	if !found {
		return fmt.Errorf("looking for %s: %w", name, ErrCommandNotFound)
	}

	if FilePath == "" {
		return ErrFilePathNotSet
	}

	file, err := os.Open(FilePath)
	if err != nil {
		return fmt.Errorf("opening file: %w", err)
	}

	err = cmd(file)

	return err
}

// Run a command passed in as an arg to the process, print errors in red
func Run() {
	if len(os.Args) == 1 {
		fmt.Printf("Usage: go run ./day<n> <cmd>\n\tgo run ./day1 pt1\n\n")
		os.Exit(1)
	}

	name := os.Args[1]

	err := RunCommand(name)

	if errors.Is(ErrCommandNotFound, err) {
		Failuref("Could not find command %s. If it should be there, be sure to call cmds.Register(\"%s\", func) in your main\n\n", name, name)
		Failuref("the following commands are registered in this dir:\n")
		for cmd := range registry {
			Failuref("- %s\n", cmd)
		}
		fmt.Println()
		os.Exit(1)
	}

	if err != nil {
		Failuref("error running %s: %s\n", name, err)
		os.Exit(1)
	}
}

func Failuref(format string, a ...interface{}) {
	fmt.Printf("\033[31m"+format+"\033[0m", a...)
}

func Successf(format string, a ...interface{}) {
	fmt.Printf("\033[32m"+format+"\033[0m", a...)
}
