import React, { useState, useEffect } from "react";
import Web3Modal from "web3modal";
import { ethers } from "ethers";
import axios from "axios";
import { useRouter } from "next/router";

// Internal import
import { VotingAddress, VotingAddressABI } from "./constant";

// Remove IPFS client since it's no longer needed
// const client = ipfsHttpClient(`https://ipfs.infura.io:5001/api/v0`); 

const fetchContract = (signerOrProvider) => new ethers.Contract(VotingAddress, VotingAddressABI, signerOrProvider);

export const VotingContext = React.createContext(); // We’ll be using React context for sharing data throughout our application

export const VotingProvider = ({ children }) => {
  const votingTitle = 'My first smart contract app';
  const router = useRouter(); // Corrected hook name
  const [currentAccount, setCurrentAccount] = useState('');
  const [candidateArray, setCandidateArray] = useState([]);
  const [error, setError] = useState('');
  const [voterArray, setVoterArray] = useState([]);
  const [voterLength, setVoterLength] = useState('');
  const [voterAddress, setVoterAddress] = useState([]);

  // Check if wallet is connected
  const checkIfWalletIsConnected = async () => {
    if (!window.ethereum) return setError("Please Install Metamask");
    const accounts = await window.ethereum.request({ method: "eth_accounts" });
    if (accounts.length) {
      setCurrentAccount(accounts[0]);
    } else {
      setError("Please install Metamask and connect wallet, reload");
    }
  };

  // Connect wallet
  const connectWallet = async () => {
    if (!window.ethereum) return setError("Please Install MetaMask");
    const accounts = await window.ethereum.request({ method: "eth_requestAccounts" });
    setCurrentAccount(accounts[0]);
  };

  // Placeholder function for uploading to IPFS
  const uploadToIPFS = async (file) => {
    try {
      // const added = await client.add({ content: file });
      // const url = `https://ipfs.infura.io/ipfs/${added.path}`;
      // return url;
      return ""; // Return a placeholder URL
    } catch (error) {
      setError("Error Uploading file to IPFS");
    }
  };

  return (
    <VotingContext.Provider value={{ votingTitle, checkIfWalletIsConnected, connectWallet }}>
      {children}
    </VotingContext.Provider>
  );
};

const Voter = () => {
  return (
    <div>Voter</div>
  );
}

export default Voter;
