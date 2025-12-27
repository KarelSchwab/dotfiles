package config

import (
	"fmt"
	"os"
	"path/filepath"

	"github.com/go-git/go-git/v6"
)

// Config holds the configuration for the dotfiles manager,
// including the binary directory and list of dotfiles to manage.
type Config struct {
	// BinDir is the directory where binary scripts and executables are stored.
	BinDir string `mapstructure:"binDir"`
	// Dotfiles is a list of dotfile configurations to be symlinked or managed.
	Dotfiles []Dotfile `mapstructure:"dotfiles"`
	// Repos is a list of git repositories to cloned or managed.
	Repos []GitRepo `mapstructure:"repos"`
}

// Expands environment variables in the BinDir and dotfile destination paths,
// converts relative source paths to absolute paths based on the current working directory,
// and validates that all paths are safe (not empty, root, or home directory).
func (config *Config) ExpandEnvs() error {
	config.BinDir = os.ExpandEnv(config.BinDir)

	cwd, err := os.Getwd()
	if err != nil {
		return fmt.Errorf("unable to get current working directory: %w", err)
	}

	homeDir := os.Getenv("HOME")
	for i := range config.Dotfiles {
		source := filepath.Join(cwd, config.Dotfiles[i].Source)
		if source == "" || source == "/" || source == homeDir {
			return fmt.Errorf("dotfile source cannot be empty, root (/), or your home directory: %s",
				config.Dotfiles[i].Source)
		}

		destination := os.ExpandEnv(config.Dotfiles[i].Destination)
		if destination == "" || destination == "/" || destination == homeDir {
			return fmt.Errorf("dotfile destination cannot be empty, root (/), or your home directory: %s", config.Dotfiles[i].Destination)
		}

		config.Dotfiles[i].Source = source
		config.Dotfiles[i].Destination = destination
	}

	for i := range config.Repos {
		destination := os.ExpandEnv(config.Repos[i].Destination)
		if destination == "" || destination == "/" || destination == homeDir {
			return fmt.Errorf("git repository destination cannot be empty, root (/), or your home directory: %s", config.Repos[i].Destination)
		}
		config.Repos[i].Destination = destination
	}

	return nil
}

// Represents a single dotfile configuration with its name, source path, and destination path.
type Dotfile struct {
	// Name is the identifier for this dotfile configuration.
	Name string `mapstructure:"name"`
	// Source is the path to the dotfile in the repository (relative to project root).
	Source string `mapstructure:"source"`
	// Destination is the path where the dotfile should be symlinked in the filesystem.
	Destination string `mapstructure:"destination"`
}

// Deletes the file, directory, or symlink at the destination path.
func (dotfile *Dotfile) Remove() error {
	if err := os.RemoveAll(dotfile.Destination); err != nil {
		return fmt.Errorf("failed to remove %s: %w", dotfile.Destination, err)
	}

	return nil
}

// Creates a symbolic link from the source path to the destination path.
func (dotfile *Dotfile) CreateSymlink() error {
	if err := os.Symlink(dotfile.Source, dotfile.Destination); err != nil {
		return fmt.Errorf("unable to create symlink from %s to %s: %w", dotfile.Source, dotfile.Destination, err)
	}
	return nil
}

// Represents a git repository configuration with its name, URL, and destination path.
type GitRepo struct {
	// Name is the identifier for this git repository.
	Name string
	// Url is the URL of the git repository to clone.
	Url string
	// Destination is the path where the repository should be cloned.
	Destination string
}

// Clones the git repository to the specified destination path.
func (gitRepo *GitRepo) Clone() error {
	_, err := git.PlainClone(gitRepo.Destination, &git.CloneOptions{URL: gitRepo.Url})

	if err != nil {
		return fmt.Errorf("unable to clone git repository %s to %s: %w", gitRepo.Url, gitRepo.Destination, err)
	}

	return nil
}
