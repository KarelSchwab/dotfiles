#!/bin/bash

ansible-playbook main.yml --skip-tags personal --ask-become-pass
