#!/bin/bash
for f in "$@"; do printf %s\\n "${f}"; done
