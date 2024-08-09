// const { buildModule } = require("@nomicfoundation/hardhat-ignition/modules");

// const JAN_1ST_2030 = 1893456000;
// const ONE_GWEI = 1_000_000_000n;

// module.exports = buildModule("LockModule", (m) => {
//   const unlockTime = m.getParameter("unlockTime", JAN_1ST_2030);
//   const lockedAmount = m.getParameter("lockedAmount", ONE_GWEI);

//   const lock = m.contract("Lock", [unlockTime], {
//     value: lockedAmount,
//   });

//   return { lock };
// });

// async function main() {
//   const Lock = await hre.ethers.getContractFactory("Lock");
//   const lock = await Lock.deploy();

//   await lock.deployed();

//   console.log("Lock deployed to:", lock.address);
// }

// main().catch((error) => {
//   console.error(error);
//   process.exitCode = 1;
// });


// scripts/deploy.js

const { ethers } = require("hardhat");

async function main() {
    // Get the contract factory for the "Create" contract
    const Create = await ethers.getContractFactory("Create");

    // Deploy the contract
    const create = await Create.deploy();

    // Wait for the deployment to be mined
    await create.waitForDeployment();

    // console.log("Create contract deployed to:", create.address);
    console.log("Create contract deployed to:",await create.getAddress()); //updated ****
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});


