initial supply for simulation
    }

    /**
     * @notice Transfer tokens and automatically log an audit record
     * @param _to Recipient address
     * @param _amount Amount of tokens to transfer
     * @param _note Description or purpose of transfer
     */
    function transfer(address _to, uint256 _amount, string memory _note) external {
        require(_to != address(0), "Invalid address");
        require(balances[msg.sender] >= _amount, "Insufficient balance");
        require(bytes(_note).length > 0, "Transfer note required");

        balances[msg.sender] -= _amount;
        balances[_to] += _amount;

        auditCount++;
        audits[auditCount] = AuditEntry(auditCount, msg.sender, _to, _amount, block.timestamp, _note);

        emit TokenTransferred(msg.sender, _to, _amount, _note);
        emit AuditRecorded(auditCount, msg.sender, _to, _amount, _note);
    }

    /**
     * @notice View an audit record by ID
     * @param _id Audit record ID
     */
    function getAudit(uint256 _id) external view returns (AuditEntry memory) {
        require(_id > 0 && _id <= auditCount, "Invalid audit ID");
        return audits[_id];
    }

    /**
     * @notice Mint tokens to an address (admin only)
     * @param _to Address to receive tokens
     * @param _amount Amount to mint
     */
    function mint(address _to, uint256 _amount) external onlyAdmin {
        require(_to != address(0), "Invalid address");
        balances[_to] += _amount;
    }

    /**
     * @notice Get balance of any address
     * @param _user Address to query
     */
    function getBalance(address _user) external view returns (uint256) {
        return balances[_user];
    }
}
// 
End
// 
