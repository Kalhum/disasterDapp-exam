
const hre = require("hardhat");

async function main() {
    const RegisterDisaster = await hre.ethers.getContractFactory("RegisterDisaster");

    const registerDisaster = await RegisterDisaster.deploy();



    // รอจนกว่าการ deploy จะเสร็จสมบูรณ์
    await registerDisaster.waitForDeployment(); // ใช้ waitForDeployment() แทน

    console.log("Contract deployed to:", registerDisaster.address);

    // Register a person
    const tx = await registerDisaster.registerPerson("1234567890123", "John", "Doe", "123 Main St");
    await tx.wait();

    // Fetch all registered people
    const people = await registerDisaster.getAll();
    console.log(people);
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});




