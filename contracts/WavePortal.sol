// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WavePortal {
    uint256 private seed;

    struct Wave {
        address sender;
        string message;
        uint256 timestamp;
    }

    Wave[] waves;

    mapping(address => uint256) public lastWaveAt;

    event waveCreated(address indexed from, uint256 timestamp, string message);

    constructor() payable {
        seed = (block.timestamp + block.difficulty) % 100;
    }

    function wave(string memory _message) public {
        require(
            lastWaveAt[msg.sender] + 15 minutes < block.timestamp,
            "Wait 15 minutes before waving again"
        );

        lastWaveAt[msg.sender] = block.timestamp;

        waves.push(Wave(msg.sender, _message, block.timestamp));

        seed = (block.difficulty + block.timestamp + seed) % 100;

        if (seed <= 50) {
            uint256 prizeAmount = 0.0001 ether;

            require(
                prizeAmount <= address(this).balance,
                "The contract does not have enough ether to pay the prize"
            );

            (bool success, ) = (msg.sender).call{value: prizeAmount}("");

            require(success, "The contract failed to pay the prize");
        }

        emit waveCreated(msg.sender, block.timestamp, _message);
    }

    function getWaves() public view returns (Wave[] memory) {
        return waves;
    }

    function getTotalWaves() public view returns (uint256) {
        return waves.length;
    }
}
