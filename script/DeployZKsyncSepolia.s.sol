// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import {Script} from "forge-std/Script.sol";
import {XNFT} from "../src/XNFT.sol";
import {console} from "forge-std/console.sol";

contract DeployXNFTZKsync is Script {
    // ZKSync Sepolia CCIP Router address
    address constant ZKSYNC_SEPOLIA_CCIP_ROUTER = 0xA1fdA8aa9A8C4b945C45aD30647b01f07D7A0B16;

    // ZKSync Sepolia LINK Token address
    address constant ZKSYNC_SEPOLIA_LINK_TOKEN = 0x23A1aFD896c8c8876AF46aDc38521f4432658d1e;

    // ZKSync Sepolia Chain Selector for CCIP
    uint64 constant ZKSYNC_SEPOLIA_CHAIN_SELECTOR = 6898391096552792247;

    function run() external returns (XNFT) {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");

        vm.startBroadcast(deployerPrivateKey);

        // Deploy the XNFT contract on ZKSync Sepolia
        XNFT xnft = new XNFT(ZKSYNC_SEPOLIA_CCIP_ROUTER, ZKSYNC_SEPOLIA_LINK_TOKEN, ZKSYNC_SEPOLIA_CHAIN_SELECTOR);

        console.log("XNFT deployed to ZKSync Sepolia at:", address(xnft));

        vm.stopBroadcast();

        return xnft;
    }
}
