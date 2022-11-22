# Circom-Hardhat-TS-Starter

## Usage
1. Fork this repo, and `yarn install`
2. follow the [step to step guide](#a-step-to-step-guide) 

## A step to step guide:

### Create a project and install dependencies 
1. create a yarn project
    ```shell
    yarn init
    ```
2. Install dependencies
    ```shell
    yarn add --dev circomlib chai hardhat hardhat-circom typescript ts-node chai @types/node @types/mocha @types/chai @nomiclabs/hardhat-ethers @nomicfoundation/hardhat-chai-matchers @nomicfoundation/hardhat-toolbox @nomiclabs/hardhat-ethers  @nomiclabs/hardhat-etherscan typechain @typechain/hardhat hardhat-gas-reporter  solidity-coverage @typechain/ethers-v5 @nomicfoundation/hardhat-network-helpers ethers @ethersproject/abi
    ```
3. Start a hardhat project (yes, you need to remove `README.md`)
    ```shell
    yarn hardhat
    ```
4. Add the following code snippet to `hardhat.config.ts` (in `config`):
    ```typescript
    circom: {
        inputBasePath: "./circuits",
        ptau: "https://hermezptau.blob.core.windows.net/ptau/powersOfTau28_hez_final_15.ptau",
        circuits: [
        { name: "mul"}
        ]
    }
    ```
5. sanity check:
Try running following tasks:

    ```shell
    yarn hardhat help
    yarn hardhat test
    REPORT_GAS=true yarn hardhat test
    yarn hardhat node
    yarn hardhat run scripts/deploy.ts
    ```
### Generate verifier contract for the circuit
```shell
yarn hardhat circom --verbose
```
It should generate a `MulVerifier.sol` file. Also you can see `mul.r1cs`, `mul.vkey.json`, `mul.wasm`, and `mul.zkey` generated under `./circuits`.