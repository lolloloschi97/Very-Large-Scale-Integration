### CP_Project.mzn, CP_rotation.mzn

Given an initial i-ins.txt, it's sufficient to run the models over a i-ins.dzn file encoded as follows:

w = i-ins.txt first row's value ;
n_circuits = i-ins.txt second row's value;
x_dimension = [x1,... xn_circuits] i-ins.txt first value in rows from the third onwards ;
y_dimension = [y1,... yn_circuits] i-ins.txt second value in rows from the third onwards ;


### SMT_project.ipynb, project_rotation.ipynb
 
Given an initial i-ins.txt, it's sufficient to:
- upload it with ???
- run the functions: display_solution, lex_less, lim_length, problem
- obtain the output solution executing -->  display_solution(problem(w,circuits),w,n_circuits)
