// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract Leaderboard {
    struct Player {
        uint256 bestScore;
        uint256 lastUpdated;
    }

    mapping(address => Player) public players;
    address[] public playerAddresses;
    
    uint256 public constant MAX_LEADERBOARD_SIZE = 100;

    event NewHighScore(address indexed player, uint256 score);

    uint256 public constant MIN_FEE = 0.0001 ether; 

    function submitScore(uint256 _score) public payable {
        require(_score > 0, "Score must be greater than 0");
        require(msg.value >= MIN_FEE, "Insufficient fee");

        Player storage p = players[msg.sender];

        if (p.bestScore == 0) {
            playerAddresses.push(msg.sender);
        }

        if (_score > p.bestScore) {
            p.bestScore = _score;
            p.lastUpdated = block.timestamp;
            emit NewHighScore(msg.sender, _score);

            
            if (playerAddresses.length > MAX_LEADERBOARD_SIZE) {
                address lowestScorer = getLowestScorer();
                removePlayerFromLeaderboard(lowestScorer);
            }
        }
    }

    function getLowestScorer() internal view returns (address) {
        address lowestScorer = playerAddresses[0];
        for (uint256 i = 1; i < playerAddresses.length; i++) {
            if (players[playerAddresses[i]].bestScore < players[lowestScorer].bestScore) {
                lowestScorer = playerAddresses[i];
            }
        }
        return lowestScorer;
    }

    function removePlayerFromLeaderboard(address player) internal {
        for (uint256 i = 0; i < playerAddresses.length; i++) {
            if (playerAddresses[i] == player) {
                playerAddresses[i] = playerAddresses[playerAddresses.length - 1];
                playerAddresses.pop();
                break;
            }
        }
    }

    function getMyBestScore() public view returns (uint256) {
        return players[msg.sender].bestScore;
    }

    function getLeaderboard() public view returns (address[] memory, uint256[] memory) {
        uint256 len = playerAddresses.length;
        uint256[] memory scores = new uint256[](len);

        for (uint256 i = 0; i < len; i++) {
            scores[i] = players[playerAddresses[i]].bestScore;
        }

        return (playerAddresses, scores);
    }
}

