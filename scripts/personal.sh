#!/bin/bash

ansible-playbook main.yml --skip-tags work --ask-become-pass
