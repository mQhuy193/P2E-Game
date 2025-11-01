// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

/**
 * @title IERC20
 * @dev Giao diện (Interface) tối thiểu cho một token ERC20 (như USDC).
 * Chúng ta chỉ cần `balanceOf`, `transfer`, `approve` và `transferFrom`.
 */
interface IERC20 {
    function balanceOf(address account) external view returns (uint256);
    function transfer(address recipient, uint256 amount) external returns (bool);
    function approve(address spender, uint256 amount) external returns (bool);
    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external returns (bool);
    
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
}

/**
 * @title SimpleP2E
 * @dev Một game P2E đơn giản trên Celo.
 * Người chơi đoán một số từ 1 đến 10.
 * Nếu đoán đúng, họ thắng 1 USDC.
 * Chủ sở hữu contract (owner) cần nạp USDC vào contract để làm quỹ thưởng.
 */
contract SimpleP2E {
    IERC20 public stableToken; // Biến để giữ địa chỉ contract của USDC
    address public owner; // Chủ sở hữu của contract này (người deploy)
    
    // Thưởng 1 USDC. 
    // Mặc dù USDC trên Ethereum có 6 chữ số thập phân,
    // USDC trên Celo (bridged) sử dụng 18 chữ số thập phân.
    uint256 public constant REWARD_AMOUNT = 1 * 1e18;
    
    // Biến theo dõi tổng quỹ thưởng
    uint256 public prizePool;

    // Sự kiện (Events) để thông báo kết quả
    event GameWon(address indexed player, uint256 guess, uint256 winningNumber);
    event GameLost(address indexed player, uint256 guess, uint256 winningNumber);
    event Funded(address indexed funder, uint256 amount);

    /**
     * @dev Hàm khởi tạo (Constructor)
     * @param _stableTokenAddress Địa chỉ của token USDC trên mạng Celo Sepolia
     */
    constructor(address _stableTokenAddress) {
        stableToken = IERC20(_stableTokenAddress);
        owner = msg.sender;
    }

    /**
     * @dev Hàm nạp tiền vào quỹ thưởng (chỉ chủ sở hữu).
     * QUAN TRỌNG: Chủ sở hữu phải `approve` contract này trước khi gọi hàm.
     */
    function fundContract(uint256 _amount) public {
        require(msg.sender == owner, "Only owner can fund");
        require(_amount > 0, "Amount must be greater than 0");

        // Chuyển USDC từ chủ sở hữu vào contract này
        bool success = stableToken.transferFrom(msg.sender, address(this), _amount);
        require(success, "USDC transfer failed");

        prizePool += _amount;
        emit Funded(msg.sender, _amount);
    }

    /**
     * @dev Hàm chính của game.
     * @param _guess Số người chơi đoán (từ 1 đến 10).
     */
    function play(uint256 _guess) public {
        require(_guess >= 1 && _guess <= 10, "Guess must be between 1 and 10");
        require(prizePool >= REWARD_AMOUNT, "Prize pool is empty!");

        // Tạo số ngẫu nhiên (đơn giản, KHÔNG AN TOÀN cho sản phẩm thật)
        uint256 winningNumber = _generateRandomNumber();

        if (_guess == winningNumber) {
            // Thắng!
            prizePool -= REWARD_AMOUNT;
            
            // Gửi 1 USDC cho người chơi
            bool success = stableToken.transfer(msg.sender, REWARD_AMOUNT);
            require(success, "Failed to transfer reward");

            emit GameWon(msg.sender, _guess, winningNumber);
        } else {
            // Thua
            emit GameLost(msg.sender, _guess, winningNumber);
        }
    }

    /**
     * @dev Hàm nội bộ để tạo số "ngẫu nhiên". (Không an toàn cho sản phẩm thật)
     */
    function _generateRandomNumber() private view returns (uint256) {
        return (uint256(keccak256(abi.encodePacked(block.timestamp, block.difficulty, msg.sender))) % 10) + 1;
    }

    /**
     * @dev Lấy số dư quỹ thưởng hiện tại.
     */
    function getPrizePoolBalance() public view returns (uint256) {
        return prizePool;
    }

    /**
     * @dev Chủ sở hữu rút USDC còn lại (nếu cần).
     */
    function withdrawFunds() public {
        require(msg.sender == owner, "Only owner");
        uint256 balance = stableToken.balanceOf(address(this));
        if (balance > 0) {
            bool success = stableToken.transfer(owner, balance);
            require(success, "Withdraw failed");
            prizePool = 0;
        }
    }
}
