const Ballot = artifacts.require("Ballot");
const Web3 = require("web3");

const USERS_EMAILS = ["user1@test.com", "user2@test.com", "user3@test.com"];
const USERS_EMAILS_BYTES = USERS_EMAILS.map(email => Web3.utils.fromUtf8(email));


contract("Ballot", async accounts => {
    it("Should invite all the users and register all of them", async () => {
        let ballot = await Ballot.deployed();
        let adminOwnerAccount = accounts[0];

        let promises = USERS_EMAILS_BYTES.map(email => ballot.inviteEmail(email, { from: adminOwnerAccount }));
        await Promise.all(promises);
        
        promises = USERS_EMAILS_BYTES.map((email, index) => ballot.registerUser(email, { from: accounts[index] }));
        await Promise.all(promises);

        let usersCount = await ballot.getUsersCount.call();
        assert.equal(usersCount.toNumber(), USERS_EMAILS_BYTES.length);
    });
});
