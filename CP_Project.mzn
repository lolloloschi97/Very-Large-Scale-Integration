include "globals.mzn";
include "gecode.mzn";

% instance parameters
int: n_circuits;
set of int: CIRCUITS = 1..n_circuits; 
int: w;
array[CIRCUITS] of int : x_dimension;
array[CIRCUITS] of int : y_dimension;
int: t = sum(c in CIRCUITS)(y_dimension[c]);
%decision variables
array[CIRCUITS] of var 0..w : x_position;
array[CIRCUITS] of var 0..t: y_position;

var int: len = max(c in CIRCUITS)(y_dimension[c] + y_position[c]);

% global constraint

constraint diffn(x_position,
                 y_position,
                 x_dimension,
                 y_dimension);
                 
%implied constraint
constraint forall(c in CIRCUITS)(x_position[c] <= w - x_dimension[c] );

constraint forall(c in CIRCUITS)(y_position[c] <= len - y_dimension[c] );

constraint forall(i in CIRCUITS)(
                  forall(j in CIRCUITS where j<i)(
                           x_position[i] != x_position[j] \/ y_position[i] != y_position[j]));
                           
       

%functions

function array[int] of var int: symmetry(array[int] of var int: pos,array[int] of int:dim, int:w) = [w - dim[c]-pos[c]| c in CIRCUITS];

%symmetry breaking constraint
constraint lex_lesseq(x_position,symmetry(x_position,x_dimension,w)) /\ lex_lesseq(y_position,symmetry(y_position,y_dimension,w));

constraint lex_lesseq(x_position,symmetry(x_position,x_dimension,w));
constraint lex_lesseq(y_position,symmetry(y_position,y_dimension,w));
constraint x_position[1] == 0 /\ y_position[1]==0;


%objective

ann : search_ann = seq_search([int_search(x_position,dom_w_deg,indomain_random,complete),
                    int_search(y_position,dom_w_deg,indomain_random,complete),
                    int_search([len], dom_w_deg,indomain_random,complete)]);

solve:: search_ann
     :: restart_luby(250)
     :: relax_and_reconstruct(x_position, 85)
     minimize len;

output [ "\(w) \(len)\n\(n_circuits)\n"] ++
       [ "\(x_dimension[r]) \(y_dimension[r]) \(x_position[r]) \(y_position[r])\n" | r in CIRCUITS ];





