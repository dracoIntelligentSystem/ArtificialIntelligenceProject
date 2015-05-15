%%%%%%%%SCENARIO 27%%%%%%%%%%%%
:-dynamic direzione/2.
:-dynamic coordX_attuale/2.
:-dynamic coordY_attuale/2.
:-dynamic numero_passi_effettuati/2.
:-dynamic coord_goal/3.
:-dynamic è_un/2.
:-dynamic numero_passi_in_direz/2.
:-dynamic numero_passi_x_step/2.
:-dynamic id/2.
%%%%%%%%%%%%%%%%%TEST%%%%%%%%%%
:-dynamic deny/3.
deny(_,_,'').
%%%%%%%%%%%%%%%%%%%%OSTACOLI MOBILI%%%%%%%%%%%%%%%%%%%%%%%%
è_un(smith0,agente).
id(smith0,'A').
tipo_ostacolo(smith0,mobile).
coordX_attuale(smith0,4).
coordY_attuale(smith0,2).
direzione(smith0,'E').
numero_passi_in_direz(smith0,6).
numero_passi_x_step(smith0,1).
numero_passi_effettuati(smith0,1).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
è_un(smith1,agente).
id(smith1,'B').
tipo_ostacolo(smith1,mobile).
coordX_attuale(smith1,2).
coordY_attuale(smith1,8).
direzione(smith1,'SO').
numero_passi_in_direz(smith1,6).
numero_passi_x_step(smith1,1).
numero_passi_effettuati(smith1,1).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
è_un(smith2,agente).
id(smith2,'C').
tipo_ostacolo(smith2,mobile).
coordX_attuale(smith2,1).
coordY_attuale(smith2,1).
direzione(smith2,'E').
numero_passi_in_direz(smith2,4).
numero_passi_x_step(smith2,1).
numero_passi_effettuati(smith2,1).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
è_un(smith3,agente).
id(smith3,'D').
tipo_ostacolo(smith3,mobile).
coordX_attuale(smith3,1).
coordY_attuale(smith3,6).
direzione(smith3,'O').
numero_passi_in_direz(smith3,4).
numero_passi_x_step(smith3,1).
numero_passi_effettuati(smith3,1).
%è_un(8,ostacolo_fisso).
%id(8,'W').
%oordX_attuale(8,1).
%coordY_attuale(8,3).

%%%%%%%%%%%%%%%%%%%OSTACOLI FISSI%%%%%%%%%%%%%%%%%%%%%%%%%
è_un(1,ostacolo_fisso).
id(1,'W').
coordX_attuale(1,3).
coordY_attuale(1,3).
è_un(2,ostacolo_fisso).
id(2,'W').
coordX_attuale(2,3).
coordY_attuale(2,4).
è_un(3,ostacolo_fisso).
id(3,'W').
coordX_attuale(3,4).
coordY_attuale(3,8).
%QUI SI IMPALLA PERCHè NON TROVANDO UN CORRIDOIO LIBERO SUBITO 
%NON AGGIRA L'OSTACOLO MA RICADE NELLE STESSE MOSSE
è_un(4,ostacolo_fisso).
id(4,'W').
coordX_attuale(4,8).
coordY_attuale(4,7).

è_un(5,ostacolo_fisso).
id(5,'W').
coordX_attuale(5,8).
coordY_attuale(5,8).

è_un(neo,eletto).
id(neo,'N').
coordX_attuale(neo,2).
coordY_attuale(neo,3).
%direzione(neo,Boh).
numero_passi_x_step(neo,1).
numero_passi_effettuati(neo,0).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
id(target,'T').
coord_goal(target,9,8).
/*
%%%%%%%%SCENARIO 27%%%%%%%%%%%%
:-dynamic direzione/2.
:-dynamic coordX_attuale/2.
:-dynamic coordY_attuale/2.
:-dynamic numero_passi_effettuati/2.
:-dynamic coord_goal/3.
%%%%%%%%%%%%%%%%%TEST%%%%%%%%%%
:-dynamic deny/3.
deny(_,_,'').
%%%%%%%%%%%%%%%%%%%%OSTACOLI MOBILI%%%%%%%%%%%%%%%%%%%%%%%%
è_un(smith0,agente).
id(smith0,'A').
tipo_ostacolo(smith0,mobile).
coordX_attuale(smith0,4).
coordY_attuale(smith0,2).
direzione(smith0,'E').
numero_passi_in_direz(smith0,6).
numero_passi_x_step(smith0,1).
numero_passi_effettuati(smith0,1).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
è_un(smith1,agente).
id(smith1,'B').
tipo_ostacolo(smith1,mobile).
coordX_attuale(smith1,2).
coordY_attuale(smith1,8).
direzione(smith1,'SO').
numero_passi_in_direz(smith1,6).
numero_passi_x_step(smith1,1).
numero_passi_effettuati(smith1,1).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
è_un(smith2,agente).
id(smith2,'C').
tipo_ostacolo(smith2,mobile).
coordX_attuale(smith2,9).
coordY_attuale(smith2,4).
direzione(smith2,'NE').
numero_passi_in_direz(smith2,5).
numero_passi_x_step(smith2,1).
numero_passi_effettuati(smith2,1).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
è_un(smith3,agente).
id(smith3,'D').
tipo_ostacolo(smith3,mobile).
coordX_attuale(smith3,10).
coordY_attuale(smith3,6).
direzione(smith3,'N').
numero_passi_in_direz(smith3,5).
numero_passi_x_step(smith3,1).
numero_passi_effettuati(smith3,1).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%OSTACOLI FISSI%%%%%%%%%%%%%%%%%%%%%%%%%
è_un(1,ostacolo_fisso).
id(1,'W').
coordX_attuale(1,3).
coordY_attuale(1,3).
è_un(2,ostacolo_fisso).
id(2,'W').
coordX_attuale(2,3).
coordY_attuale(2,4).
è_un(3,ostacolo_fisso).
id(3,'W').
coordX_attuale(3,4).
coordY_attuale(3,8).
%QUI SI IMPALLA PERCHè NON TROVANDO UN CORRIDOIO LIBERO SUBITO 
%NON AGGIRA L'OSTACOLO MA RICADE NELLE STESSE MOSSE
è_un(4,ostacolo_fisso).
id(4,'W').
coordX_attuale(4,8).
coordY_attuale(4,7).

è_un(5,ostacolo_fisso).
id(5,'W').
coordX_attuale(5,8).
coordY_attuale(5,8).

è_un(neo,eletto).
id(neo,'N').
coordX_attuale(neo,2).
coordY_attuale(neo,3).
%direzione(neo,Boh).
numero_passi_x_step(neo,1).
numero_passi_effettuati(neo,0).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
id(target,'T').
coord_goal(target,9,8).
*/

/*:-dynamic direzione/2.
:-dynamic coordX_attuale/2.
:-dynamic coordY_attuale/2.
:-dynamic numero_passi_effettuati/2.
:-dynamic coord_goal/3.
%%%%%%%%%%%%%%%%%TEST%%%%%%%%%%
:-dynamic deny/3.
deny(_,_,'').
%%%%%%%%%%%%%%%%%%%%OSTACOLI MOBILI%%%%%%%%%%%%%%%%%%%%%%%%
è_un(smith0,agente).
id(smith0,'A').
tipo_ostacolo(smith0,mobile).
coordX_attuale(smith0,7).
coordY_attuale(smith0,1).
direzione(smith0,'SE').
numero_passi_in_direz(smith0,4).
numero_passi_x_step(smith0,1).
numero_passi_effettuati(smith0,1).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
è_un(smith1,agente).
id(smith1,'B').
tipo_ostacolo(smith1,mobile).
coordX_attuale(smith1,6).
coordY_attuale(smith1,1).
direzione(smith1,'SE').
numero_passi_in_direz(smith1,5).
numero_passi_x_step(smith1,1).
numero_passi_effettuati(smith1,1).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
è_un(smith2,agente).
id(smith2,'C').
tipo_ostacolo(smith2,mobile).
coordX_attuale(smith2,9).
coordY_attuale(smith2,1).
direzione(smith2,'NE').
numero_passi_in_direz(smith2,5).
numero_passi_x_step(smith2,1).
numero_passi_effettuati(smith2,1).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
è_un(smith3,agente).
id(smith3,'D').
tipo_ostacolo(smith3,mobile).
coordX_attuale(smith3,1).
coordY_attuale(smith3,7).
direzione(smith3,'S').
numero_passi_in_direz(smith3,3).
numero_passi_x_step(smith3,1).
numero_passi_effettuati(smith3,1).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
è_un(smith4,agente).
id(smith4,'E').
tipo_ostacolo(smith4,mobile).
coordX_attuale(smith4,3).
coordY_attuale(smith4,8).
direzione(smith4,'O').
numero_passi_in_direz(smith4,5).
numero_passi_x_step(smith4,1).
numero_passi_effettuati(smith4,1).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%OSTACOLI FISSI%%%%%%%%%%%%%%%%%%%%%%%%%.
è_un(smith5,ostacolo_fisso).
id(smith5,'W').
coordX_attuale(smith5,3).
coordY_attuale(smith5,9).

è_un(smith6,ostacolo_fisso).
id(smith6,'W').
coordX_attuale(smith6,4).
coordY_attuale(smith6,6).

è_un(smith7,ostacolo_fisso).
id(smith7,'W').
coordX_attuale(smith7,5).
coordY_attuale(smith7,2).

è_un(smith8,ostacolo_fisso).
id(smith8,'W').
coordX_attuale(smith8,5).
coordY_attuale(smith8,3).

è_un(smith9,ostacolo_fisso).
id(smith9,'W').
coordX_attuale(smith9,5).
coordY_attuale(smith9,7).

è_un(smith10,ostacolo_fisso).
id(smith10,'W').
coordX_attuale(smith10,7).
coordY_attuale(smith10,5).

è_un(smith11,ostacolo_fisso).
id(smith11,'W').
coordX_attuale(smith11,7).
coordY_attuale(smith11,6).

è_un(smith12,ostacolo_fisso).
id(smith12,'W').
coordX_attuale(smith12,8).
coordY_attuale(smith12,6).

è_un(smith13,ostacolo_fisso).
id(smith13,'W').
coordX_attuale(smith13,9).
coordY_attuale(smith13,6).

è_un(smith14,ostacolo_fisso).
id(smith14,'W').
coordX_attuale(smith14,4).
coordY_attuale(smith14,1).

è_un(smith15,ostacolo_fisso).
id(smith15,'W').
coordX_attuale(smith15,4).
coordY_attuale(smith15,2).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

è_un(neo,eletto).
id(neo,'N').
coordX_attuale(neo,10).
coordY_attuale(neo,2).
%direzione(neo,Boh).
numero_passi_x_step(neo,1).
numero_passi_effettuati(neo,0).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
id(target,'T').
coord_goal(target,1,9).
*/