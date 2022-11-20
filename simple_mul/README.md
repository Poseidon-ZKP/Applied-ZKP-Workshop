Multiplication Circuits 
=======================

## Preset
1. compile the circom code
    ```shell
    circom mul.circom --r1cs --wasm --sym
    ```
2. We are reuseing a phase 1 power of tau file and directly start phase 2.
    ```shell
    wget https://hermezptau.blob.core.windows.net/ptau/powersOfTau28_hez_final_12.ptau
    snarkjs powersoftau prepare phase2 powersOfTau28_hez_final_12.ptau pot12_final.ptau -v
    snarkjs groth16 setup mul.r1cs pot12_final.ptau mul_0000.zkey
    snarkjs zkey contribute mul_0000.zkey mul_0001.zkey --name="1st Contributor Name" -v
    snarkjs zkey export verificationkey mul_0001.zkey verification_key.json
    ```

## Show the ciruit is faulty
1. Generate witness (now the `mul.json` has value `{"x":"1", "y":"5"}`.
    ```shell
    node mul_js/generate_witness.js mul_js/mul.wasm mul.json witness.wtns
    ```
2. Generate and verify proof.
    ```shell
    snarkjs groth16 prove mul_0001.zkey witness.wtns proof.json public.json
    snarkjs groth16 verify verification_key.json public.json proof.json
    ```
3. To demonstrate the circuit is faulty, change `mul.json` to `{"x":"2", "y":"5"}`.
    ```shell
    rm witness.wtns proof.json public.json
    node mul_js/generate_witness.js mul_js/mul.wasm mul.json witness.wtns
    snarkjs groth16 prove mul_0001.zkey witness.wtns proof.json public.json
    snarkjs groth16 verify verification_key.json public.json proof.json
    ```
