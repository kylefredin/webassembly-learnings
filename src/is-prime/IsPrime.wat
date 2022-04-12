(module
  ;; define the "even check" function
  ;; it accepts a 32-bit integer
  ;; and returns a 32-bit integer
  (func $even_check (param $n i32) (result i32)
    ;; push the local n value onto the stack
    local.get $n
    ;; push the value 2 onto the stack
    i32.const 2
    ;; pop the last 2 integers off the stack
    ;; and push the remainder of n / 2
    i32.rem_u
    ;; push the value 0 onto the stack
    i32.const 0
    ;; pop the last 2 integers off the stack and see if they are equal
    i32.eq
  )

  ;; define the "equals 2" function
  ;; it accepts a 32-bit integer
  ;; and returns a 32-bit integer
  (func $eq_2 (param $n i32) (result i32)
    ;; push the local n value onto the stack
    local.get $n
    ;; push the value 2 onto the stack
    i32.const 2
    ;; pop the last 2 integers off the stack and see if they are equal
    ;; returns 0 if n is not equal to 2
    ;; returns 1 if n is 2
    i32.eq
  )

  (func $multiple_check (param $n i32) (param $m i32) (result i32)
    ;; push the local n value onto the stack
    local.get $n
    ;; push the local m value onto the stack
    local.get $m
    ;; pop the last 2 integers off the stack
    ;; and push the remainder of n / m onto the stack
    i32.rem_u
    ;; push the value 0 onto the stack
    i32.const 0
    ;; pop the last 2 integers off the stack and see if they are equal
    ;; returns 0 if (n / m) !== 0
    ;; returns 1 if (n / m) === 0
    i32.eq
  )

  ;; define a function called isPrime for export only
  ;; function accepts a 32-bit integer
  ;; function returns a 32-bit integer
  (func (export "isPrime") (param $n i32) (result i32)
    ;; define a local variable called i which is a 32-bit integer
    (local $i i32)

    ;; check if the provided value n is equal to 1
    ;; if it is, return 0
    (if (i32.eq (local.get $n) (i32.const 1))
      (then
        i32.const 0
        return
      )
    )

    ;; call the eq_2 function with the provided n value
    ;; if the eq_2 function returns a non-zero value (1 would mean n === 2)
    ;; the following "then" block will be executed
    (if (call $eq_2 (local.get $n))
      (then
        ;; push the number 1 onto the stack
        ;; because 2 is a prime number
        i32.const 1
        return
      )
    )

    ;; start the block loop
    (block $not_prime
      ;; first check if the number provided is even
      (call $even_check (local.get $n))

      ;; if the number is even, break out of the not_prime block
      ;; and let the function return
      br_if $not_prime

      ;; start local $i at 1
      ;; this will pop the value off the stack
      (local.set $i (i32.const 1))

      ;; start the prime test loop
      (loop $prime_test_loop
        ;; set the local variable $i to $i + 2
        ;; we increment the i value by 2 because we know its an odd number
        ;; and we want to continue testing against odd numbers until
        ;; we meet/exceed the provided n value
        ;; we use local.tee here to set the value and push it onto the stack
        ;; if we used local.set here, the value would be popped off the stack
        (local.tee $i (i32.add (local.get $i) (i32.const 2)))

        ;; push the provided n value onto the stack
        local.get $n

        ;; this expression pops the last two values off the stack
        ;; and checks whether the value of i is greater than
        ;; or equal to the provided n value
        ;; if this evaluates to true, 1 is pushed onto the stack
        ;; if this evaluates to false, 0 is pushed onto the stack
        ;; NOTE:
        ;; we assume the values are unsigned integers because
        ;; negative numbers cannot be prime
        i32.ge_u

        ;; the if command pulls the last value off the stack
        ;; if the value is non-zero, it executes the code block
        if
          ;; push 1 onto the stack
          i32.const 1
          ;; return back to the caller
          return
        ;; end the if check
        end

        ;; call the multiple_check function
        ;; provide the local n and i variables
        ;; the result will be pushed onto the stack
        ;; multiple_check pushes 1 onto the stack if the value is divisible
        ;; multiple_check pushes 0 onto the stack if the value is NOT divisible
        (call $multiple_check (local.get $n) (local.get $i))

        ;; break out of block if the last value in the stack is non-zero
        br_if $not_prime

        ;; return back to the top of the "prime_test_loop" loop
        br $prime_test_loop
      ) ;; end loop
    ) ;; end block

    ;; return false
    i32.const 0
  )
)