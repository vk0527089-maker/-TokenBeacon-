// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

/**
 * @title TokenBeacon
 * @notice Minimal upgradeable beacon-style contract for managing logic addresses.
 * @dev This contract stores an implementation address that proxies can reference.
 *      Use with BeaconProxy or any custom proxy design.
 */
contract TokenBeacon {

    address public admin;
    address public implementation;

    event Upgraded(address indexed newImplementation);
    event AdminChanged(address indexed oldAdmin, address indexed newAdmin);

    modifier onlyAdmin() {
        require(msg.sender == admin, "TokenBeacon: NOT_ADMIN");
        _;
    }

    constructor(address _implementation) {
        require(_implementation != address(0), "TokenBeacon: ZERO_IMPLEMENTATION");
        admin = msg.sender;
        implementation = _implementation;
    }

    function upgradeTo(address newImplementation) external onlyAdmin {
        require(newImplementation != address(0), "TokenBeacon: ZERO_IMPLEMENTATION");
        implementation = newImplementation;
        emit Upgraded(newImplementation);
    }

    function changeAdmin(address newAdmin) external onlyAdmin {
        require(newAdmin != address(0), "TokenBeacon: ZERO_ADMIN");
        emit AdminChanged(admin, newAdmin);
        admin = newAdmin;
    }

    function getImplementation() external view returns (address) {
        return implementation;
    }
}
