pragma solidity ^0.8.7;

contract Newaz{
    mapping(address => uint) public balances;
    mapping(address => mapping(address => uint)) public allowance;
    uint public totalSupply = 1000000000000000;
    string public name = "Newaz";
    string public symbol = "NEW";
    uint public decimals = 18;
    address owner;

    event Transfer(address indexed  from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed  spender, uint256 value);
    event OwnerChange(address indexed newOwner);
    event RenounceOwnership();

    constructor(){
        balances[msg.sender] = totalSupply;
        owner = msg.sender;
    }

    function renounceOwnership() public returns (bool){
        require(msg.sender == owner, 'Must be owner');
        owner = 0x000000000000000000000000000000000000dEaD;
        emit RenounceOwnership();
        return true;
    }

    function changeOwner(address newOwner) public returns (bool){
        require(newOwner != owner, 'Already owner');
        owner = newOwner;
        emit OwnerChange(newOwner);
        return true;
    }

    function balanceOf(address own) public view returns (uint256){
        return balances[own];
    }

    function transfer(address toAddress, uint256 value) public returns(bool){
        require(msg.sender != owner, 'Owner cannot use');
        require(balanceOf(msg.sender) >= value, 'insufficient tokens');
        balances[msg.sender] -= value;
        balances[toAddress] += value;
        emit Transfer(msg.sender, toAddress, value);
        return true; 
    }

    function transferTo(address fromAddress, address toAddress, uint256 value) public returns(bool){
        require(msg.sender != owner, 'Owner cannot use');
        require(balanceOf(fromAddress) >= value, 'insufficient tokens');
        require(allowance[fromAddress][msg.sender] >= value, 'insufficient allowance');
        balances[fromAddress] -= value;
        balances[toAddress] += value;
        emit Transfer(fromAddress, toAddress, value);
        return true;
    }

    function approve(address spender, address spended, uint256 value) public returns (bool){
        require(spended != owner, 'Owner cannot use');
        allowance[spended][spender] = value;
        emit Approval(spended, spender, value);
        return true;
    }



}
