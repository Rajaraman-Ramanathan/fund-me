// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {PriceConverter} from "./PriceConverter.sol";

error NotOwner();

contract FundMe {
    // uint256 public myValue = 1;
    using PriceConverter for uint256;
    uint256 public constant MINIMUM_USD = 5;
    address [] public funders;
    address public i_owner;
    mapping(address => uint256) public addressToAmountFunded;

    constructor() {
        i_owner = msg.sender;
    }

    function fund() public payable {
        // Allow users to send minimum of 1 ETH
        // myValue = myValue + 2; // example of revert
        require(msg.value.getConversionRate() >= MINIMUM_USD, "Didn't send enough ETH"); // require statement to used to check, and when it fails it will undo
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] += msg.value;
    }

    function withdraw() public onlyOwner {
        for (uint256 funderIndex=0; funderIndex < funders.length; funderIndex++){
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }
        funders = new address[](0); // Reset funders array
        // delete funders; //an alternate way to reset an array. uses less gas
        (bool success, ) = payable(msg.sender).call{value: address(this).balance}("");
        require(success, "Call Failed");
    }

    modifier onlyOwner() {
       // require(msg.sender == i_owner, "Must be an Owner!!");
       if(msg.sender != i_owner) {
        revert NotOwner();
       }
        _;
    }

    receive() external payable {
        fund();
    }

    fallback() external payable {
        fund();
    }
}
