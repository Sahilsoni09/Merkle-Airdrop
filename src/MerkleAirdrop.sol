// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {IERC20, SafeERC20} from "lib/openzepplin-contracts/contracts/token/ERC20/utils/SafeERC20.sol";
import {MerkleProof} from "lib/openzepplin-contracts/contracts/utils/cryptography/MerkleProof.sol";

contract MerkleAirdrop {
    using SafeERC20 for IERC20;
    // some list of addresses
    // Allow someone in the list to claim token
    error MerkleAirdrop__InvalidProof();
    address[] private claimers;
    bytes32 private immutable i_merkleRoot;
    IERC20 private immutable i_airdropToken;

    event Claim(address account, uint256 amount);

    constructor(bytes32 merkleRoot, IERC20 airdropToken){
        i_merkleRoot = merkleRoot;
        i_airdropToken = airdropToken;
    }

    function claim(address account, uint256 amount, bytes32[] calldata merkleProof) external {

        // when someone call claim function it need to loop through the big array every time 
        // for(uint256 i =0; i< claimers.length; i++){
              // check the account is in the claimers array
        // }

        // solution is: to use Merkle proofs
        // Merkle proofs allow us to prove that some piece of data that we want is in fact in a group of data
        // is my address in the group of addresses merkle proof help us to do that 

        //calculate usint the account and the amount, the hash-> leaf node
        bytes32 leaf = keccak256(bytes.concat(keccak256(abi.encode(account, amount))));

        if(!MerkleProof.verify(merkleProof, i_merkleRoot, leaf)){
            revert MerkleAirdrop__InvalidProof();
        }
        emit Claim(account, amount);
        i_airdropToken.safeTransfer(account, amount);

    }
}