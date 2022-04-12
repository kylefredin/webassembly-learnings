(module
  ;; define a global variable and set it's value to the imported value
  (global $import_integer_32 (import "env" "import_i32") i32)

  ;; define a global variable and set it's value to the imported value
  (global $import_float_32 (import "env" "import_f32") f32)

  ;; define a global variable and set it's value to the imported value
  (global $import_float_64 (import "env" "import_f64") f64)

  ;; import a function which accepts a 32-bit integer
  (import "js" "log_i32" (func $log_i32 (param i32)))

  ;; import a function which accepts a 32-bit float
  (import "js" "log_f32" (func $log_f32 (param f32)))

  ;; import a function which accepts a 64-bit float
  (import "js" "log_f64" (func $log_f64 (param f64)))

  ;; define and export a function called "globaltest"
  (func (export "globaltest")
    ;; call the log_i32 function
    ;; push the import_integer_32 global variable onto the stack
    (call $log_i32 (global.get $import_integer_32))

    ;; call the log_f32 function
    ;; push the import_float_32 global variable onto the stack
    (call $log_f32 (global.get $import_float_32))

    ;; call the log_f64 function
    ;; push the import_float_64 global variable onto the stack
    (call $log_f64 (global.get $import_float_64))
  )
)