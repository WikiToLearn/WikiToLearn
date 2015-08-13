#!/bin/bash

# This doesn't work, but it should, at a certain point.
# Debug if you have a minute... 
#curl -d "&offset=1&wpDownload&curonly&action=submit&templates&addcat&catname=Developer_Dump&addns&nsindex=8&pages=$(cat dump-list | hexdump -v -e '/1 "%02x"' | sed 's/\(..\)/%\1/g' )" http://en.wikifm.org/index.php?title=Special:Export -o "developer-dump.xml"

curl -d "&action=submit&pages=$(cat dump-list | hexdump -v -e '/1 "%02x"' | sed 's/\(..\)/%\1/g' )" http://en.wikifm.org/index.php?title=Special:Export -o "developer-dump.xml"

