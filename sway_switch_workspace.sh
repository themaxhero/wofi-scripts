#!/bin/bash

_MSG_BIN=swaymsg
_PROGRAM=wofi

function gen_workspaces()
{
    $_MSG_BIN -t get_workspaces | tr ',' '\n' | grep "name" | sed 's/"name":"\(.*\)"/\1/g; s/"name": "//g; s/"//g' | sort -n
}

_WORKSPACE=$( (echo empty; gen_workspaces)  | $_PROGRAM -dmenu -p "Select workspace:")

if [ x"empty" = x"${_WORKSPACE}" ]
then
    wofi_empty_workspace.sh
elif [ -n "${_WORKSPACE}" ]
then
    $_MSG_BIN workspace "${_WORKSPACE}"
fi
