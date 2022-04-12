(module
  ;; import a function from the calling JavaScript
  ;; called "external_call" which returns a 32-bit integer
  (import "js" "external_call" (func $external_call (result i32)))

  ;; define a mutable global variable
  ;; generally considered bad practice, but this is just a test
  (global $i (mut i32) (i32.const 0))

  (func $internal_call (result i32)
    ;; push the global i value onto the stack
    global.get $i

    ;; push the value 1 onto the stack
    i32.const 1

    ;; pop the last 2 values off the stack and add them
    ;; push the result onto the stack
    i32.add

    ;; pop the last value off the stack and set the global i value
    global.set $i

    ;; push the new i value onto the stack
    ;; this value will be returned to the caller
    global.get $i
  )

  ;; define and export a function called "wasm_call"
  (func (export "wasm_call")
    ;; define a loop with the label "again"
    (loop $again
      ;; call the "internal_call" function
      ;; the returned value is either on the stack already
      ;; or will be pushed onto the stack at this point
      call $internal_call

      ;; push the value 4 million onto the stack
      i32.const 4_000_000

      ;; pop the last 2 values off the stack
      ;; this assumes the 2 values are positive, so we use the unsigned version
      ;; push 1 onto the stack if "internal_call" returned a value less than or equal to 4 million
      ;; push 0 onto the stack if "internal_call" returned a value more than 4 million
      i32.le_u

      ;; if the last value in the stack is 1, go back to the "again" label
      ;; if the last value in the stack is 0, break out of the loop
      br_if $again
    )
  )

  ;; define an export a function called "js_call"
  (func (export "js_call")
    ;; define a loop with the label "again"
    (loop $again
      ;; call the imported "external_call" function
      (call $external_call)
      ;; push the value 4 million onto the stack
      i32.const 4_000_000
      ;; pop the last 2 values off the stack
      ;; this assumes the 2 values are positive, so we use the unsigned version
      ;; push 1 onto the stack if "internal_call" returned a value less than or equal to 4 million
      ;; push 0 onto the stack if "internal_call" returned a value more than 4 million
      i32.le_u
      ;; if the last value in the stack is 1, go back to the "again" label
      ;; if the last value in the stack is 0, break out of the loop
      br_if $again
    )
  )
)
