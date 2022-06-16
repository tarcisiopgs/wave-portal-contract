require('@nomiclabs/hardhat-waffle');
require('dotenv').config();

module.exports = {
  solidity: '0.8.0',
  networks: {
    rinkeby: {
      url: process.env.STAGING_ALCHEMY_KEY || process.env.PROD_ALCHEMY_KEY,
      accounts: [process.env.ACCOUNT_PRIVATE_KEY],
    },
  },
};
