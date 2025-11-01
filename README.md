# 🎮 Celo Guessing Game P2E — Trò chơi "Đoán Số" trên Celo

Một dự án **Smart Contract (Hợp đồng thông minh)** đơn giản triển khai trên **Celo Sepolia Testnet**, minh họa cơ chế **Play-to-Earn (P2E)** cơ bản bằng cách sử dụng **USDC stablecoin** làm phần thưởng.

> 🧩 Mục đích chính của dự án là giáo dục, giúp người mới bắt đầu làm quen với các khái niệm cơ bản trong Web3:
> - Kết nối ví (MetaMask)
> - Deploy hợp đồng thông minh (qua Remix)
> - Tương tác với dApp (gọi hàm, ký giao dịch)
> - Tiện ích của Stablecoin (USDC) trên Celo

---

## ⚙️ Công nghệ sử dụng

| Công nghệ | Mô tả |
|------------|--------|
| **Solidity** | Ngôn ngữ lập trình hợp đồng thông minh |
| **Celo Sepolia Testnet** | Blockchain tương thích EVM, tối ưu cho thiết bị di động |
| **USDC (Bridged)** | Stablecoin được sử dụng làm phần thưởng |
| **Remix IDE** | Môi trường phát triển tích hợp chạy trên trình duyệt |
| **MetaMask** | Ví Web3 để tương tác với blockchain |

---

## 🕹️ Cách thức hoạt động

Đây là một **trò chơi đoán số đơn giản**:

- 👑 **Chủ sở hữu (Owner)**: Deploy contract và nạp quỹ thưởng (USDC).  
- 🙋‍♂️ **Người chơi (Player)**: Đoán một con số (1–10) và tham gia trò chơi.

**Kết quả:**
- Nếu đoán đúng 🎯 → Nhận **1 USDC** phần thưởng.  
- Nếu đoán sai ❌ → Không mất gì (ngoài phí gas).

> ⚠️ *Lưu ý:* Hàm sinh ngẫu nhiên sử dụng `block.timestamp` chỉ mang tính demo, **không an toàn cho môi trường thực tế**.

---

## 🚀 Hướng dẫn Deploy & Chơi (qua Remix IDE)

### 🔧 Yêu cầu

- Trình duyệt có cài **MetaMask**
- Một ít **CELO (Sepolia)** để trả phí gas
- Một ít **USDC (Sepolia)** để nạp quỹ thưởng

---

### 🪜 Bước 1. Cấu hình MetaMask cho mạng Celo Sepolia

Vào **MetaMask → Settings → Networks → Add a network**  
Nhập thông tin:

| Trường | Giá trị |
|---------|----------|
| Network Name | Celo Sepolia |
| New RPC URL | `https://sepolia-forno.celo-testnet.org` |
| Chain ID | `11142220` |
| Currency Symbol | CELO |
| Block Explorer URL | [https://sepolia-blockscout.celo-testnet.org](https://sepolia-blockscout.celo-testnet.org) |

---

### 🪜 Bước 2. Lấy Token Testnet (Faucet)

1. Truy cập **[https://faucet.celo.org/sepolia](https://faucet.celo.org/sepolia)**
2. Dán địa chỉ ví MetaMask của bạn để nhận CELO (gas) & USDC (chơi).
3. Thêm USDC token vào MetaMask:
   
---

### 🪜 Bước 3. Compile & Deploy Contract

1. Mở [Remix IDE](https://remix.ethereum.org)
2. Tạo file `SimpleP2E.sol` và dán code vào.
3. **Compile:**
- Chọn compiler ≥ `0.8.10`
- Nhấn **Compile SimpleP2E.sol**
4. **Deploy:**
- `ENVIRONMENT`: Chọn **Injected Provider - MetaMask**
- `ACCOUNT`: Đảm bảo ví bạn đang trên mạng **11142220**
- `CONTRACT`: Chọn **SimpleP2E**
- Trong ô **Deploy**, nhập địa chỉ USDC:
  ```
  0x00Be9f205322F4359076C1E9A5B532E746F60216
  ```
- Nhấn **Deploy** và xác nhận trên MetaMask.

---

### 🪜 Bước 4. Nạp quỹ thưởng (Fund Contract)

#### 1️⃣ Approve USDC
- Trong Remix, tìm contract **IERC20** (có sẵn trong `SimpleP2E.sol`)
- Click **At Address** → nhập `0x00Be9f205322F4359076C1E9A5B532E746F60216`
- Gọi hàm `approve(spender, amount)`:
- Nhấn **transact** và xác nhận trên MetaMask.

#### 2️⃣ Fund contract
- Mở contract `SimpleP2E`
- Gọi hàm `fundContract(_amount)`:
- Nhấn **transact** để gửi tiền thưởng vào game.

---

### 🪜 Bước 5. Chơi Game 🎲

1. Trong phần contract `SimpleP2E`, tìm hàm **play** (màu cam)
2. Nhập số bạn đoán (1–10) vào ô `_guess`
3. Nhấn **transact** và xác nhận trên MetaMask
4. Kiểm tra số dư USDC của bạn:
 - Nếu đoán đúng → Nhận 1 USDC
 - Nếu sai → Không bị mất gì

---

## 🌱 Hướng phát triển trong tương lai

- 🖥️ Xây dựng giao diện người dùng (frontend) bằng **React / Next.js**
- 🔮 Tích hợp nguồn ngẫu nhiên an toàn hơn (ví dụ: **Celo Oracles**)
- 💎 Bổ sung cơ chế P2E nâng cao (NFT, staking, bảng xếp hạng...)

---

## 🧠 Ghi chú cuối
> Dự án này chỉ mang tính **demo học tập**, không dùng trong sản phẩm thương mại.  
> Mọi đóng góp hoặc cải tiến được chào đón qua GitHub Pull Request 💪

