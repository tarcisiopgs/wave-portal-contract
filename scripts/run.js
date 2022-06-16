const main = async () => {
  const waveContractFactory = await hre.ethers.getContractFactory('WavePortal');
  const waveContract = await waveContractFactory.deploy({
    value: hre.ethers.utils.parseEther('0.1'),
  });
  await waveContract.deployed();

  console.log(`Contract address: ${waveContract.address}`);

  let contractBalance = await hre.ethers.provider.getBalance(
    waveContract.address,
  );

  const waveTxn = await waveContract.wave('tchauzinho #1');
  await waveTxn.wait();

  const waveTxn2 = await waveContract.wave('tchauzinho #2');
  await waveTxn2.wait();

  contractBalance = await hre.ethers.provider.getBalance(waveContract.address);
};

const run = async () => {
  try {
    await main();
    process.exit(0);
  } catch (error) {
    console.log(error);
    process.exit(1);
  }
};

run();
