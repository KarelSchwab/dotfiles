package cmd

import (
	"log"
	"os"
	"slices"

	"github.com/spf13/cobra"
)

var reposToClone []string
var reposToSkip []string

var cloneCmd = &cobra.Command{
	Use:   "clone",
	Short: "Clones the configured git repos",
	RunE: func(cmd *cobra.Command, args []string) error {
		for _, repo := range AppConfig.Repos {
			if len(reposToClone) > 0 && !slices.Contains(reposToClone, repo.Name) || slices.Contains(reposToSkip, repo.Name) {
				log.Printf("skipping %s", repo.Name)
				continue
			}

			if _, err := os.Stat(repo.Destination); err == nil {
				remove, _ := cmd.Flags().GetBool("rm")
				if !remove {
					log.Printf("unable to clone %s: destination (%s) already exists. skipping", repo.Name, repo.Destination)
					continue
				}

				log.Printf("removing existing directory %s\n", repo.Destination)
				err := os.RemoveAll(repo.Destination)
				if err != nil {
					return err
				}
			}

			log.Printf("cloning %s to %s\n", repo.Name, repo.Destination)
			err := repo.Clone()
			if err != nil {
				return err
			}
			log.Printf("successfully cloned %s to %s\n", repo.Name, repo.Destination)
		}

		return nil
	},
}

func init() {
	cloneCmd.Flags().StringSliceVar(&reposToClone, "repos", []string{}, "List of repositories to clone")
	cloneCmd.Flags().StringSliceVar(&reposToSkip, "skip", []string{}, "List of repositories to skip")
	cloneCmd.Flags().Bool("rm", false, "Remove existing directories before cloning")
	rootCmd.AddCommand(cloneCmd)
}
