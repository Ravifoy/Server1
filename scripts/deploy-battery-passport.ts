import { ethers } from "hardhat";

async function main() {
  const BatteryPassport = await ethers.getContractFactory("BatteryPassport");
  const batteryPassport = await BatteryPassport.deploy();

  await batteryPassport.waitForDeployment();

  console.log(`BatteryPassport deployed to: ${await batteryPassport.getAddress()}`);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});