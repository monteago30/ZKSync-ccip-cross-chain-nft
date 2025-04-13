// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import {Script} from "forge-std/Script.sol";
import {XNFT} from "../src/XNFT.sol";
import {console} from "forge-std/console.sol";

contract DeployXNFT is Script {
    // Sepolia CCIP router address
    address constant SEPOLIA_CCIP_ROUTER = 0x0BF3dE8c5D3e8A2B34D2BEeB17ABfCeBaf363A59;

    // Sepolia LINK token address
    address constant SEPOLIA_LINK_TOKEN = 0x779877A7B0D9E8603169DdbD7836e478b4624789;

    // Sepolia Chain Selector
    uint64 constant SEPOLIA_CHAIN_SELECTOR = 16015286601757825753;

    function run() external returns (XNFT) {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");

        vm.startBroadcast(deployerPrivateKey);

        // Deploy the XNFT contract
        XNFT xnft = new XNFT(SEPOLIA_CCIP_ROUTER, SEPOLIA_LINK_TOKEN, SEPOLIA_CHAIN_SELECTOR);

        console.log("XNFT deployed to:", address(xnft));

        vm.stopBroadcast();

        return xnft;
    }
}
