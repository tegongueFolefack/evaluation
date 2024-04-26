
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
  static const LIST_ETUDIANT = "$API$ETUDIANT/";
  static const UPDATE_ETUDIANT = "$API$ETUDIANT/update";
  static const GET_ONE_ETUDIANT = "$API$ETUDIANT/";
  static const DELETE_ETUDIANT = "$API$ETUDIANT/delete/";

  // for Enseignant
  static const ENS = "/enseignant";
  static const SAVE_ENS = "$API$ENS/register";
  static const LIST_ENS = "$API$ENS/getAll";
  static const UPDATE_ENS = "$API$ENS/";
  static const GET_ONE_ENS = "$API$ENS/getOne/";
  static const DELETE_ENS = "$API$ENS/delete/";

  // for Matiere
  static const MAT = "/matiere";
  static const SAVE_MAT = "$API$MAT/save";
  static const LIST_MAT = "$API$MAT/getAll";
  static const UPDATE_MAT = "$API$MAT/";
  static const GET_ONE_MAT = "$API$MAT/getOne/";
  static const GET_ONE_MAT_BY_ENS = "$API$MAT/getByEns/";
  static const GET_ONE_MAT_BY_SALLE = "$API$MAT/getBySalle/";
  static const DELETE_MAT = "$API$MAT/delete/";

  // for Presence
  static const PRESENCE = "/presence";
  static const SAVE_PRESENCE = "$API$PRESENCE/save";
  static const GET_ALL_BY_ETUDIANT_PRESENCE = "$API$PRESENCE/etudiant/";
  static const GET_ALL_BY_MATIERE = "$API$PRESENCE/matiere/";
  static const UPDATE_PRESENCE = "$API$PRESENCE/";
  static const GET_ALL_BY_DATE_PRESENCE = "$API$PRESENCE/getAll/";
  static const DELETE_PRESENCE = "$API$PRESENCE/delete/";

  // for Salle
  static const SALLE = "/salle";
  static const SAVE_SALLE = "$API$SALLE/save";
  static const LIST_SALLE = "$API$SALLE/getAll";
  static const UPDATE_SALLE = "$API$SALLE/";
  static const GET_ONE_SALLE = "$API$SALLE/getOne/";
  static const GET_ONE_SALLE_BY_ENS = "$API$SALLE/byEns/";
  static const DELETE_SALLE = "$API$SALLE/delete/";

  // //   for user
  // static const USER = "/enseignant";
  // static const LOGIN = API + USER + "/login";
  // static const LOGOUT = API + "/user/logout/";
}