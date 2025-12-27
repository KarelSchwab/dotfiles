package cmd

import (
	"fmt"
	"slices"

	"github.com/spf13/cobra"
)

var fileNames []string

var stowCmd = &cobra.Command{
	Use:   "stow",
	Short: "Symlink dotfiles",
	RunE: func(cmd *cobra.Command, args []string) error {
		for _, dotfile := range AppConfig.Dotfiles {
			if len(fileNames) > 0 && !slices.Contains(fileNames, dotfile.Name) {
				continue
			}

			if err := dotfile.Remove(); err != nil {
				return err
			}

			err := dotfile.CreateSymlink()
			if err != nil {
				return err
			}
			fmt.Println("stowed", dotfile.Destination)
		}

		return nil
	},
}

func init() {
	stowCmd.Flags().StringSliceVarP(&fileNames, "files", "f", []string{}, "List of specific dotfiles to stow")
	rootCmd.AddCommand(stowCmd)
}
