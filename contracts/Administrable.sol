// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract Administrable {
    mapping(address => bool) _admins;

    event AdminAdded(address indexed admin, address indexed addedBy);
    event AdminRemoved(address indexed admin, address indexed removedBy);

    constructor(address[] memory initialAdmins) {
        for (uint i; i < initialAdmins.length; i++) {
            _admins[initialAdmins[i]] = true;
            emit AdminAdded(initialAdmins[i], msg.sender);
        }
    }

    modifier onlyAdmins {
        require(_admins[msg.sender], "Address not allowed to call this method");
        _;
    }

    function isAdmin(address _address) public view returns(bool) {
        return _admins[_address];
    }

    function addAdmin(address _newAdmin) public onlyAdmins {
        _admins[_newAdmin] = true;
        emit AdminAdded(_newAdmin, msg.sender);
    }

    function removeAdmin(address _admin) public onlyAdmins {
        _admins[_admin] = false;
        emit AdminRemoved(_admin, msg.sender);
    }
}