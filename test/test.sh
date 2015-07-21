#!/bin/bash

trap '[ $? -eq 3 ] && echo hello' EXIT

exit 1
