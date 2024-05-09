
class AppServer{
  static const headers ={
    'Content-Type' : 'application/json',
    "Accept" : 'application/json'
  };
  static const API = "http://localhost:8081";

  //user
  static const USER = "/api/v1/auth";
  static const SAVE_USER = "$API$USER/register";
  static const LOGIN_USER = "$API$USER/authenticate";

  // for Etudiant
  static const ETUDIANT = "/Etudiant";
  static const SAVE_ETUDIANT = "$API$ETUDIANT/register";
  static const LIST_ETUDIANT = "$API$ETUDIANT";
  static const UPDATE_ETUDIANT = "$API$ETUDIANT/update";
  static const GET_ONE_ETUDIANT = "$API$ETUDIANT/";
  static const DELETE_ETUDIANT = "$API$ETUDIANT/delete/";

  // for Enseignant
  static const ENS = "/enseignant";
  static const SAVE_ENS = "$API$ENS/register";
  static const LIST_ENS = "$API$ENS";
  static const UPDATE_ENS = "$API$ENS/update";
  static const GET_ONE_ENS = "$API$ENS/";
  static const DELETE_ENS = "$API$ENS/delete/";

  // for Matiere
  static const MAT = "/Matiere";
  static const SAVE_MAT = "$API$MAT/add/";
  static const LIST_MAT = "$API$MAT/";
  static const UPDATE_MAT = "$API$MAT/";
  static const GET_ONE_MAT = "$API$MAT/";
  static const DELETE_MAT = "$API$MAT/delete/";

  // for questions
  static const QUESTION = "/Question";
  static const SAVE_QUESTION = "$API$QUESTION/add/";
  static const UPDATE_QUESTION = "$API$QUESTION/";
  static const GET_ALL = "$API$QUESTION/";
  static const GET_ONE_QUESTION = "$API$QUESTION/";
  static const DELETE_QUESTION = "$API$QUESTION/delete/";

  // for epreuve
  static const EPREUVE = "/Epreuve";
  static const SAVE_EPREUVE = "$API$EPREUVE/add/";
  static const LIST_EPREUVE = "$API$EPREUVE/";
  static const UPDATE_EPREUVE = "$API$EPREUVE/update";
  static const GET_ONE_EPREUVE = "$API$EPREUVE/";
  static const DELETE_EPREUVE = "$API$EPREUVE/delete/";
  static const GET_QUESTION = "$API$EPREUVE/questions/";
   static const ADD_QUESTION_TO_EPREUVE = "$API$EPREUVE/addQuestionToEpreuve";


  // for evaluation
  static const EVALUATION = "/Evaluation";
  static const SAVE_EVALUATION = "$API$EVALUATION/add/";
  static const LIST_EVALUATION = "$API$EVALUATION/";
  static const UPDATE_EVALUATION = "$API$EVALUATION/update";
  static const GET_ONE_EVALUATION = "$API$EVALUATION/";
  static const DELETE_EVALUATION = "$API$EVALUATION/delete/";

  // //   for user
  // static const USER = "/enseignant";
  // static const LOGIN = API + USER + "/login";
  // static const LOGOUT = API + "/user/logout/";
}