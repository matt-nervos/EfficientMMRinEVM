//don't judge my grammar

contract EfficientMMRinEVM {

	uint8   constant MAX_HEIGHT = 32; //could be up to 256
	uint256 constant MAX_NUMBER_OF_ITEMS = (2**MAX_HEIGHT)-1;

	uint256 LastIndexNumber;

 	bytes32[MAX_HEIGHT] storage public peakArrayStorage;


  	function public getPeakRootHash(uint8 input) returns bytes32 {
    	return peakArrayStorage[input];
   		}


   	function public addValuesToMMR(bytes32[] input) {
		uint256 memory startIndex = LastIndexNumber;
		uint256 memory endIndex   = startIndex + input.Length;
		uint256 memory peakHeight = MAX_HEIGHT; //highest peak of MMR to check, OPTIMIZE by using the current highest peak height

		while (startIndex >> peakHeight = endIndex >> peakHeight){  //find where MMR start/end peaks diverge
			peakHeight--;
			}
	 	
		uint256 memory i = peakHeight;    //highest peak to load

		bytes32[i] memory peakArrayMemory; //declare array in memory to store temp peak values

		while(i>0) {				                   //load peaks from storage
			if((startIndex >> i) % 2 = 1){             //check if there is a bit at the height TODO: check for off by one
				peakArrayMemory[i]=peakArrayStorage[i];//assign peak value from storage to array in memory
				if((endIndex >> i) % 2 = 0){           //check if peak is present in endIndex
					peakArrayStorage[i]=0;             //if peak is not in endIndex, set to blank in storage
					}
			}
			i--
		}
	
		//check last bit
		if(startIndex % 2 = 1){                    
			peakArrayMemory[0]=peakArrayStorage[0];    //load stored value to memory
			if(endIndex % 2 = 0){                      //check if peak is present in endIndex
				peakArrayStorage[0]=0;                 //peak is not in endIndex, set to blank in storage
			}
		}
	
		//store values in MMR
		bytes32 memory tempMMRdata;                    //variable to hold temporary MMR data

		for(x<input.length; x=0; x++){                 //store values in MMR
			tempMMRdata=input[x];                      //TODO: check for off by one in length counter x
			i=0;    //counter

			while(){
				if(peakArrayMemory[i]=0){              //peak is currently empty
					peakArrayMemory[i]=tempMMRdata;    //store hash in peak
					break
				} else {                               //peak is occupied, concatenate values and hash
					tempMMRdata=sha3(abi.encodePacked(peakArrayMemory[i],tempMMRdata));
					peakArrayMemory[i]=0;              //clear the peak
					i++;
				}
			}
		}

		//store the new peaks
		for(i>0; i=peakArrayMemory.length; i--;){      //TODO: check for off by one in length counter i
			if (peakArrayMemory[i]!=0){
				peakArrayStorage[i]=peakArrayMemory[i];
				}
		}

		//store last peak
		if (peakArrayMemory[0]!=0){
			peakArrayStorage[0]=peakArrayMemory[0];
			}

		//update LastIndexNumber
		LastIndexNumber = endIndex;
	}
}