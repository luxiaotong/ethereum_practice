// SPDX-License-Identifier: UNLICENSE

pragma solidity ^0.8.0;

contract MappingContract {
    // Mappings
    mapping(uint256 => string) public names;

    constructor() {
        names[1] = "Adam";
        names[2] = "Bruce";
        names[3] = "Carl";
    }

    struct Book {
        string title;
        string author;
    }

    mapping(uint256 => Book) public books;
    mapping(address => mapping(uint256 => Book)) public myBooks;

    function addBook(
        uint256 _id,
        string memory _title,
        string memory _author
    ) public {
        books[_id] = Book(_title, _author);
    }

    function addMyBook(
        uint256 _id,
        string memory _title,
        string memory _author
    ) public {
        myBooks[msg.sender][_id] = Book(_title, _author);
    }
}
