// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {PriceConverter} from "./PriceConverter.sol";

contract FundMe {
    // uint256 public myValue = 1;
    using PriceConverter for uint256;
    uint256 public minimumUsd = 5;
    address [] public funders;
    address public owner;
    mapping(address => uint256) public addressToAmountFunded;

    constructor() {
        owner = msg.sender;
    }

    function fund() public payable {
        // Allow users to send minimum of 1 ETH
        // myValue = myValue + 2; // example of revert
        require(msg.value.getConversionRate() >= minimumUsd, "Didn't send enough ETH"); // require statement to used to check, and when it fails it will undo
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
        require(msg.sender == owner, "Must be an Owner!!");
        _;
    }
}
