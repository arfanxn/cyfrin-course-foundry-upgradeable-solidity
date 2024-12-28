// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {DevOpsTools} from "../lib/foundry-devops/src/DevOpsTools.sol";
import {BoxV2} from "../src/BoxV2.sol";
import {BoxV1} from "../src/BoxV1.sol";

contract UpgradeBox is Script {
    function run() external returns (address) {
        address mostRecenlyDeployed = DevOpsTools.get_most_recent_deployment(
            "ERC1967Proxy",
            block.chainid
        );

        /// @dev Deploy the new version of the Box contract and upgrade the most
        /// recently deployed proxy contract to point to it.
        address nexBoxAddr = deployBox();
        address proxy = upgradeBox(mostRecenlyDeployed, nexBoxAddr);
        return proxy;
    }

    function deployBox() public returns (address) {
        vm.startBroadcast();
        BoxV2 newBox = new BoxV2();
        vm.stopBroadcast();
        return address(newBox);
    }

    function upgradeBox(
        address proxyAddr,
        address newBoxAddr
    ) public returns (address) {
        vm.startBroadcast();
        BoxV1 proxy = BoxV1(proxyAddr);
        proxy.upgradeToAndCall(newBoxAddr, new bytes(0));
        vm.stopBroadcast();
        return address(proxy);
    }
}
