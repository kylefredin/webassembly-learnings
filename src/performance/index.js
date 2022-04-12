const instantiateWebAssembly = require("../instantiateWebAssembly");
const value = parseInt(process.argv[2]);

(async () => {
  let i = 0;

  const importObject = {
    js: {
      external_call() {
        return i++;
      },
    },
  };

  const instance = await instantiateWebAssembly(
    __dirname + "/perform.wasm",
    importObject
  );

  ({ wasm_call, js_call } = instance.exports);

  let start = Date.now();

  wasm_call();

  console.log("wasm_call", Date.now() - start);

  start = Date.now();

  js_call();

  console.log("js_call", Date.now() - start);
})();
