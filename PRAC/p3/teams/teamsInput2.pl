
numWorkers(20).
numTeams(5).    % exact number of teams needed
minSize(3).     % min size of any team
maxSize(6).     % max size of any team
maxScore(14).   % two workers whose scores sum more than 14 cannot go together

% score(workerId, score)
score( 1, 1).
score( 2, 1).
score( 3, 1).
score( 4, 1).
score( 5, 1).
score( 6, 1).
score( 7, 1).
score( 8, 1).
score( 9, 1).
score(10, 1).
score(11, 10).
score(12, 1).
score(13, 1).
score(14, 1).
score(15, 10).
score(16, 10).
score(17, 10).
score(18, 10).
score(19, 1).
score(20, 1).

