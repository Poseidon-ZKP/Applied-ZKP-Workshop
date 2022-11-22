pragma circom 2.1.0;

include "../node_modules/circomlib/circuits/poseidon.circom";
include "./tree.circom";


// nLevels must be < 32.
template Group(nLevels) {
    signal input identityTrapdoor;
    signal input treePathIndices[nLevels];
    signal input treeSiblings[nLevels];
    signal output root;

    component poseidonT1 = Poseidon(1); 
    component inclusionProof = MerkleTreeInclusionProof(nLevels);
    
    poseidonT1.inputs[0] <== identityTrapdoor;    
    inclusionProof.leaf <== poseidonT1.out;

    for (var i = 0; i < nLevels; i++) {
        inclusionProof.siblings[i] <== treeSiblings[i];
        inclusionProof.pathIndices[i] <== treePathIndices[i];
    }

    root <== inclusionProof.root;
}

component main = Group(10);