// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import {Script} from "forge-std/Script.sol";
import {XNFT} from "../src/XNFT.sol";
import {console} from "forge-std/console.sol";

contract DeployMintXNFT is Script {
    // Add the Sepolia XNFT contract address
    address constant SEPOLIA_XNFT_ADDRESS = 0x3A3A39e196262c2f1e84e3B718Da8B64d0e7507c;

    function run() external {
        // Load the private key from env
        uint256 myDeployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address mySender = vm.addr(myDeployerPrivateKey);

        vm.startBroadcast(myDeployerPrivateKey);

        // Get the XNFT contract  address on Ethereum Sepolia
        XNFT xnft = XNFT(SEPOLIA_XNFT_ADDRESS);

        // Mint a new NFT
        xnft.mint();

        // Get the latest token ID (note: this assumes you can track this separately)
        // The contract doesn't expose a way to get the latest token ID directly
        // You'll need to check events or track it separately

        console.log("New XNFT minted on Ethereum Sepolia");
        console.log("Contract Address", SEPOLIA_XNFT_ADDRESS);
        console.log("Minted to Address", mySender);

        vm.stopBroadcast();
    }
}
