#!/bin/bash

set -e

#####
# Unit Tests

echo "DumpRenderTree test/tests_browser.html"
results=`DumpRenderTree test/tests_browser.html 2>&1`

echo "$results" | grep CONSOLE

echo $results | grep 'unittest-suite-success' >/dev/null

echo $results | grep -v 'Exception: Some tests failed.' >/dev/null

#####
# Type Analysis

echo
echo "dart_analyzer lib/*.dart"

results=`dart_analyzer lib/*.dart 2>&1`
EXITCODE=$?
echo "$results"
echo "EXITCODE $EXITCODE"
# Less strict with dart_analyzer until dartium is patched
#if [ -n "$results" ]; then
#    exit 1
if [ $EXITCODE -ne 0 ]; then
    exit 1
else
    echo "Passed analysis."
fi
