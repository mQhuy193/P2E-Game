// Đây là script TypeScript để deploy contract bằng Remix lên Celo Sepolia.
// Tên file: deploy.ts
// Tên contract: SimpleP2E (từ file SimpleP2E.sol)

// Khai báo các biến toàn cục (global) được cung cấp bởi Remix
declare var artifacts: any;
declare var ethers: any;
declare var web3Provider: any;

// Import các kiểu dữ liệu (types) từ ethers.
import { ContractFactory, Signer, Contract } from "ethers";

(async () => {
    try {
        console.log("Bắt đầu quá trình deploy lên Celo Sepolia (TypeScript)...");

        // Địa chỉ USDC (Bridged from Sepolia) trên Celo Sepolia Testnet
        const USDC_ADDRESS_SEPOLIA: string = "0x00Be9f205322F4359076C1E9A5B532E746F60216";
        
        // Tên artifact phải khớp với 'tên contract' (contract SimpleP2E)
        const artifactName: string = "SimpleP2E"; 

        // Đọc artifact (ABI, bytecode) của contract.
        // Script sẽ tìm artifact tên "SimpleP2E" đã được compile từ file "SimpleP2E.sol"
        const contractArtifact = await artifacts.readArtifact(artifactName);

        // Lấy signer (người ký) từ MetaMask
        const signer: Signer = (new ethers.providers.Web3Provider(web3Provider)).getSigner();
        const signerAddress: string = await signer.getAddress();

        // Tạo factory để deploy
        const contractFactory: ContractFactory = new ethers.ContractFactory(contractArtifact.abi, contractArtifact.bytecode, signer);

        console.log(`Đang deploy ${contractArtifact.contractName} bởi ${signerAddress}...`);
        console.log(`Sử dụng địa chỉ USDC: ${USDC_ADDRESS_SEPOLIA}`);
        
        // Deploy contract!
        const contract: Contract = await contractFactory.deploy(USDC_ADDRESS_SEPOLIA);

        // Chờ deploy thành công
        await contract.deployed();

        console.log("Deploy thành công!");
        console.log(`Địa chỉ contract: ${contract.address}`);

    } catch (e: any) {
        // Bắt lỗi và hiển thị rõ ràng
        console.error("Deploy thất bại:", e.message || e);
    }
})();
