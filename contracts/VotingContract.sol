
// pragma solidity ^0.8.9;

// import "@openzeppelin/contracts/utils/Counters.sol";  // to keep a count of every candidate and voter
// import "hardhat/console.sol"; // to see the logs in our console

// contract Create {
//     using Counters for Counters.Counter;
//     Counters.Counter public _voterId;
//     Counters.Counter public _candidateId;

//     address public votingOrganizer;

//     // Candidate for voting
//     struct Candidate {
//         uint256 candidateId;
//         string age; // can be number also
//         string name;
//         string image;
//         uint256 voteCount;
//         address _address;
//         string ipfs; // IPFS will contain all information about single candidate.
//     }

//     // Event is a very cheap way to store data on blockchain
//     event CandidateCreate(   
//         uint256 indexed candidateId,
//         string age, 
//         string name,
//         string image,
//         uint256 voteCount,
//         address _address,
//         string ipfs
//     );

//     address[] public candidateAddress; // store address of all candidates
//     mapping(address => Candidate) public candidates;

//     //End ofCandiate data

//     // Voter data
//     address[] public votedVoters;
//     address[] public votersAddress;
//     mapping (address => Voter) public voters;

//     struct Voter {
//         uint256 voter_voter_Id;
//         string voter_name;
//         string voter_image;
//         address voter_address;
//         uint256 voter_allowed;
//         bool voter_voted;
//         uint256 voter_vote;
//         string voter_ipfs;  
//     }

//     event VoterCreated (
//         uint256 indexed voter_voter_Id,
//         string voter_name,
//         string voter_image,
//         address voter_address,
//         uint256 voter_allowed,
//         bool voter_voted,
//         uint256 voter_vote,
//         string voter_ipfs  
//     );

//     //End of Voter Data
//     constructor() {
//         votingOrganizer = msg.sender; // the one who will deploy the smart contract
//     }

//     function setCandidate(address _address, string memory _age, string memory _name, string memory _image, string memory _ipfs) public {
//         require(votingOrganizer == msg.sender, "Only organizer can create a candidate");
        
//         _candidateId.increment();

//         uint256 idNumber = _candidateId.current(); // current id of candidate

//         Candidate storage candidate = candidates[_address];
//         candidate.candidateId = idNumber;
//         candidate.age = _age;
//         candidate.name = _name;
//         candidate.image = _image;
//         candidate.voteCount = 0;
//         candidate._address = _address;
//         candidate.ipfs = _ipfs;

//         candidateAddress.push(_address);

//         //below should be in same order as above
//         emit CandidateCreate(idNumber, _age, _name, _image, candidate.voteCount, _address, _ipfs);
//     }

//     function getCandidate() public view returns (address[] memory) {
//         return candidateAddress;
//     }

//     function getCandidateLength() public view returns (uint256) {
//         return candidateAddress.length;
//     }

//     function getCandidatedata(address _address) public view returns (string memory, string memory, uint256, string memory, uint256, string memory, address) {
//         Candidate storage candidate = candidates[_address];
//         return (
//             candidates[_address].age,
//             candidates[_address].name,
//             candidates[_address].candidateId,
//             candidates[_address].image,
//             candidates[_address].voteCount,
//             candidates[_address].ipfs,
//             candidates[_address]._address
//         );
//     }

//     // Voter section
//     function voterRight(address _address, string memory _name, string memory _image, string memory _ipfs) public {
//         require(votingOrganizer == msg.sender, "Only organizer can create voter");

//         _voterId.increment();
//         uint256 idNumber = _voterId.current();

//         Voter storage voter = voters[_address];
//         require(voter.voter_allowed == 0, "Voter is already registered");

//         voter.voter_voter_Id = idNumber;
//         voter.voter_name = _name;
//         voter.voter_image = _image;
//         voter.voter_address = _address;
//         voter.voter_allowed = 1;
//         voter.voter_vote = 1000;
//         voter.voter_voted = false;
//         voter.voter_ipfs = _ipfs;

//         votersAddress.push(_address);

//         emit VoterCreated(idNumber, _name, _image, _address, voter.voter_allowed, voter.voter_voted, voter.voter_vote, _ipfs);
//     }

//     function vote(address _candidateAddress, uint256 _candidateVoteID) external {
//         Voter storage voter = voters[msg.sender];

//         require(!voter.voter_voted, "You have already voted");
//         require(voter.voter_allowed != 0, "You have no right to vote");

//         voter.voter_voted = true;
//         voter.voter_vote = _candidateVoteID;

//         votedVoters.push(msg.sender);
//         candidates[_candidateAddress].voteCount += voter.voter_allowed;
//     }

//     function getVoterLength() public view returns (uint256) {
//         return votersAddress.length;
//     }

//     function getVoterdata(address _address) public view returns (uint256, string memory, string memory, address, string memory, uint256, bool) {
//         Voter storage voter = voters[_address];
//         return (
//             voters[_address].voter_voter_Id,
//             voters[_address].voter_name,
//             voters[_address].voter_image,
//             voters[_address].voter_address,
//             voters[_address].voter_ipfs,
//             voters[_address].voter_allowed,
//             voters[_address].voter_voted
//         );
//     }

//     function getVotedVoterList() public view returns (address[] memory) {
//         return votedVoters;
//     }

//     function getVoterList() public view returns (address[] memory) {
//         return votersAddress;
//     }
// }


// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/utils/Counters.sol";  // to keep a count of every candidate and voter
import "hardhat/console.sol"; // to see the logs in our console

contract Create {
    using Counters for Counters.Counter;
    Counters.Counter public _voterId;
    Counters.Counter public _candidateId;

    address public votingOrganizer;

    // Candidate for voting
    struct Candidate {
        uint256 candidateId;
        string age; // can be a number also
        string name;
        string image;
        uint256 voteCount;
        address _address;
        string ipfs; // IPFS will contain all information about a single candidate.
    }

    // Event is a very cheap way to store data on blockchain
    event CandidateCreate(   
        uint256 indexed candidateId,
        string age, 
        string name,
        string image,
        uint256 voteCount,
        address _address,
        string ipfs
    );

    address[] public candidateAddress; // store address of all candidates
    mapping(address => Candidate) public candidates;

    // End of Candidate data

    // Voter data
    address[] public votedVoters;
    address[] public votersAddress;
    mapping(address => Voter) public voters;

    struct Voter {
        uint256 voter_voter_Id;
        string voter_name;
        string voter_image;
        address voter_address;
        uint256 voter_allowed;
        bool voter_voted;
        uint256 voter_vote;
        string voter_ipfs;  
    }

    event VoterCreated (
        uint256 indexed voter_voter_Id,
        string voter_name,
        string voter_image,
        address voter_address,
        uint256 voter_allowed,
        bool voter_voted,
        uint256 voter_vote,
        string voter_ipfs  
    );

    // End of Voter Data
    constructor() {
        votingOrganizer = msg.sender; // the one who will deploy the smart contract
    }

    function setCandidate(address _address, string memory _age, string memory _name, string memory _image, string memory _ipfs) public {
        require(votingOrganizer == msg.sender, "Only organizer can create a candidate");
        
        _candidateId.increment();

        uint256 idNumber = _candidateId.current(); // current id of candidate

        Candidate storage candidate = candidates[_address];
        candidate.candidateId = idNumber;
        candidate.age = _age;
        candidate.name = _name;
        candidate.image = _image;
        candidate.voteCount = 0;
        candidate._address = _address;
        candidate.ipfs = _ipfs;

        candidateAddress.push(_address);

        emit CandidateCreate(idNumber, _age, _name, _image, candidate.voteCount, _address, _ipfs);
    }

    function getCandidate() public view returns (address[] memory) {
        return candidateAddress;
    }

    function getCandidateLength() public view returns (uint256) {
        return candidateAddress.length;
    }

    function getCandidateBasicData(address _address) public view returns (string memory, string memory, uint256) {
        Candidate storage candidate = candidates[_address];
        return (
            candidate.age,
            candidate.name,
            candidate.candidateId
        );
    }

    function getCandidateAdditionalData(address _address) public view returns (string memory, uint256, string memory, address) {
        Candidate storage candidate = candidates[_address];
        return (
            candidate.image,
            candidate.voteCount,
            candidate.ipfs,
            candidate._address
        );
    }

    // Voter section
    function voterRight(address _address, string memory _name, string memory _image, string memory _ipfs) public {
        require(votingOrganizer == msg.sender, "Only organizer can create voter");

        _voterId.increment();
        uint256 idNumber = _voterId.current();

        Voter storage voter = voters[_address];
        require(voter.voter_allowed == 0, "Voter is already registered");

        voter.voter_voter_Id = idNumber;
        voter.voter_name = _name;
        voter.voter_image = _image;
        voter.voter_address = _address;
        voter.voter_allowed = 1;
        voter.voter_vote = 1000;
        voter.voter_voted = false;
        voter.voter_ipfs = _ipfs;

        votersAddress.push(_address);

        emit VoterCreated(idNumber, _name, _image, _address, voter.voter_allowed, voter.voter_voted, voter.voter_vote, _ipfs);
    }

    function vote(address _candidateAddress, uint256 _candidateVoteID) external {
        Voter storage voter = voters[msg.sender];

        require(!voter.voter_voted, "You have already voted");
        require(voter.voter_allowed != 0, "You have no right to vote");

        voter.voter_voted = true;
        voter.voter_vote = _candidateVoteID;

        votedVoters.push(msg.sender);
        candidates[_candidateAddress].voteCount += voter.voter_allowed;
    }

    function getVoterLength() public view returns (uint256) {
        return votersAddress.length;
    }

    function getVoterdata(address _address) public view returns (uint256, string memory, string memory, address, string memory, uint256, bool) {
        Voter storage voter = voters[_address];
        return (
            voter.voter_voter_Id,
            voter.voter_name,
            voter.voter_image,
            voter.voter_address,
            voter.voter_ipfs,
            voter.voter_allowed,
            voter.voter_voted
        );
    }

    function getVotedVoterList() public view returns (address[] memory) {
        return votedVoters;
    }

    function getVoterList() public view returns (address[] memory) {
        return votersAddress;
    }
}
