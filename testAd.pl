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
è_un(1,ostacolo_fisso).
id(1,'W').
coordX_attuale(1,1).
coordY_attuale(1,2).
è_un(2,ostacolo_fisso).
id(2,'W').
coordX_attuale(2,2).
coordY_attuale(2,2).
è_un(3,ostacolo_fisso).
id(3,'W').
coordX_attuale(3,3).
coordY_attuale(3,2).
è_un(4,ostacolo_fisso).
id(4,'W').
coordX_attuale(4,4).
coordY_attuale(4,2).
è_un(5,ostacolo_fisso).
id(5,'W').
coordX_attuale(5,5).
coordY_attuale(5,2).
è_un(6,ostacolo_fisso).
id(6,'W').
coordX_attuale(6,6).
coordY_attuale(6,2).
è_un(7,ostacolo_fisso).
id(7,'W').
coordX_attuale(7,1).
coordY_attuale(7,7).
è_un(8,ostacolo_fisso).
id(8,'W').
coordX_attuale(8,2).
coordY_attuale(8,7).
è_un(9,ostacolo_fisso).
id(9,'W').
coordX_attuale(9,2).
coordY_attuale(9,8).
è_un(10,ostacolo_fisso).
id(10,'W').
coordX_attuale(10,2).
coordY_attuale(10,9).




è_un(smith0,agente).
id(smith0,'A').
tipo_ostacolo(smith0,mobile).
coordX_attuale(smith0,3).
coordY_attuale(smith0,6).
direzione(smith0,'E').
numero_passi_in_direz(smith0,4).
numero_passi_x_step(smith0,1).
numero_passi_effettuati(smith0,1).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
è_un(neo,eletto).
id(neo,'N').
coordX_attuale(neo,4).
coordY_attuale(neo,5).
%direzione(neo,Boh).
numero_passi_x_step(neo,1).
numero_passi_effettuati(neo,0).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
id(target,'T').
coord_goal(target,1,8).