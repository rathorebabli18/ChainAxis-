// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

/**
 * @title ChainAxis
 * @notice A decentralized data exchange and analytics protocol that allows users
 *         to submit datasets, purchase data access, and reward contributors transparently.
 */
contract Project {
    address public admin;
    uint256 public datasetCount;

    struct Dataset {
        uint256 id;
        address owner;
        string metadata;
        uint256 price;
        uint256 downloads;
    }

    mapping(uint256 => Dataset) public datasets;
    mapping(address => mapping(uint256 => bool)) public hasAccess;

    event DatasetUploaded(uint256 indexed id, address indexed owner, string metadata, uint256 price);
    event DataPurchased(uint256 indexed id, address indexed buyer);
    event DatasetPriceUpdated(uint256 indexed id, uint256 newPrice);

    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can perform this action");
        _;
    }

    modifier onlyOwner(uint256 _id) {
        require(datasets[_id].owner == msg.sender, "Not dataset owner");
        _;
    }

    constructor() {
        admin = msg.sender;
    }

    /**
     * @notice Upload a dataset with metadata and price
     * @param _metadata A short description or IPFS hash of dataset
     * @param _price Access price in wei
     */
    function uploadDataset(string memory _metadata, uint256 _price) external {
        require(bytes(_metadata).length > 0, "Metadata required");
        require(_price > 0, "Price must be greater than zero");

        datasetCount++;
        datasets[datasetCount] = Dataset(datasetCount, msg.sender, _metadata, _price, 0);

        emit DatasetUploaded(datasetCount, msg.sender, _metadata, _price);
    }

    /**
     * @notice Purchase access to a dataset
     * @param _id Dataset ID
     */
    function purchaseDataset(uint256 _id) external payable {
        Dataset storage ds = datasets[_id];
        require(ds.id > 0 && ds.id <= datasetCount, "Invalid dataset ID");
        require(msg.value == ds.price, "Incorrect payment amount");
        require(!hasAccess[msg.sender][_id], "Already purchased");

        hasAccess[msg.sender][_id] = true;
        ds.downloads++;

        payable(ds.owner).transfer(msg.value);

        emit DataPurchased(_id, msg.sender);
    }

    /**
     * @notice Update dataset price (only owner)
     * @param _id Dataset ID
     * @param _newPrice New access price
     */
    fu
// 
End
// 
