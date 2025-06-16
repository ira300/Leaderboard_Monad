require("dotenv").config();
require("@nomiclabs/hardhat-ethers");
require("@nomicfoundation/hardhat-verify");

/**
 * @type import('hardhat/config').HardhatUserConfig
 */
module.exports = {
  networks: {
    Monad: {
      url: "https://monad-testnet.drpc.org",
      chainId: 10143,
      accounts: [
        `0x${"Your Private Key"}`,
      ],
    },
  },
  solidity: {
    version: "0.8.19",
  },
  etherscan: {
    apiKey: "empty",
    customChains: [
      {
        network: "Monad",
        chainId: 10143,
        urls: {
          apiURL: "https://monad-testnet.drpc.org",
          browserURL: "https://testnet.monadexplorer.com",
        },
      },
    ],
  },
};
