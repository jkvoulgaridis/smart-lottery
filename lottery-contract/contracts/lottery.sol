pragma solidity ^0.5.0;

contract Lottery {
  address _owner;
  address[] _participants;
  address _winner;
  bool _found_winner;
  bool _allow_new_participants;

  constructor() public {
    _owner = msg.sender;
    _winner = _owner;
    _found_winner = false;
    _allow_new_participants=true;
  }

  function get_owner() public view returns(address){
    return _owner;
  }

  function join_lottery() public payable{
    require(msg.sender != _owner, "Owner cannot participate");
    require(msg.sender.balance > msg.value, "Not enough balance in the account");
  }

  function find_winner() public returns (bool){
    require(msg.sender==_owner, "Lottery creator is the only one who can declare a winner");
    _found_winner=true;
    return true;
  }

  function get_lottery_balance() public view returns (uint) {
    return address(this).balance;
  }

  function random(uint max_val) private view returns(uint) {
   return uint(keccak256(abi.encodePacked(block.difficulty, now, _participants))) % max_val;
  }

  function get_winner() public  returns (address){
    require(_found_winner, "Winner not found yet");
    require(_winner!=msg.sender, "Winner cannot be the lottery creator");
    _allow_new_participants=false;
    require(!_allow_new_participants, "at this, points, new participants should be allowed!");
    uint winner_index = random(_participants.length);
    _winner = _participants[winner_index];
    return _winner;
  }
}
