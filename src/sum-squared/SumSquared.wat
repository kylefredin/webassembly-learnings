(module
  ;; define and export a function called "SumSquared"
  (func (export "SumSquared")
    ;; this function accepts two parameters, both are 32-bit integers
    (param $value_1 i32) (param $value_2 i32)

    ;; define a result which will be a 32-bit integer
    (result i32)

    ;; define a local variable which will be a 32-bit integer
    (local $sum i32)

    ;; add the value_1 and value_2 values together and push the result onto the stack
    (i32.add (local.get $value_1) (local.get $value_2))

    ;; pop the last value off the stack and set it as the local variable "sum"
    local.set $sum

    ;; multiply the sum values and push the result onto the stack
    (i32.mul (local.get $sum) (local.get $sum))
  )
)