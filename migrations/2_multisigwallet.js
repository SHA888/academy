import { Wallet } from "./Assignment/MultiSigWalletSolution.sol
";
const Wallet = artifacts.require("Wallet");

module.exports = function (deployer) {
  deployer.deploy(Wallet);
};
