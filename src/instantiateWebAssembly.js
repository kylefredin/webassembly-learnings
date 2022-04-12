const fs = require("fs").promises;

/**
 * @param {string} filename
 * @param {Object} importObject - optional
 * @returns {Promise<WebAssembly.Instance>}
 */
const instantiateWebAssembly = async (filename, importObject) => {
  const bytes = await fs.readFile(filename);

  const { instance } = await WebAssembly.instantiate(
    new Uint8Array(bytes),
    importObject
  );

  return instance;
};

module.exports = instantiateWebAssembly;
