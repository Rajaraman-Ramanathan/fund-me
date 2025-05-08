// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract SimpleStorage {
    bool hasFavouriteNumber = true;
    int256 favouriteInt = -88;
    uint256 public favouriteNumber;
    string favouriteString = "Hello";
    bytes32 favouriteByte = "Dog";

    // Dynamic Arrays
    uint256[] listOfFavouriteNumbers;
    Person[] public listofPeople;

    // mappings
    mapping(string => uint256) public nameToFavouriteNumber;

    // visibilities - public, private, internal and external
    function store(uint256 _favouriteNumber) public  {
        favouriteNumber = _favouriteNumber;
        favouriteNumber = favouriteNumber + 1;
    }

    // view, pure
    // returns value
    function retrieve() public view returns (uint256){
        return favouriteNumber;
    }

    // Struct is used to define custom objects
    struct Person{
        uint256 favouriteNumber;
        string name;
    }
    // instead of adding persons like this in custom struct we may use array list
    // Person public raja = Person({favouriteNumber: 7, name: "Rajaraman"});
    // Person public praveen = Person({favouriteNumber: 8, name: "Praveen"});

    // memory - temprory storage data, calldata - temprory storage data and cannot change, storage - permanent storage
    function addPerson(string memory _name , uint256 _favouriteNumber) public {
        listofPeople.push(Person(_favouriteNumber, _name));  // pushing struct to a dynamic array
        nameToFavouriteNumber[_name] = _favouriteNumber;  // This like search and retrive value from key using mapping
    }

}