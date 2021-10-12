// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

/**
 * @title Storage
 * @dev Store & retrieve value in a variable
 */
contract Aero {
    string public name = "Aero";
    string public symbol = "AR";
    uint256 public supply = 100000000000000000000;
    uint256 public decimal = 18;
    bool public pureAero = true; //they can be impure when aero tokens are impure they loose their value

    event transfer(
        address indexed from,
        address indexed to,
        uint amount
    );

    event approval(
        address indexed from,
        address indexed to,
        uint amount
    );

    mapping(address => uint) public balanceOf;
    mapping(address => mapping(address => uint)) public allowance;

    constructor() public{
        balanceOf[msg.sender] = supply;
    }
    
    function getSender() public returns(address){
        return msg.sender;
    }

    function Transfer(address _sender,uint _value) public returns(bool success){
        require(balanceOf[msg.sender]>_value);
            balanceOf[msg.sender] -= _value;
            balanceOf[_sender] += _value;
            return true;
    }

    function approve(address _spender,uint _amount) public returns(bool success){
        allowance[msg.sender][_spender] = _amount;
        emit approval(msg.sender,_spender,_amount);
        return true;
    }

    function transferFrom(address _from,address _receiver,uint amount) public returns(bool success){
        require(allowance[msg.sender][_from]<amount);
        require(balanceOf[msg.sender]<amount);
        balanceOf[_from] -= amount;
        balanceOf[_receiver] += amount;
        allowance[msg.sender][_from]-=amount;
        emit approval(_from,_receiver,amount);
        return true;
    }
}