int setTries(int difficulty){
  // set default value for tries, and then we modify based on the difficulty setting
  int tries = 6; 
  switch (difficulty){
    case 5:{
      tries = 1;
      break;
    }
    case 4:{
      tries = 3;
      break;
    }
    case 2:{
      tries = 8;
      break;
    }
    case 1:{
      tries = 12;
      break;
    }
    default:{
      break;
    }
  }
  return tries;
}