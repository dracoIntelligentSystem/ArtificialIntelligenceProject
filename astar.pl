pathfind(Phase,Neo,Target,Path):-
	prendi_coord_attuali(Neo,StartX, StartY),
	coord_goal(Target,GoalX,GoalY),
	heuristicFunction(StartX, StartY, GoalX, GoalY, H_Score),
	astar(Phase,[StartX, StartY],[GoalX, GoalY],[[[StartX, StartY],0,H_Score,0+H_Score,[StartX, StartY]]],[],[[StartX, StartY]],Path).

alternativePath([StartX, StartY],Target,Path,LenghtPath):-
	coord_goal(Target,GoalX,GoalY),
	heuristicFunction(StartX, StartY, GoalX, GoalY, H_Score),
	astar([StartX, StartY],[GoalX, GoalY],[[[StartX, StartY],0,H_Score,0+H_Score,[StartX, StartY]]],[],[[StartX, StartY]],Path),
	length(Path, LenghtPath).
	

compare_F_Score(X,[_,_,_,F_score1,_],[_,_,_,F_score2,_]):-F_score1==F_score2;compare(X,F_score1,F_score2).


astar(_,_,_,[], _, _, _):-!,writeln('Eh mò? Beh NON è risolvibile lo scenario').
astar(_,_,[GoalX, GoalY],[[[GoalX, GoalY],_G_score,_H_score,_F_score,[XBef,YBef]]|_OpenSet], CloseSet, _, Path):-!,
	reconstruct_path([GoalX, GoalY],CloseSet,[XBef,YBef],[],Path).
	
astar(Phase,[_StartX, _StartY],[GoalX, GoalY],[[[X,Y],G_score,_Hscore,_Fscore,[PrevX, PrevY]]|OpenSet],CloseSet,_,Path):-
	append([[[X,Y],G_score,_H_score,_F_score,[PrevX, PrevY]]],CloseSet,UpdCloseSet),
		(
			Phase==normalPhase,
			allowCellsAstar(X, Y, [], Neighbours);
			Phase==emergencyPhase,
			findAgentsCell(X,Y,NotAllow2go),
			allowCellsAstar(X, Y, NotAllow2go, Neighbours)
		),
	viewNeighbours([X,Y],Neighbours,G_score,UpdCloseSet,OpenSet,UpdOpenSet),!,
	astar(Phase,[X,Y],[GoalX, GoalY],	UpdOpenSet,UpdCloseSet, _, Path).

viewNeighbours(_,[],_,_,OpenSet,OpenSetRanked):-!,
	predsort(compare_F_Score,OpenSet,OpenSetRanked).%%RANKIZZA TUTTO SU F_SCORE

viewNeighbours([X0,Y0],[[X,Y]|OtherNeighbours],G_score_X0_Y0,ClosedSet,OpenSet,FinalOpenSet):-
	member([[X,Y],_,_,_,_], ClosedSet),
	viewNeighbours([X0,Y0],OtherNeighbours,G_score_X0_Y0,ClosedSet,OpenSet,FinalOpenSet);
	New_G_Score is G_score_X0_Y0 + 1,
	not(member([[X,Y],_,_,_,_], OpenSet)),
	coord_goal(target, X_Goal, Y_Goal),
	heuristicFunction(X, Y, X_Goal,Y_Goal, New_H_Score),
	New_F_Score is New_G_Score + New_H_Score,
	UpdOpenSet = [[[X,Y],New_G_Score, New_H_Score, New_F_Score,[X0,Y0]]|OpenSet],!,
	viewNeighbours([X0,Y0],OtherNeighbours,G_score_X0_Y0,ClosedSet,UpdOpenSet,FinalOpenSet).
	
viewNeighbours([X0,Y0],[[X,Y]|OtherNeighbours],G_score_X0_Y0,ClosedSet,OpenSet,FinalOpenSet):-
	not(member([[X,Y],_,_,_,_], ClosedSet)), %NON ELEMENTO DEL CLOSEDSET
	member([[X,Y],_,_,_], OpenSet),%ELEMENTO GIA' PRESENTE NELL'OPENSET
	New_G_Score is G_score_X0_Y0 + 1,
	member([[X,Y],Old_G_Score,Old_H_Score,Old_F_Score,[X0,Y0]], OpenSet),
	New_G_Score<Old_G_Score,
	coord_goal(target, X_Goal, Y_Goal),
	heuristicFunction(X, Y, X_Goal,Y_Goal, New_H_Score),
	New_F_Score is New_G_Score + New_H_Score,
	selectchk([[X,Y],Old_G_Score,Old_H_Score,Old_F_Score],OpenSet,RestOpenSet),
	UpdOpenSet = [[[X,Y],New_G_Score, New_H_Score, New_F_Score,[X0,Y0]]|RestOpenSet],!,
	viewNeighbours([X0,Y0],OtherNeighbours,G_score_X0_Y0,ClosedSet,UpdOpenSet,FinalOpenSet);
	viewNeighbours([X0,Y0],OtherNeighbours,G_score_X0_Y0,ClosedSet,OpenSet,FinalOpenSet).
	
reconstruct_path([GoalX, GoalY],ClosedSet,[X,Y],PartialsPath,Path):-
	member([[X,Y],_,_,_,[X,Y]], ClosedSet),!,
	append(PartialsPath,[[GoalX, GoalY]], Path).
reconstruct_path([GoalX, GoalY],ClosedSet,[X,Y],PartialsPath,Path):-
	member([[X,Y],_,_,_,[XBef,YBef]], ClosedSet),
	append([[X,Y]], PartialsPath, UpdPath),!,
	reconstruct_path([GoalX, GoalY],ClosedSet,[XBef,YBef],UpdPath,Path).
	