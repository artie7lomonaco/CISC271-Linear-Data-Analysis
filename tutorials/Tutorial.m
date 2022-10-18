%1. Create and save a new script (click new script in top left corner)**
%   save with .m extension

%2. walk through IDE (default set-up)*********************************
% files (left)
% editor (middle top)
% command window (middle bottom)
% workspace (right)

%3. Create a variable***************************************************
a = 3; %create a scalar variable called "a" with value 3
%   Run file and see 'a' in workspace
%   f remove colon, variable will display in console

%4. Displaying variables*************************************************
disp(a) %like print function

% 5. Running file from command window**********************************
%  In the comman window type the name of your file and then hit enter
%  NOTE: you can also run by clicking "Run" from the editor strip at the top 

%6. Scalar operations*****************************************************
scalar_operations1 = 5 + 5; %addition
scalar_operations2 = 5 - 5; %subtraction
scalar_operations3 = 5 * 5; %multiplication
scalar_operations4 = 5/5; %division
scalar_operations5 = 5^2; %exponentiation

% 7. Vector creation*****************************************************
row_vector = [1, 2, 3, 4]
column_vector = [1; 2; 3; 4]
disp(row_vector(2)) %1-based indexing --> display the second entry

%8. Vector operations: ****************************************************
%   ADDITION/SUBTRACTION
vector_to_add = [1 1 1 1];
new_vector1 = row_vector + vector_to_add
%Q: what happens if try column_vector + vector_to_add?
new_vector2 = row_vector + 1

%   MULTIPLICATION/DIVISION
vector_to_multiply = [2; 2; 2; 2];
new_vector3 = row_vector*vector_to_multiply
new_vector_4 = row_vector * 2 %multiply each entry by 2

%multiplying each element by a different value
new_vector_5 = row_vector * [1;2;3;4]

%TRANSPOSE
vector_to_multiply_transpose = vector_to_multiply'; %transpose the vector (can also apply to matrices)

%9. Matrices*******************************
three_by_three = [1 2 3; 4 5 6; 7 8 9]
disp(three_by_three(1,3)); %display row 1 column 3 value

%multiply each column by a column vector
matrix_multiple_2 = three_by_three * [2; 3; 2] %try with transpose

%element wise multiplication
element_multiple_three_by_three = three_by_three.*3 %multiply each entry by 3

%element-wise exponentiation
element_exp_three_by_three = three_by_three.^3

%element-wise addition
element_add_three_by_three = three_by_three + 3

%10. if statements
if_var = 1;
if if_var == 1 %DOUBLE EQUAL
    disp('Hello')
elseif if_var == 3
    disp('Hola')
else
    disp('Bye');
end %end if statement

%11. Swicth statements + strings
month = "Feb"; %string
switch month
    case "Jan"
        disp("Happy January")
    case "Feb"
        disp("Happy February");
end %end switch statement

%12: For-loop

for idx = 1:2:10 %%starting value: increase amount (default is 1): end value
    disp(idx)
end %end for loop

list_example = [1 2 3 4];
for list_val = list_example
    disp(list_val)
end%end for loop

%13. while-loop
%example - I want to find the number 4 in my list
found = 0;
num_find = 5;
current_idx = 1;

while found == 0 %Option 1: && current_idx < 5
    if list_example(current_idx) == num_find
        found = 1;
        disp('Found')
    end
    
    current_idx = current_idx + 1;
    
    if current_idx == 5 %if don't include will get error saying indexing out of bounds
        disp('Not found')
        break
    end
    
end

%14. Searching for documentation from MATLAB
%search for function find (top right corner)
idx_found = find(list_example == 3)

% 15. Basic Plotting
x = [1 2 3 4 5 6 7 8 9 10];
y = [1 2 3 4 5 6 7 8 9 10]

%plot x and y
plot(x, y);

%PLOTTING MULTIPLE FRIGURES ON 1 GRAPH
%using linspace
x1 = linspace(1,20,21);
x2 = linspace(1,20,21);
y1 = linspace(1, 40, 21);
y2 = linspace(1, 10, 21);

%option A
figure; %Create a new figure window otherwise your other plot will be overrided
plot(x1,y1, 'r*', x2,y2, 'b*');
%adding labels
xlabel('x-axis')
ylabel('y-axis')
title('Plot #2')
legend();

%option B
figure;
plot(x1,y1, 'r*');
hold on %if do not include hold on only the second plot will be shown
plot(x2, y2, 'b*');
hold off

%16. Funtion definition

%create and use a function that returns 2 variables and requires 2
%arguments
[added_values, temp] = add_two_values(2,3)

%function "return variable" = "function name"(values)
function [addition, temp] = add_two_values(a, b)
addition = a+b; %return paramaters added
temp = 1;
end %end the function




