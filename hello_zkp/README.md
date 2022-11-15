Applied ZKP Workshop #1
========================

## Your First ZKP Circuit

### Compile the circuit
```bash
circom hello_zkp.circom --r1cs --wasm --sym --c
```

### Computing the witness with WebAssembly

1. create a the input of the circuit `input.json`
```json
{"x": "10"}
```

2. run witness generation
```bash
node ./hello_zkp_js/generate_witness.js ./hello_zkp_js/hello_zkp.wasm input.json witness.wtns
```

### Trusted Setup using SnarkJS
#### Power of Tau (Phase 1)
First, we start a new "powers of tau" ceremony:
```bash
snarkjs powersoftau new bn128 12 pot12_0000.ptau -v
```
Then, we make our own contribution:
```bash
snarkjs powersoftau contribute pot12_0000.ptau pot12_0001.ptau --name="First contribution" -v
```

#### Phase 2 (Circuit Specific)

The phase 2 is circuit-specific. Execute the following command to start the generation of this phase:

```bash
snarkjs powersoftau prepare phase2 pot12_0001.ptau pot12_final.ptau -v
```

Next, we generate a `.zkey` file that will contain the proving and verification keys together with all phase 2 contributions. Execute the following command to start a new zkey:

```bash
snarkjs groth16 setup hello_zkp.r1cs pot12_final.ptau hello_zkp_0000.zkey
```

Contribute to the phase 2 of the ceremony:

```bash
snarkjs zkey contribute hello_zkp_0000.zkey hello_zkp_0001.zkey --name="1st Contributor Name" -v
```

Export the verification key:
```bash
snarkjs zkey export verificationkey hello_zkp_0001.zkey verification_key.json
```

### Generate a Proof
Once the witness is computed and the trusted setup is already executed, we can generate a zk-proof associated to the circuit and the witness:

```bash
snarkjs groth16 prove hello_zkp_0001.zkey witness.wtns proof.json public.json
```

### Verifying a Proof
```bash
snarkjs groth16 verify verification_key.json public.json proof.json
```

### Generating Solidity Verifier
```bash
snarkjs zkey export solidityverifier hello_zkp_0001.zkey verifier.sol
```