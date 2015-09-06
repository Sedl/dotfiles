#!/bin/sh

if amixer sget Master|grep '\[off\]' 1>/dev/null; then
    amixer sset Master on
    amixer sset Headphone on
else
    amixer sset Master off
fi
