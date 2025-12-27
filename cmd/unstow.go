package cmd

import (
	"fmt"
	"slices"

	"github.com/spf13/cobra"
)

var fileNamesToUnstow []string

var unstowCmd = &cobra.Command{
	Use:   "unstow",
	Short: "Remove symlinks of dotfiles",
	RunE: func(cmd *cobra.Command, args []string) error {
		for _, dotfile := range AppConfig.Dotfiles {
			if len(fileNamesToUnstow) > 0 && !slices.Contains(fileNamesToUnstow, dotfile.Name) {
				continue
			}

			err := dotfile.Remove()
			if err != nil {
				return err
			}
			fmt.Println("unstowed", dotfile.Destination)
		}

		return nil
	},
}

func init() {
	unstowCmd.Flags().StringSliceVarP(&fileNamesToUnstow, "files", "f", []string{}, "List of specific dotfiles to unstow")
	rootCmd.AddCommand(unstowCmd)
}
