const instantiateWebAssembly = require("../instantiateWebAssembly");
const value = parseInt(process.argv[2]);

(async () => {
  const instance = await instantiateWebAssembly(__dirname + "/IsPrime.wasm");

  let isPrime = instance.exports.isPrime(value);

  console.log(
    `${value} ${isPrime ? "is a prime number" : "is NOT a prime number"}`
  );
})();
