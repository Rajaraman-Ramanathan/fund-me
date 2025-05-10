// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

// import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

interface AggregatorV3Interface {
  function decimals() external view returns (uint8);

  function description() external view returns (string memory);

  function version() external view returns (uint256);

  function getRoundData(uint80 _roundId) external view returns (uint80 roundId, int256 answer, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound);

  function latestRoundData() external view returns (uint80 roundId, int256 answer, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound);
}

contract FundMe {
    uint256 public myValue = 1;
    uint256 public minimumUsd = 5;

    function fund() public payable {
        // Allow users to send minimum of 1 ETH
        myValue = myValue + 2; // example of revert
        require(msg.value > minimumUsd, "Didn't send enough ETH"); // require statement to used to check, and when it fails it will undo
    }

    function getPrice() public view returns(uint256) {
        // we need address and ABI
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419);
        (, int256 answer, , ,) = priceFeed.latestRoundData();
        return uint256(answer * 1e10);
    }

    function getConversionRate() public {

    }

    function getVersion() public view returns (uint256) {
    return AggregatorV3Interface(0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419).version();
    }

    function withdraw() public {}
}
