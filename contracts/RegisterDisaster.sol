// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract RegisterDisaster {
    address public owner;   // เก็บข้อมูลของเจ้าของ Smart Contract
    struct Person {
        string idCard;      // รหัสบัตรประชาชน
        string firstName;   // ชื่อ
        string lastName;    // นามสกุล
        string addr;        // ที่อยู่
    }

    Person[] private people; // อาเรย์สำหรับเก็บข้อมูลผู้คน
    mapping(string => uint256) private idToIndex; // แมพสำหรับเก็บดัชนีของผู้คนตามรหัสบัตรประชาชน

    constructor() {
        owner = msg.sender; // กำหนด owner เป็นผู้ที่สร้าง Smart Contract
    }

    // ฟังก์ชันสำหรับลงทะเบียนผู้เข้าร่วม
    function registerPerson(string memory _idCard, string memory _firstName, string memory _lastName, string memory _address) public {
        require(idToIndex[_idCard] == 0, "Person is already registered!");

        // สร้างบุคคลใหม่
        people.push(Person(_idCard, _firstName, _lastName, _address));

        // เก็บดัชนีของบุคคลในแมพ โดยเพิ่ม 1 เพราะ index 0 คือค่าเริ่มต้น
        idToIndex[_idCard] = people.length; 
    }

    function updatePerson(string memory _idCard, string memory _firstName, string memory _lastName, string memory _address) public {
    uint256 index = idToIndex[_idCard];
    require(index != 0, "Person not found!"); // ตรวจสอบว่าพบคนที่มี idCard นี้

    // อัปเดตข้อมูลบุคคล
    people[index - 1].firstName = _firstName;
    people[index - 1].lastName = _lastName;
    people[index - 1].addr = _address;
}


    // ฟังก์ชันสำหรับขอข้อมูลผู้เข้าร่วมทั้งหมด
    function getAll() public view returns (Person[] memory) {
        return people;
    }

    // ฟังก์ชันสำหรับขอข้อมูลผู้เข้าร่วมที่มี index ที่กำหนด
    function getPerson(uint256 index) public view returns (Person memory) {
        require(index < people.length, "Index out of bounds!");
        return people[index];
    }

    // ฟังก์ชันสำหรับขอข้อมูลผู้เข้าร่วมที่มี idCard ที่กำหนด
    function getID(string memory _idCard) public view returns (Person memory) {
        uint256 index = idToIndex[_idCard];
        require(index != 0, "Person not found"); // ตรวจสอบว่าพบคนที่มี idCard นี้
        return people[index - 1]; // ดัชนีในแมพเพิ่มมา 1 ดังนั้นต้องลดลง 1
    }
}
