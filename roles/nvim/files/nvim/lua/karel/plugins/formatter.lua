return {
    "mhartington/formatter.nvim",
    config = function ()
        require("formatter").setup(
            {
                filetype = {
                    rust = {
                        -- Rustfmt
                        function()
                            return {
                                exe = "rustfmt",
                                args = {"--emit=stdout", "--edition=2021"},
                                stdin = true
                            }
                        end
                    },
                    javascript = {
                        -- prettier
                        function()
                            return {
                                exe = "prettier",
                                args = {
                                    "--stdin-filepath",
                                    vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)),
                                    "--double-quote",
                                    "--use-tabs"
                                },
                                stdin = true
                            }
                        end
                    },
                    typescript = {
                        -- prettier
                        function()
                            return {
                                exe = "prettier",
                                args = {
                                    "--stdin-filepath",
                                    vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)),
                                    "--double-quote",
                                    "--use-tabs"
                                },
                                stdin = true
                            } end
                    },
                    json = {
                        function()
                            return {
                                exe = "prettier",
                                args = {
                                    "--stdin-filepath",
                                    vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)),
                                    "--double-quote",
                                    "--use-tabs"
                                },
                                stdin = true
                            }
                        end
                    },
                    vue = {
                        function()
                            return {
                                exe = "prettier",
                                args = {
                                    "--stdin-filepath",
                                    vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)),
                                    "--double-quote",
                                    "--use-tabs"
                                },
                                stdin = true
                            }
                        end
                    },
                    go = {
                        function()
                            return {
                                exe = "gofmt",
                                args = {"-w"},
                                stdin = false
                            }
                        end
                    },
                    python = {
                        function()
                            return {
                                exe = "python3 -m autopep8",
                                args = {
                                    "--in-place --aggressive --aggressive",
                                    vim.fn.fnameescape(vim.api.nvim_buf_get_name(0))
                                },
                                stdin = false
                            }
                        end
                    },
                    lua = {
                        -- luafmt
                        function()
                            return {
                                exe = "luafmt",
                                args = {"--indent-count", 4, "--stdin"},
                                stdin = true
                            }
                        end
                    },
                    svelte = {
                        -- prettier
                        function()
                            return {
                                exe = "prettier",
                                args = {
                                    "--stdin-filepath",
                                    vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)),
                                    "--double-quote",
                                    "--use-tabs"
                                },
                                stdin = true
                            }
                        end
                    },
                    cpp = {
                        -- prettier
                        function()
                            return {
                                exe = "clang-format",
                                args = {
                                    "-style=file",
                                    "-i",
                                    vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)) }
                            }
                        end
                    },
                    java = {
                        function()
                            return {
                                exe = "java",
                                stdin = true,
                                args = {
                                    "-jar",
                                    "/home/karel/.local/bin/format.jar",
                                    vim.fn.expand('%')
                                }
                            }
                        end
                    }
                }
            }
        )
    end
}
