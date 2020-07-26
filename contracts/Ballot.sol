pragma solidity 0.5.2;

contract Ballot {
    event NewUserEvent (bytes32 email, address hash);

    address private owner;
    mapping(bytes32 => bool) private invitedUsers;
    mapping(address => Voter) private users;
    address[] private usersAccounts;

    struct Voter {
        bytes32 email;
        uint256 vote;
        bool voted;
    }

    constructor() public {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require (msg.sender == owner, "Invalid Owner addresss");
        _;
    }

    modifier onlyInvited(bytes32 email) {
        require (invitedUsers[email], "The email is not invited to participate");
        _;
    }

    modifier onlyRegistered() {
        require (users[msg.sender].email.length > 0, "The user is not registered");
        _;
    }

    function inviteEmail(bytes32 email) public onlyOwner {
        invitedUsers[email] = true;
    }

    function registerUser(bytes32 email) public onlyInvited(email) {
        address userAddress = msg.sender;
        users[userAddress] = Voter(email, 0, false);
        usersAccounts.push(userAddress);
        invitedUsers[email] = false;
        emit NewUserEvent(email, userAddress);
    }

    function getUsersCount() public view returns(uint256) {
        return usersAccounts.length;
    }
}
