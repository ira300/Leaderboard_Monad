async function main() {
    // Obtém o endereço do primeiro signer (a conta que irá realizar o deploy)
    const [deployer] = await ethers.getSigners();
    console.log("Deploying contracts with the account:", deployer.address);

    // Obtém o contrato Deploy
    const Deploy = await ethers.getContractFactory("Deploy");

    // Realiza o deploy do contrato Deploy
    const deployContract = await Deploy.deploy();
    console.log("Deploy contract deployed to:", deployContract.address);

    // Executa a função deploy() dentro do Deploy.sol
    const tx = await deployContract.deploy();
    await tx.wait();  // Aguarda a transação ser confirmada

    // Obtém os endereços dos contratos deployados
    const feeVaultAddress = await deployContract.feeVaultAddress();
    const feeAccessProtocolAddress = await deployContract.feeAccessProtocolAddress();

    console.log("FeeVault deployed at:", feeVaultAddress);
    console.log("FeeAccessProtocol deployed at:", feeAccessProtocolAddress);
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });

