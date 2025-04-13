// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import {Script, console} from "forge-std/Script.sol";
import {XNFT} from "../src/XNFT.sol";

contract DeployCrossChainTransferXNFT is Script {
    // Add the Sepolia XNFT contract address
    address constant SEPOLIA_XNFT_ADDRESS = 0x3A3A39e196262c2f1e84e3B718Da8B64d0e7507c;

    // Ethereum Sepolia chain selector
    // uint64 constant SEPOLIA_CHAIN_SELECTOR = 16015286601757825753;

    // ZKSync Sepolia Chain selector for CCIP
    uint64 constant destinationChainSelector = 6898391096552792247;

    // TOken ID to transfer - this is the actual token ID that was minted
    uint256 constant tokenId = 0;

    // PayFeesIn.LINL = 1
    uint8 constant PAY_FEES_IN_LINK = 1;
    uint8 constant PAY_FEES_IN_NATIVE = 0;

    function run() external {
        // Load the private key from env
        uint256 myDeployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address from = vm.addr(myDeployerPrivateKey);

        // The recepient address can be and is the same as the sender
        address to = from;

        vm.startBroadcast(myDeployerPrivateKey);

        // Get the XNFT contract address on Ethereum Sepolia
        XNFT xnft = XNFT(SEPOLIA_XNFT_ADDRESS);

        console.log("Starting cross-chain transfer of XNFT from Ethereum Sepolia to ZKSync Sepolia");
        console.log("From:", from);
        console.log("To:", to);
        console.log("Token ID:", tokenId);
        console.log("Destination Chain Selector:", destinationChainSelector);
        console.log("Pay Fees In:", PAY_FEES_IN_LINK == 1 ? "LINK" : "Native");

        // Transfer the NFT cross-chain from Sepolia to ZKSync
        bytes32 messageId = xnft.crossChainTransferFrom(
            from, // from address
            to, // to address on the destination chain
            tokenId, // Token ID to transfer
            destinationChainSelector, // destination chain selector
            XNFT.PayFeesIn(PAY_FEES_IN_LINK)
        );

        console.log("Cross-chain transfer initiated");
        console.log("Message ID:", vm.toString(messageId));

        vm.stopBroadcast();
    }
}
