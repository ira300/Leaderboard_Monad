async function main() {
  const [deployer] = await ethers.getSigners();

  console.log("Deploying contract with address:", deployer.address);

  const Leaderboard = await ethers.getContractFactory("Leaderboard");
  const contract = await Leaderboard.deploy();

  await contract.deployed();

  console.log("Leaderboard2048 deployed to:", contract.address);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});

