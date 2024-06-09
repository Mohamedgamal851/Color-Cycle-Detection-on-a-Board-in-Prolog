# Color-Cycle-Detection-on-a-Board-in-Prolog
Detect cycles of the same color (Red, Yellow, or Blue) in an N x M board using uninformed search. A cycle is a sequence of at least four adjacent cells forming a closed loop. Implement the search to find and print any such cycle or indicate if none exist. Include board input, state representation, moves, and output.


### In this question, you are required to implement a prolog code that uses uninformed search(breadth or depth first) to solve the following puzzle or indicate that there is no solution.

- You will be given a board that consists of N x M cells.
- Each cell contains a color (Red, Yellow or Blue).
- Your task is to find color cycles for any of the three colors
- For example, as shown in the picture, cells 2,1 -> 2,2 -> 3,2 -> 3,1 form a blue cycle
- Another cycle could be cells 2,0 -> 2,1 -> 3,1 -> 3,0
- Note that yellow and red colors do not form cycles in this example.
- Your code should print at least one of these cycles including its color (if any) or no cycles
exist
- Cycle defined by the following cells c1, c2, ..., ck must have the following:
- These cells are different (no duplicates)
- At least 4 cells (or more)
- All cells have the same color
- The cells are adjacent to each other

## Your main tasks are:
- Design input
- Design state representation
- Design moves
- Design output
