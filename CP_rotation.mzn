include "globals.mzn";
include "gecode.mzn";

% instance parameters
int: n_circuits;
set of int: CIRCUITS = 1..n_circuits; 
int: w;
array[CIRCUITS] of int : x_dimension;
array[CIRCUITS] of int : y_dimension;
int: t = sum(c in CIRCUITS)(max(x_dimension[c],y_dimension[c]));

%decision variables
array[CIRCUITS] of var 0..w : x_position;
array[CIRCUITS] of var 0..t: y_position;
array[CIRCUITS] of var 0..1: rotation;
array[CIRCUITS] of var 0..w : dimension_1;
array[CIRCUITS] of var 0..t : dimension_2;



var int: len = max(c in CIRCUITS)(dimension_2[c] + y_position[c]);

%implied constraint
constraint forall(c in CIRCUITS) (if rotation[c] == 0
                                      then dimension_1[c] == x_dimension[c] /\ dimension_2[c] == y_dimension[c]
                                      else dimension_1[c] == y_dimension[c] /\ dimension_2[c] == x_dimension[c] endif);
constraint forall(c in CIRCUITS)(x_position[c] <= w - dimension_1[c] );

constraint forall(c in CIRCUITS)(y_position[c] <= len - dimension_2[c] );

constraint forall(i in CIRCUITS)(
                  forall(j in CIRCUITS where j<i)(
                           x_position[i] != x_position[j] \/ y_position[i] != y_position[j]));


% global constraint

constraint diffn(x_position,
                 y_position,
                 dimension_1,
                 dimension_2);
                 


%functions

function array[int] of var int: symmetry(array[int] of var int: pos,array[int] of var int:dim, int:w) = [w - dim[c]-pos[c]| c in CIRCUITS];

%symmetry breaking constraint
constraint lex_lesseq(x_position,symmetry(x_position,dimension_1,w)) /\ lex_lesseq(y_position,symmetry(y_position,dimension_2,w));

constraint lex_lesseq(x_position,symmetry(x_position,dimension_1,w));
constraint lex_lesseq(y_position,symmetry(y_position,dimension_2,w));

constraint x_position[1] == 0 /\ y_position[1]==0;


%objective

ann : search_ann = seq_search([int_search(x_position,dom_w_deg,indomain_random,complete),
                    int_search(y_position,dom_w_deg,indomain_random,complete),
                    int_search(dimension_1,dom_w_deg,indomain_min,complete),
                    int_search(dimension_2,dom_w_deg,indomain_min,complete),
                    int_search(rotation,dom_w_deg,indomain_min,complete),
                    int_search([len], dom_w_deg,indomain_random,complete)]);

solve:: search_ann
     :: restart_luby(250)
     :: relax_and_reconstruct(x_position, 85)
     minimize len;

output [ "\(w) \(len)\n\(n_circuits)\n"] ++
       [ "\(dimension_1[r]) \(dimension_2[r]) \(x_position[r]) \(y_position[r]) \(rotation[r]) \n" | r in CIRCUITS ];





