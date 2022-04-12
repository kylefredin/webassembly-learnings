const fs = require("fs");
const bytes = fs.readFileSync(__dirname + "/loop.wasm");
const n = parseInt(process.argv[2] || "1");

const importObject = {
  env: {
    log: (n, factorial) => console.log(`${n}! = ${factorial}`),
  },
};

(async () => {
  const obj = await WebAssembly.instantiate(
    new Uint8Array(bytes),
    importObject
  );

  let factorial = obj.instance.exports.loop_test(n);

  console.log(`result ${n}! = ${factorial}`);

  if (n > 12) {
    console.warn(
      "WARNING: Factorials greater than 12 are too large for a 32-bit integer"
    );
  }
})();
