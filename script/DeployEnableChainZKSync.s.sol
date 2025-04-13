// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import {Script} from "forge-std/Script.sol";
import {XNFT} from "../src/XNFT.sol";
import {console} from "forge-std/console.sol";

contract DeployEnableChainZKSync is Script {
    // Ethereum Sepolia Chain Selector for CCIP
    uint64 constant SEPOLIA_CHAIN_SELECTOR = 16015286601757825753;

    // CCIP extrArgs with 200_000 gas limit;
    bytes constant CCIP_EXTRA_ARGS = hex"97a657c90000000000000000000000000000000000000000000000000000000000030d40";

    // Hardcoded contract Addresses
    address constant ZKSYNC_XNFT_ADDRESS = 0x637E3e0AB3e5375EB33d35368E1919b7499be51d;
    address constant SEPOLIA_XNFT_ADDRESS = 0x3A3A39e196262c2f1e84e3B718Da8B64d0e7507c;

    function run() external {
        // Load the private key from env file
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");

        vm.startBroadcast(deployerPrivateKey);

        // Get the XNFT contract address
        XNFT xnft = XNFT(ZKSYNC_XNFT_ADDRESS);

        // Enable the Ethereum Sepolia chain in the ZKSync contract
        xnft.enableChain(
            SEPOLIA_CHAIN_SELECTOR, // Ethereum Sepolia chain selector
            SEPOLIA_XNFT_ADDRESS, // Ethereum Sepolia XNFT contract address
            CCIP_EXTRA_ARGS // CCIP extrArgs with gas limit
        );

        console.log("Ethereum Sepolia chain enabled successfully on ZKSync Sepolia XNFT contract");
        console.log("Ethereum Sepolia XNFT Address:", ZKSYNC_XNFT_ADDRESS);
        console.log("Ethereum Sepolia XNFT Address", SEPOLIA_XNFT_ADDRESS);
        console.log("Chain Selector:", SEPOLIA_CHAIN_SELECTOR);

        vm.stopBroadcast();
    }
}
