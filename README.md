# Time-Locked Vault ⏳

A Solidity smart contract for locking ETH deposits until a specified future time.

## Features
- Users can deposit ETH with a custom lock duration.
- ETH can only be withdrawn after the lock period expires.
- Uses block timestamps for time checks.
- Safe `.call` transfer pattern to avoid reentrancy.

## Deployment
This contract was deployed on the zkSync Era Sepolia Testnet.

## Functions
- `deposit(uint256 lockDuration)`: Deposit ETH locked for `lockDuration` seconds.
- `withdraw()`: Withdraw ETH after the unlock time.
- `getBalance(address)`: Get the deposited balance.
- `getUnlockTime(address)`: Get the unlock timestamp.

## License
MIT
