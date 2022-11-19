pragma circom 2.1.0;

include "../node_modules/circomlib/circuits/poseidon.circom";
include "./tree.circom";

template CalculateIdentityCommitment() {
    signal input identityTrapdoor;

    signal output out;

    component poseidon = Poseidon(1);

    poseidon.inputs[0] <== identityTrapdoor;

    out <== poseidon.out;
}

// nLevels must be < 32.
template Group(nLevels) {
    signal input identityTrapdoor;
    signal input treePathIndices[nLevels];
    signal input treeSiblings[nLevels];

    signal output root;

    component calculateIdentityCommitment = CalculateIdentityCommitment();
    calculateIdentityCommitment.identityTrapdoor <== identityTrapdoor;

    component inclusionProof = MerkleTreeInclusionProof(nLevels);
    inclusionProof.leaf <== calculateIdentityCommitment.out;

    for (var i = 0; i < nLevels; i++) {
        inclusionProof.siblings[i] <== treeSiblings[i];
        inclusionProof.pathIndices[i] <== treePathIndices[i];
    }

    root <== inclusionProof.root;
}

component main = Group(10);
