// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.18;

import {Test} from "forge-std/Test.sol";
import {DeployBox} from "../script/DeployBox.s.sol";
import {UpgradeBox} from "../script/UpgradeBox.s.sol";
import {BoxV1} from "../src/BoxV1.sol";
import {BoxV2} from "../src/BoxV2.sol";

contract DeployAndUpgradeTest is Test {
    DeployBox public deployer;
    UpgradeBox public upgrader;
    address public proxy;
    address public OWNER = makeAddr("owner");

    function setUp() public {
        deployer = new DeployBox();
        upgrader = new UpgradeBox();
        proxy = deployer.run(); // the proxy points to BoxV1
    
    }

    function testDeployAndUpgrade() public {}

    function testProxyStartsAsBoxV1() public {
        // uint256 actualVersion = BoxV1(proxy).version();
        // uint256 expectedVersion = 1;
        // assertEq(actualVersion, expectedVersion);

        vm.expectRevert();
        BoxV2(proxy).setNumber(7);
    }

    function testUpgrades() public {
        BoxV2 boxV2 = new BoxV2();

        upgrader.upgradeBox(proxy, address(boxV2));
        uint256 actualVersion = BoxV2(proxy).version();
        uint256 expectedVersion = 2;
        assertEq(actualVersion, expectedVersion);

        uint256 expectedNumber = 7;
        BoxV2(proxy).setNumber(expectedNumber);
        uint256 actualNumber = BoxV2(proxy).getNumber();
        assertEq(actualNumber, expectedNumber);
    }
}
