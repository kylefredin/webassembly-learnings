(module
  ;; inform webassemly of an imported function called log which
  ;; accepts two 32-bit integers as arguments
  (import "env" "log" (func $log (param i32 i32)))

  ;; define the "loop_test" function
  (func $loop_test (export "loop_test") (param $n i32)
    ;; define the return type of this function as a 32-bit integer
    (result i32)

    ;; define local variable $i which is a 32-bit integer
    (local $i i32)

    ;; define local variable $factorial which is a 32-bit integer
    (local $factorial i32)

    ;; set local variable $factorial with a default value of 1
    ;; and push it onto the stack
    (local.set $factorial (i32.const 1))

    ;; start the loop
    (loop $continue
      ;; start a block which can break out of the loop
      (block $break
        ;; i = i + 1
        (local.set $i (i32.add (local.get $i) (i32.const 1)))

        ;; factorial = i * factorial
        (local.set $factorial (i32.mul (local.get $i) (local.get $factorial)))

        ;; call the imported log function with the value for i and factorial
        (call $log (local.get $i) (local.get $factorial))

        ;; break out of the loop if $i === $n
        (br_if $break (i32.eq (local.get $i) (local.get $n)))

        ;; if we didn't break out of the loop, continue back at the top
        br $continue
      )
    )

    ;; return $factorial back to calling JavaScript
    local.get $factorial
  )
)