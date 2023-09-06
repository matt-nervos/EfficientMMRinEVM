**Explain MMR**

A Merkle mountain range (MMR) is an authenticated data structure comprised of perfectly balanced binary Merkle trees.

It is append-only, elements are added from the left to the right, adding a parent as soon as 2 children exist, filling up the range accordingly. 

From the perspective of adding to the MMR, once a parent is formed, its children can be forgotten. Only current peak values are needed when adding elements to the MMR. 

While the structure is append-only, state transitions can be done with Merkle proofs. Instead of being removed, items can set to null.

A step-by-step demonstration of building an MMR can be found [here](https://talk.nervos.org/t/merging-merkle-mountain-ranges/7273), or more robust explanations [here](https://docs.grin.mw/wiki/chain-state/merkle-mountain-range/) and [here](https://docs.rs/merklemountainrange/latest/src/merklemountainrange/lib.rs.html#23-183).

<br>

**Binary bits and peaks** 

<br>
Because the process of building MMR peaks matches the process of binary addition, their topology matches up with the binary representation of the number of elements in the MMR. There is a MMR peak at each position with a bit set.

For example:

1 elements:   000001

2 elements:   000010

3 elements:   000011

12 elements: 001100

<br>

**Approaching the EVM**

The EVM is an extremely resource constrained computing environment. 

Fortunately, only the MMR peak values and the elements being added are needed to add to the MMR. 

Additionally, the topology of the MMR is described by the binary representation of the number of elements in the data structure, thus the peaks that will be touched can be inferred (based on the number of elements in the MMR and the number of elements to be added).

<br>

**Resource Dimensions**


_State storage:_ The max number of peaks grows logarithmically with the number of elements in the MMR.

_State read:_ The appropriate state to be read from storage to memory is known upfront, no further state reads are required.

_Computation:_ Keccak and moving values in memory.

_State write:_ Storage slots that will be written to are known upfront.
