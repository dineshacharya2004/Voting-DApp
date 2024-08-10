import React, { useState, useEffect, useContext } from "react";
import Image from "next/image";
import Countdown from "react-countdown";

// Internal import
import { VotingContext } from "../context/Voter";
import Style from "../styles/index.module.css";
import Card from "../components/Card/Card";
import image from "../assets/candidate-1.jpg";

const Home = () => {
  const { votingTitle } = useContext(VotingContext);
  return (
    <div className={Style.container}>
      <h1>{votingTitle}</h1>
      <Image src={image} alt="Candidate" width={500} height={500} />
    </div>
  );
};

export default Home; // Corrected the component name to follow convention
