#!/bin/bash

FILES="manifests/init.pp\
 manifests/core.pp\
 manifests/shared_lib.pp"
puppet strings generate $FILES --format markdown -o REFERENCE.MD

