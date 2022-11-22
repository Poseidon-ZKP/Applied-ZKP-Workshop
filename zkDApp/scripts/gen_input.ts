import { BigNumber } from "ethers";
import { poseidon } from "circomlibjs";
import { Group } from "@semaphore-protocol/group";
import { MerkleProof } from "@zk-kit/incremental-merkle-tree"
import { writeFileSync } from "fs";

async function main(
    ) {
    const TREE_DEPTH = 10;
    const identityTrapdoor : bigint = BigNumber.from(123456).toBigInt();
    const identityCommitment = poseidon([identityTrapdoor]);
    const group: Group = new Group(TREE_DEPTH);
    group.addMembers([identityCommitment]);
    const merkleProof: MerkleProof = group.generateProofOfMembership(group.indexOf(identityCommitment));
    console.log(merkleProof);
    const groupJson = {
      "identityTrapdoor": identityTrapdoor.toString(),
      "treePathIndices": merkleProof.pathIndices.map((e)=>{return e.toString()}),
      "treeSiblings": merkleProof.siblings.map((e)=>{return e.toString()})
    }
    writeFileSync(process.cwd()+"/circuits/group.json", JSON.stringify(groupJson));
}

main()
.then(() => process.exit(0))
.catch(error => {
  console.error(error);
  process.exit(1);
});