const lottery = artifacts.require("Lottery");
const truffleAssert = require('truffle-assertions');

/*
 * uncomment accounts to access the test accounts made available by the
 * Ethereum client
 * See docs: https://www.trufflesuite.com/docs/truffle/testing/writing-tests-in-javascript
 */
contract("lottery", function (/* accounts */) {
  it("should assert true", async function () {
    await lottery.deployed();
    return assert.isTrue(true);
  });
});


contract("Lottery",async accounts => {
    let instance;
    let owner;
    let notOwner;

    beforeEach('creating instance before all Test Cases', async function(){
        owner = accounts[0];
        notOwner = accounts[1];
        instance = await lottery.new({from: accounts[0]});
    });
    it("Check ownership of contract instance", async ()=> {
            let instance2 = await lottery.new({from: accounts[1]});
            assert.equal(await instance.get_owner({from: accounts[0]}), accounts[0]);
            assert.equal(await instance2.get_owner({from: accounts[0]}), accounts[1]);
    });

    it("Allow one to join if balance sufficient", async() => {
        let balance = accounts[1].balance;
        let val = Math.min(1, accounts[1].balance);
        let res = await instance.join_lottery({from: accounts[1], value: val });
        assert.equal(accounts.balance, balance-val);
        assert.equal(await lottery.get_lottery_balance() , val)
    })



 })
