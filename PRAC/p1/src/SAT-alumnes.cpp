#include <iostream>
#include <stdlib.h>
#include <algorithm>
#include <vector>
#include <list>
using namespace std;

#define UNDEF -1
#define TRUE 1
#define FALSE 0

#define DEBUG 0
#define N 50000

uint numVars;
uint numClauses;
vector<vector<int> > clauses;
vector<int> model;
vector<int> modelStack;
vector<list<int> > volPos;
vector<list<int> > volNeg;
vector<int> dynCC; //dynamic conflict counter
uint conflictCounter;
uint indexOfNextLitToPropagate;
uint decisionLevel;


void insertVOL(int lit, int clause, bool pos) 
{
    if (pos) volPos[lit].insert(volPos[lit].end(), clause);
    else volNeg[lit].insert(volNeg[lit].end(), clause);
}

void readClauses( ){
  // Skip comments
  char c = cin.get();
  while (c == 'c') {
    while (c != '\n') c = cin.get();
    c = cin.get();
  }  
  // Read "cnf numVars numClauses"
  string aux;
  cin >> aux >> numVars >> numClauses;
  clauses.resize(numClauses);  
  volPos.resize(numVars+1);
  volNeg.resize(numVars+1);
  dynCC.resize(numVars+1,0); 
  // Read clauses
  for (uint i = 0; i < numClauses; ++i) {
    int lit;
    while (cin >> lit and lit != 0) {
        if (lit > 0) insertVOL(lit, i, true);
        else insertVOL(-lit,i,false);
        clauses[i].push_back(lit);
    }
  }    

  // Print occur lists
  #if DEBUG
  int position = 0;
  for (const auto& lst : volPos) {
    cout << "Position " << position++ << ": ";
    for (int lit : lst) {
        cout << lit << ' ';
    }
    cout << endl;
  }
  
  position = 0;
  for (const auto& lst : volNeg) {
    cout << "Position " << position++ << ": ";
    for (int lit : lst) {
        cout << lit << ' ';
    }
    cout << endl;
  }
  #endif
}



int currentValueInModel(int lit){
  if (lit >= 0) return model[lit];
  else {
    if (model[-lit] == UNDEF) return UNDEF;
    else return 1 - model[-lit];
  }
}


void setLiteralToTrue(int lit){
  #if DEBUG
  cout << "Setting lit = " << lit << " to true..." << endl;
  #endif
  modelStack.push_back(lit);
  if (lit > 0) model[lit] = TRUE;
  else model[-lit] = FALSE;		
}

void treatDynConflict(int numClause) {
    //augmentem el comptador de conflictes del vector 
    //dynCC en les posicions de les variables del conflicte
    //i dividim entre dos tots els comptadors en cas de que 
    //conflictCounter > N
    #if DEBUG
    cout << "Treating dynamic conflict" << endl;
    #endif
    ++conflictCounter;
    for (int j = 0; j < clauses[numClause].size(); ++j) 
        ++dynCC[abs(clauses[numClause][j])];
    if (conflictCounter > N) {
        conflictCounter = 0;
        for (int i = 0; i < dynCC.size(); ++i) 
            dynCC[i] = dynCC[i] / 2;
    }
    #if DEBUG
    cout << "Dynamic conflict treated" << endl;
    #endif
}


bool propagateGivesConflict ( ) {
  while ( indexOfNextLitToPropagate < modelStack.size() ) {
    int lit = modelStack[indexOfNextLitToPropagate++];
    #if DEBUG
    cout << "Propagating..." << "VARIABLE = " << lit << endl;
    #endif
    list<int>::iterator it;
    list<int>::iterator it_end;
    if (lit < 0) {
        it=volPos[-lit].begin();
        it_end=volPos[-lit].end();
        #if DEBUG
        cout << "Negative lit, size of volPos: " << volPos[-lit].size() << endl;
        #endif
    } else if (lit > 0) {
        it = volNeg[lit].begin();
        it_end = volNeg[lit].end();
        #if DEBUG
        cout << "Positive lit, size of volNeg: " << volNeg[lit].size() << endl;
        #endif
    }
    #if DEBUG
    cout << "Iterators set!"<< endl;
    #endif
    for (; it != it_end ; ++it) {

        #if DEBUG
        cout << "Iterating..." << "value IT = " << *it << endl;
        #endif
        bool someLitTrue = false;
        int numUndefs = 0;
        int lastLitUndef = 0;
        for (uint k = 0; not someLitTrue and k < clauses[*it].size(); ++k){
            int val = currentValueInModel(clauses[*it][k]);
            if (val == TRUE) someLitTrue = true;
            else if (val == UNDEF){ ++numUndefs; lastLitUndef = clauses[*it][k]; }
        }
        if (not someLitTrue and numUndefs == 0) {
            #if DEBUG
            cout << "CONFLICT!" << endl; 
            #endif
            treatDynConflict(*it);
            return true;
        } // conflict! all lits false
        else if (not someLitTrue and numUndefs == 1) {
            #if DEBUG
            cout << "SETTO!" << endl; 
            #endif
            setLiteralToTrue(lastLitUndef);
        }
    }
  }
    #if DEBUG
    cout << "Returning false..." << endl;
    #endif
  return false;
}


void backtrack(){
  #if DEBUG
  cout << "Backtracking... " << endl; 
  #endif
  uint i = modelStack.size() -1;
  int lit = 0;
  while (modelStack[i] != 0){ // 0 is the DL mark
    lit = modelStack[i];
    model[abs(lit)] = UNDEF;
    modelStack.pop_back();
    --i;
  }
  // at this point, lit is the last decision
  modelStack.pop_back(); // remove the DL mark
  --decisionLevel;
  indexOfNextLitToPropagate = modelStack.size();
  setLiteralToTrue(-lit);  // reverse last decision
}


// Heuristic for finding the next decision literal:
int getNextDecisionLiteral(){
  #if DEBUG
  cout << "Deciding next literal... " ; 
  #endif
  int nextDecision;
  int max = -1;
  bool allDefined = true;
  for (uint i = 1; i <= numVars; ++i){ //not so stupid heuristic:
      if (dynCC[i] > max and model[i] == UNDEF) {
          allDefined = false;
          max = dynCC[i];
          nextDecision = i;
      }
  }
  if (allDefined) return 0; // returns 0 when all literals are defined
  #if DEBUG
  cout << "It's " << nextDecision << '!' << endl;
  #endif
  return nextDecision;
}

void checkmodel(){
  for (uint i = 0; i < numClauses; ++i){
    bool someTrue = false;
    for (uint j = 0; not someTrue and j < clauses[i].size(); ++j)
      someTrue = (currentValueInModel(clauses[i][j]) == TRUE);
    if (not someTrue) {
      cout << "Error in model, clause is not satisfied:";
      for (uint j = 0; j < clauses[i].size(); ++j) cout << clauses[i][j] << " ";
      cout << endl;
      exit(1);
    }
  }  
}

int main(){ 
  readClauses(); // reads numVars, numClauses and clauses
  model.resize(numVars+1,UNDEF);
  indexOfNextLitToPropagate = 0;  
  decisionLevel = 0;
  
  // Take care of initial unit clauses, if any
  for (uint i = 0; i < numClauses; ++i)
    if (clauses[i].size() == 1) {
      int lit = clauses[i][0];
      int val = currentValueInModel(lit);
      if (val == FALSE) {cout << "UNSATISFIABLE" << endl; return 10;}
      else if (val == UNDEF) setLiteralToTrue(lit);
    }
  
  // DPLL algorithm
  while (true) {
    while ( propagateGivesConflict() ) {
      if ( decisionLevel == 0) { cout << "UNSATISFIABLE" << endl; return 10; }
      backtrack();
    }
    int decisionLit = getNextDecisionLiteral();
    if (decisionLit == 0) { checkmodel(); cout << "SATISFIABLE" << endl; return 20; }
    // start new decision level:
    modelStack.push_back(0);  // push mark indicating new DL
    ++indexOfNextLitToPropagate;
    ++decisionLevel;
    setLiteralToTrue(decisionLit);    // now push decisionLit on top of the mark
  }
}  
