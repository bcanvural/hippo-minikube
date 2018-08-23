#!/usr/bin/env bash
function shutdown(){
    echo "Killing..."
    trap - SIGINT SIGTERM
    kill $child1
    wait $child1
    kill $child2
    wait $child2
}
trap shutdown SIGINT SIGTERM

for i in `seq 1 10`; do http hippo.site > /dev/null; done &
child1=$!
for i in `seq 1 10`; do http hippo.site > /dev/null; done &
child2=$!
wait $child1 $child2