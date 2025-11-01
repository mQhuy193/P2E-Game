Game P2E "Đoán Số" trên Celo (Celo Guessing Game P2E)

Một dự án Hợp đồng Thông minh (Smart Contract) đơn giản được xây dựng trên Celo Sepolia Testnet, minh họa cơ chế Play-to-Earn (P2E) cơ bản bằng cách sử dụng stablecoin (USDC).

Dự án này được tạo ra chủ yếu cho mục đích giáo dục, giúp người mới bắt đầu hiểu các khái niệm cơ bản của Web3 như:

Kết nối ví (MetaMask)

Deploy hợp đồng thông minh (qua Remix)

Tương tác với dApp (gọi hàm, ký giao dịch)

Tiện ích của Stablecoin (USDC) trên Celo

1. Công nghệ sử dụng

Solidity: Ngôn ngữ lập trình Hợp đồng Thông minh.

Celo (Sepolia Testnet): Nền tảng blockchain tương thích EVM, ưu tiên thiết bị di động.

USDC (Bridged): Stablecoin được sử dụng làm phần thưởng.

Remix IDE: Môi trường phát triển tích hợp (IDE) dựa trên trình duyệt.

MetaMask: Ví Web3 để tương tác với blockchain.

2. Cách thức hoạt động

Đây là một trò chơi đoán số đơn giản:

Chủ sở hữu (Owner): Deploy contract và nạp quỹ thưởng (USDC) vào đó.

Người chơi (Player): Trả một khoản phí nhỏ (hiện đang là 0) để đoán một con số (từ 1 đến 10).

Kết quả:

Nếu người chơi đoán đúng con số bí mật (được tạo ngẫu nhiên một cách đơn giản), họ sẽ thắng và nhận được 1 USDC từ quỹ thưởng.

Nếu người chơi đoán sai, họ không mất gì (ngoài phí gas).

Lưu ý: Cơ chế ngẫu nhiên trong contract này (block.timestamp) không an toàn cho sản xuất thực tế và chỉ dùng cho mục đích demo.

3. Hướng dẫn Deploy và Chơi (Sử dụng Remix)

Yêu cầu

Trình duyệt có cài đặt ví MetaMask.

Một ít token CELO (Sepolia) để trả phí gas.

Một ít token USDC (Sepolia) để nạp quỹ thưởng.

Bước 1: Cấu hình MetaMask cho Celo Sepolia

Nếu bạn chưa thêm mạng, hãy vào MetaMask > Settings > Networks > Add a network và nhập:

Network Name: Celo Sepolia

New RPC URL: https://sepolia-forno.celo-testnet.org

Chain ID: 11142220

Currency Symbol: CELO

Block Explorer URL: https://sepolia-blockscout.celo-testnet.org

Bước 2: Lấy Token Testnet (Faucet)

Truy cập Celo Sepolia Faucet: https://faucet.celo.org/sepolia

Dán địa chỉ ví của bạn để nhận CELO (phí gas) và USDC (để chơi).

Thêm USDC vào MetaMask bằng cách "Import tokens" với địa chỉ:
0x00Be9f205322F4359076C1E9A5B532E746F60216

Bước 3: Compile và Deploy Contract

Mở Remix IDE.

Tạo file mới SimpleP2E.sol và dán code hợp đồng vào.

Chuyển sang tab "Solidity Compiler":

Chọn compiler phiên bản 0.8.10 (hoặc cao hơn).

Nhấn "Compile SimpleP2E.sol".

Chuyển sang tab "Deploy & Run Transactions":

ENVIRONMENT: Chọn "Injected Provider - MetaMask". (MetaMask sẽ yêu cầu kết nối).

ACCOUNT: Đảm bảo ví của bạn (mạng 11142220) được hiển thị.

CONTRACT: Chọn contract SimpleP2E.

Ô Deploy: Ngay bên cạnh nút "Deploy", dán địa chỉ USDC (Sepolia):
0x00Be9f205322F4359076C1E9A5B532E746F60216

Nhấn "Deploy" và xác nhận giao dịch trên MetaMask.

Sau khi thành công, contract của bạn sẽ xuất hiện ở mục "Deployed Contracts".

Bước 4: Tương tác với Game

A. Nạp quỹ thưởng (Bắt buộc)

Bạn (với tư cách là chủ contract) cần cấp phép và nạp USDC vào game.

Approve (Phê duyệt):

Tìm mục "Deployed Contracts", tìm IERC20 (từ file SimpleP2E.sol).

Trong ô "At Address", dán địa chỉ USDC (0x00...6bF4) và nhấn nút "At Address".

Giờ bạn sẽ có một instance IERC20 ở dưới. Mở nó ra.

Gọi hàm approve:

spender (địa chỉ P2E): Dán địa chỉ contract SimpleP2E bạn vừa deploy.

amount: 10000000000000000000 (đây là 10 USDC, với 18 số 0).

Nhấn "transact" và xác nhận.

Fund (Nạp tiền):

Quay lại instance contract SimpleP2E của bạn.

Gọi hàm fundContract với _amount: 10000000000000000000
md
Nhấn "transact" và xác nhận.

B. Chơi Game

Mở instance SimpleP2E.

Tìm hàm play (màu cam).

Nhập số bạn đoán (ví dụ: 5) vào ô _guess.

Nhấn "transact" và xác nhận giao dịch.

Kiểm tra số dư USDC của bạn. Nếu thắng, bạn sẽ nhận được 1 USDC!

4. Cải tiến trong tương lai

Xây dựng một giao diện người dùng (frontend) đơn giản bằng React/Next.js.

Tích hợp một nguồn ngẫu nhiên an toàn hơn (ví dụ: Celo Oracles).

Thêm các cơ chế P2E phức tạp hơn (ví dụ: NFT, staking).
