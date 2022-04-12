(module
  ;; define and export a function named "AddInt"
  (func (export "AddInt")

  ;; function accepts 2 parameters which are 32-bit integers
  (param i32) (param i32)

  ;; define the return value type
  (result i32)
    ;; push the first provided value onto the stack
    local.get 0

    ;; push the second provided value onto the stack
    local.get 1

    ;; pop the last two numbers off the stack
    ;; add them
    ;; push the result back onto the stack
    ;; which will be used as the return value
    i32.add
  )
)