(module
  (;
    this tells WebAssembly to expect an object to be imported called "env"
    the imported object should have the following keys:
      - "print_string"
      - "buffer"
      - "start_string"
  ;)
  (import "env" "print_string" (func $print_string(param i32)))

  ;; the (memory 1) statement indicates that the buffer will be a single page
  ;; of linear memory which in WebAssembly is 64KB
  (import "env" "buffer" (memory 1))

  ;; we are telling webassembly there is a global variable called
  ;; "start_string" which gets its value from the value imported from "env"
  (global $start_string (import "env" "start_string") i32)

  ;; defines a constant value
  (global $string_len i32 (i32.const 12))

  ;;
  (data (global.get $start_string) "hello world")

  ;; define and export a function called "helloworld"
  (func (export "helloworld")
    (call $print_string (global.get $string_len))
  )
)