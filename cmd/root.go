package cmd

import (
	"dotfiles/pkg/config"
	"fmt"
	"os"

	"github.com/spf13/cobra"
	"github.com/spf13/viper"
)

var AppConfig config.Config

var rootCmd = &cobra.Command{
	Use:   "dotfiles",
	Short: "A brief description of your application",
	PersistentPreRunE: func(cmd *cobra.Command, args []string) error {
		if err := readConfig(); err != nil {
			return err
		}

		if err := createBinDir(); err != nil {
			return err
		}

		return nil
	},
}

func Execute() {
	if err := rootCmd.Execute(); err != nil {
		os.Exit(1)
	}
}

func readConfig() error {
	viper.AddConfigPath(".")
	viper.SetConfigName("config")
	viper.SetConfigType("json")

	if err := viper.ReadInConfig(); err != nil {
		return fmt.Errorf("error reading config file: %w", err)
	}

	if err := viper.Unmarshal(&AppConfig); err != nil {
		return fmt.Errorf("error decoding config file: %w", err)
	}

	if err := AppConfig.ExpandEnvs(); err != nil {
		return fmt.Errorf("error expanding envs in config file: %w", err)
	}

	return nil
}

func createBinDir() error {
	return os.MkdirAll(AppConfig.BinDir, 0755)
}
