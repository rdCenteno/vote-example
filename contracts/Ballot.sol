pragma solidity 0.5.2;

contract Ballot {
    address public owner;
    uint256 private usersCount;
    mapping(bytes32 => bool) invitedUsers;

    constructor() public {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        if (msg.sender == owner) _;
    }

    modifier onlyInvited(bytes32 email) {
        if (invitedUsers[email]) _;
    }

    function inviteEmail(bytes32 email) public onlyOwner {
        invitedUsers[email] = true;
    }

    function registerUser(bytes32 email) public onlyInvited(email) {
        usersCount++;
    }

    function getUsersCount() public view returns(uint256) {
        usersCount;
    }
}
