# WebAssembly Learnings

## Convert WebAssembly Text (WAT) to WebAssmebly Binary (WASM)

- Run `npm run build <path-to-wat-file>`

### Notes

- The only data type that a JavaScript callback function can receive is number
- You cannot return 64-bit integers until the [BigInt WebAssembly](https://github.com/WebAssembly/JS-BigInt-integration) proposal is implemented
- WAT doesn't really support OOP

## Resources

- [Binary Format Spec](https://webassembly.github.io/spec/core/binary/index.html)
- [Text Format Spec](https://webassembly.github.io/spec/core/text/index.html)
- [MDN Docs](https://developer.mozilla.org/en-US/docs/WebAssembly/Understanding_the_text_format)
- [wat-wasm module](https://github.com/battlelinegames/wat-wasm)
- [wat 2 wasm demo](https://webassembly.github.io/wabt/demo/wat2wasm/)
