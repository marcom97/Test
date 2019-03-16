if [ -d tests ]; then

declare -i command_passed=0
declare -i command_total=0
declare -i total_failed=0

for folder in tests/*; do
    [ -d "$folder" ] || continue
        
    COMMAND="${folder#tests/}"
    echo "Testing "$COMMAND":"
    
    command_passed=0
    command_total=0    
    for test in "$folder"/*; do
        [ -f "$test" ] || continue
        
        ARGS=''
        STDIN=''
        EXPECT=''
        source "$test"

        ACTUAL=$(./"$COMMAND" $ARGS <<< "$STDIN" 2>&1)

        if [ "$ACTUAL" == "$EXPECT" ]; then
            echo "Test ${test#"$folder"/}: PASSED"
            command_passed=$command_passed+1
        else
            echo "Test ${test#"$folder"/}: FAILED"
            echo EXPECTED:
            echo "$EXPECT"
            echo ACTUAL:
            echo "$ACTUAL"
            total_failed=$total_failed+1
        fi

        command_total=$command_total+1
    done
    echo TESTS PASSED: $command_passed / $command_total
    echo
done

if [ $total_failed == 0 ]; then
    echo ALL TESTS PASSED
elif [ $total_failed == 1 ]; then
    echo $total_failed TEST FAILED
else
    echo $total_failed TESTS FAILED
fi

fi
