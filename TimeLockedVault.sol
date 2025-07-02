// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title Time-Locked Vault
/// @notice Users can deposit ETH that is locked until a future time
contract TimeLockedVault {
    // Tracks how much ETH each user has deposited
    mapping(address => uint256) public balances; 

    // Stores the unlock timestamp for each user's deposit
    mapping(address => uint256) public unlockTimes; 

    function deposit(uint256 lockDuration) external payable {
        balances[msg.sender] += msg.value; // Increase the sender's balance by ther deposited ETH amount
        unlockTimes[msg.sender] = block.timestamp + lockDuration; // Set the unlock time to now + lock duration
    }

    function withdraw() external {
        require(block.timestamp >= unlockTimes[msg.sender], "Funds are still locked"); // Check if the lock time has passed
        require(balances[msg.sender] > 0, "No funds to withdraw"); // Ensure user has a positive balance
        uint256 amount = balances[msg.sender]; // Store the user's balance to transfer
        balances[msg.sender] = 0; // Reset the user's balance before transferring
        (bool success, ) = payable(msg.sender).call{value: amount}(""); // Send ETH to the user
        require(success, "Transfer failed"); // Revert if the ETH transfer did not succeed
    }

    function getUnlockTime(address user) external view returns (uint256) {
        return unlockTimes[user]; // Returns the unlock timestamp for any address
    }

    function getBalance(address user) external view returns (uint256) {
        return balances[user]; // Returns the deposited balance for any address
    }
}