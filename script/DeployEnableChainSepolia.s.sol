// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import {Script} from "forge-std/Script.sol";
import {XNFT} from "../src/XNFT.sol";
import {console} from "forge-std/console.sol";

contract DeployEnableChainSepolia is Script {
    // ZKSync Chain Selector for CCIP (Testnet)
    uint64 constant ZKSYNC_TESNET_CHAIN_SELECTOR = 6898391096552792247;

    // Ethereum Sepolia XNFT Contract Address
    address constant SEPOLIA_XNFT_ADDRESS = 0x3A3A39e196262c2f1e84e3B718Da8B64d0e7507c;
    // ZKSYnc Tesnet XNFT Contract Address
    address constant ZKSYNC_XNFT_ADDRESS = 0x637E3e0AB3e5375EB33d35368E1919b7499be51d;

    // CCIP extraArgs with 200_000 gas limit
    bytes constant CCIP_EXTRA_ARGS = hex"97a657c90000000000000000000000000000000000000000000000000000000000030d40";

    function run() external {
        // Load your private key from environment
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");

        vm.startBroadcast(deployerPrivateKey);

        // Get the XNFT contract on Ethereum Sepolia
        XNFT xnft = XNFT(SEPOLIA_XNFT_ADDRESS);

        // Enable the ZKSYnc chain in the Sepolia contract
        xnft.enableChain(
            ZKSYNC_TESNET_CHAIN_SELECTOR, // ZKSync Tesnet chain Selector
            ZKSYNC_XNFT_ADDRESS, // ZKSync Tesnet XNFT contract Address
            CCIP_EXTRA_ARGS // CCIP extraArgs with gas limit
        );

        console.log("ZKSync Testnet chain enabled successfully on Ethereum Sepolia XNFT contract");
        console.log("Ethereum Sepolia XNFT Address:", SEPOLIA_XNFT_ADDRESS);
        console.log("ZKSync Tesnet XNFT Address:", ZKSYNC_XNFT_ADDRESS);
        console.log("ZKSync Chain Selector:", ZKSYNC_TESNET_CHAIN_SELECTOR);

        vm.stopBroadcast();
    }
}
