const { network } = require("hardhat");

require("@nomicfoundation/hardhat-toolbox");


module.exports = {
  solidity: "0.8.24",          //check version 0.8.9
  networks: {
    hardhat: {
      chainID: 1337,
    },
  },
};
