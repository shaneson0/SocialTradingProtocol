pragma solidity > 0.6.1;


import './SwapHelper.sol';

contract SocialTradingProtocol  {
    bytes32 experiencedTraderName;
    address experiencedTraderAddress;
    address [] socialTraderAddresses;
    mapping (address => int256) userBalances;
    mapping ( address => int256) userDeposited;
    mapping ( address => int256) userWithdrawed;


    // Test address. Only in testnet. 
    address public constant DAI = 0x6B175474E89094C44Da98b954EedeAC495271d0F;
    address public constant WETH9 = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;
    address public constant USDC = 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48;

    // Payable address can receive Ether
    address payable public owner;

    SwapHelper uniswapHelper;

    // Payable constructor can receive Ether

    constructor(bytes32 _experiencedTraderName, address _experiencedTraderAddress) payable {
        experiencedTraderName = _experiencedTraderName;
        experiencedTraderAddress = _experiencedTraderAddress;

        owner = payable(msg.sender);
    }


    // take Position swap usdc to token S
    // return amountOut. Caculate amountIn / amountOut by frontend or backend.
    // 1. swap token.
    // 2. modify userBalances

    function takPosition(uint256 amountIn, address tokenIn, address tokenOut) {
        
        uint256 amountout = uniswapHelper.saveSwap(amountIn, tokenIn, tokenOut);
    }


    // 1. swap token
    // 2. modity userBalances
    
    function closePosition(uint256 amountIn, address tokenIn, address tokenout) {
        uint256 amountout = uniswapHelper.saveSwap(amountIn, tokenIn, tokenOut);



    }


    // 1. deposit usdc.
    // 2. add social traders.
    // 3. add userDeposited.
    // 4. modify userBalances

    function deposit() public payable {

    }

    // Call this function along with some Ether.
    // The function will throw an error since this function is not payable.
    function notPayable() public {}

    // Function to withdraw all Ether from this contract.
    function withdraw() public {
        // get the amount of Ether stored in this contract
        uint amount = address(this).balance;

        // send all Ether to owner
        // Owner can receive Ether since the address of owner is payable
        (bool success, ) = owner.call{value: amount}("");
        require(success, "Failed to send Ether");
    }

    // Function to transfer Ether from this contract to address from input
    function transfer(address payable _to, uint _amount) public {
        // Note that "to" is declared as payable
        (bool success, ) = _to.call{value: _amount}("");
        require(success, "Failed to send Ether");
    }
    

}
