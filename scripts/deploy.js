// const hre = require("hardhat");
const { ethers, upgrades } = require("hardhat");

async function main() {
  const nftContractFactory = await ethers.getContractFactory('NFTMint');
  const nftContract = await nftContractFactory.deploy();
  await nftContract.deployed();
  console.log("Contract deployed to:", nftContract.address);

  // Call the function.
  let txn = await nftContract.makeAnEpicNFT("data:application/json;base64,INSERT_BASE_64_ENCODED_JSON_HERE", "0x0802e7C2073F3cfFdeD2e7A11Bb2417F46476B1d")
  // Wait for it to be mined.
  console.log("NFT1 minted:", nftContract.deployTransaction.hash);
  await txn.wait()

  txn = await nftContract.makeAnEpicNFT("data:application/json;base64,INSERT_BASE_64_ENCODED_JSON_HERE", "0x0802e7C2073F3cfFdeD2e7A11Bb2417F46476B1d")
  await txn.wait()
  console.log("NFT2 minted:", nftContract.deployTransaction.hash);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});



