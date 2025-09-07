#!/bin/bash
route=$1
tr '?#@&' ';' < "$route" | tr ':|' '='




