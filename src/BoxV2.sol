// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.18;

// import {Initializable} from "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
// import {OwnableUpgradeable} from "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import {UUPSUpgradeable} from "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";

contract BoxV2 is UUPSUpgradeable {
    uint256 internal number;

    // constructor() {
    // _disableInitializers();
    // }

    // function initialize() public initializer {
    //     __UUPSUpgradeable_init();
    // }

    function getNumber() external view returns (uint256) {
        return number;
    }

    function setNumber(uint256 _number) external {
        number = _number;
    }

    function version() external pure returns (uint256) {
        return 2;
    }

    function _authorizeUpgrade(address newImplementation) internal override {
        // TODO:
    }
}
