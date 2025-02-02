// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract MerkleAirdrop {
    // some list of addresses
    // Allow someone in the list to claim token
    address[] claimers;

    function claim(address account) external {

        // when someone call claim function it need to loop through the big array every time 
        // for(uint256 i =0; i< claimers.length; i++){
              // check the account is in the claimers array
        // }

        // solution is: to use Merkle proofs
        // Merkle proofs allow us to prove that some piece of data that we want is in fact in a group of data
        // is my address in the group of addresses merkle proof help us to do that 
        
    }
}