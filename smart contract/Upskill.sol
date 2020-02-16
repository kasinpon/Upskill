pragma solidity 0.5.16;
pragma experimental ABIEncoderV2;

contract Upskill {
    
  struct Skill {
      address memaddress;
      string nameskill;
      string description;
      string[] linkPicture;
    //   address[] approvals;
    //   mapping(uint256 =>  mapping(address => address)) public skills;
    //   mapping(address => address);
  }
  
  struct Member {
      string Email;
      string Mpass;
      string Company;
      string Job;
      string Description;
  }
  
  
//   struct 

//   mapping(uint256 => Skill) public skills;

//   mapping (address => mapping(address => Skill[]))
  
//   mapping (address => mapping(uint256 => address)) 
  
  // skill id, 1,2,3,...
  
//   string[] public test;
  
  mapping(string =>  mapping(address => address)) public skillrelation;
  mapping (address => Skill[]) public skills;
  mapping (address => Member) public members;

//   mapping (string => uint256) skillReceived;
//   string[] public candidateList;

//   event VoteReceived(address user, string candidate);

//   constructor(string[] memory candidateNames) public {
//     candidateList = candidateNames;
//   }

  function addSkill(string memory nameskill ,string memory description) public  {
      address me = msg.sender;
      string[] memory emptyArray;
      Skill memory s = Skill({
          memaddress: me,
          nameskill: nameskill,
          description: description,
          linkPicture: emptyArray
      });
    //   skills[me].memaddress = me;
    //   skills[me].nameskill = nameskill;
    //   skills[me].description = description;
      skills[me].push(s);
  }
  
  function addRelation(address a, address b, string memory skillName) public {
      Skill[] memory skills_list = skills[a];
      for (uint256 i = 0; i < skills_list.length; i++) {
          Skill memory s = skills_list[i];
          if (keccak256(abi.encodePacked(s.nameskill)) == keccak256(abi.encodePacked(skillName)) ) {
              skillrelation[skillName][a] = b;
          }
      }
    }
    
  function findRelation(string memory skillName) public view returns (address) {
      Skill[] memory skills_list = skills[msg.sender];
      for (uint256 i = 0; i < skills_list.length; i++) {
          Skill memory s = skills_list[i];
          if (keccak256(abi.encodePacked(s.nameskill)) == keccak256(abi.encodePacked(skillName)) ) {
               return skillrelation[skillName][msg.sender] ;
          }
      }
    }
    
  function editLifeskill(string memory skillName,string memory linkPicture ) public  {
      Skill[] memory skills_list = skills[msg.sender];
      for (uint256 i = 0; i < skills_list.length; i++) {
          Skill memory s = skills_list[i];
          if (keccak256(abi.encodePacked(s.nameskill)) == keccak256(abi.encodePacked(skillName)) ) {
               
            //   Editskill memory e = Editskill({
                //   linkPicture: linkPicture
            //   });
              skills[msg.sender][i].linkPicture.push(linkPicture);
          }
      }
    //   Editskill memory e = Editskill({
    //       linkPicture: linkPicture
    //   });
  }
    
//   function findMyskill(string memory nameskill) public view returns (Skill memory){ 
//       Skill[] memory skills_list = skills[msg.sender];
//       for (uint256 i = 0; i < skills_list.length; i++) {
//           Skill memory s = skills_list[i];
//           if (keccak256(abi.encodePacked(s.nameskill)) == keccak256(abi.encodePacked(nameskill)) ) {
//               return s;
//           }
//       }
//       Skill memory s;
//       return s;
//   }
  
//   function findSkillrelation (string memory  ) public view return (){
//       Skill[] memory skills_list = skills[a];
//       for (uint256 i = 0; i < skills_list.length; i++) {
//           Skill memory s = skills_list[i];
//           if (keccak256(abi.encodePacked(s.nameskill)) == keccak256(abi.encodePacked(skillName)) ) {
//               skillrelation[skillName][a] = b;
          
//   }
  
  function findSkill (address iaddress) public view returns (Skill[] memory){
      
      return skills[iaddress];
  }

  function addProfile(string memory Email,string memory Mpass ,string memory Company,string memory Job,string memory Description) public {
      address me = msg.sender;
      Member memory m = Member({
          Email: Email,
          Mpass: Mpass,
          Company: Company,
          Job: Job,
          Description: Description
      });
      members[me] = m; 
  }
  
  function getProfile() public view returns (Member memory) {
    Member memory member = members[msg.sender];
      return member;
  }
}
