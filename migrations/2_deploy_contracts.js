var Ballot = artifacts.require("./Ballot.sol");

module.exports = function(deployer) {
    deployer.deploy(Ballot)
    .then(function(){
        console.log("Ballot contract was deployed");
        return true;
    })
};