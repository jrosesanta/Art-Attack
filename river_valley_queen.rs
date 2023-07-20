// First we need to include the necessary libraries for our project
extern crate rand;

use rand::Rng;

// Global constants for the board size and number of colours
const BOARD_SIZE: usize = 5;
const NUM_COLOURS: usize = 8;

// Represents a point on the board
struct Point {
    x: i32,
    y: i32,
}

// Represents a colour on the board
enum Colour {
    Red,
    Orange,
    Yellow,
    Green,
    Blue,
    Indigo,
    Violet,
    White,
}

// Represents a block on the board
struct Block {
    position: Point,
    colour: Colour,
}

// Represents the board for Art Attack
struct Board {
    blocks: Vec<Vec<Block>>,
}

// A method for adding a block to the board
impl Board {
    fn add_block(&mut self, x: i32, y: i32, colour: Colour) {
        let block = Block {
            position: Point { x, y },
            colour,
        };
        self.blocks[x as usize][y as usize] = block;
    }
}

// A method to generate a new board
fn generate_new_board() -> Board {
    // Create a new board
    let mut board = Board {
        blocks: Vec::new(),
    };

    // Generate a random colour for each block
    for x in 0..BOARD_SIZE {
        board.blocks.push(Vec::new());

        for y in 0..BOARD_SIZE {
            let random_colour = rand::thread_rng().gen_range(0, NUM_COLOURS);
            let colour_enum = match random_colour {
                0 => Colour::Red,
                1 => Colour::Orange,
                2 => Colour::Yellow,
                3 => Colour::Green,
                4 => Colour::Blue,
                5 => Colour::Indigo,
                6 => Colour::Violet,
                7 => Colour::White,
                _ => panic!("Invalid colour"),
            };
            board.add_block(x as i32, y as i32, colour_enum);
        }
    }

    return board;
}

// A method to check if the board is cleared
fn is_board_cleared(board: &Board) -> bool {
    let mut cleared = true;

    for row in board.blocks.iter() {
        for block in row.iter() {
            if block.colour != Colour::White {
                cleared = false;
            }
        }
    }

    cleared
}

// A method to check if a block can be cleared
fn can_clear_block(board: &Board, x: i32, y: i32) -> bool {
    let mut up = 0;
    let mut right = 0;
    let mut down = 0;
    let mut left = 0;
    let this_colour = board.blocks[x as usize][y as usize].colour;

    // Up
    if y > 0 {
        if board.blocks[x as usize][y as usize - 1].colour == this_colour {
            up += 1;
        }
    }

    // Right
    if x < BOARD_SIZE as i32 - 1 {
        if board.blocks[x as usize + 1][y as usize].colour == this_colour {
            right += 1;
        }
    }

    // Down
    if y < BOARD_SIZE as i32 - 1 {
        if board.blocks[x as usize][y as usize + 1].colour == this_colour {
            down += 1;
        }
    }

    // Left
    if x > 0 {
        if board.blocks[x as usize - 1][y as usize].colour == this_colour {
            left += 1;
        }
    }

    (up + right + down + left) >= 2
}

// A method to clear a block from the board
fn clear_block(board: &mut Board, x: i32, y: i32) {
    board.add_block(x, y, Colour::White);
    if x > 0 {
        if can_clear_block(board, x - 1, y) {
            clear_block(board, x - 1, y);
        }
    }
    if x < BOARD_SIZE as i32 - 1 {
        if can_clear_block(board, x + 1, y) {
            clear_block(board, x + 1, y);
        }
    }
    if y > 0 {
        if can_clear_block(board, x, y - 1) {
            clear_block(board, x, y - 1);
        }
    }
    if y < BOARD_SIZE as i32 - 1 {
        if can_clear_block(board, x, y + 1) {
            clear_block(board, x, y + 1);
        }
    }
}

// A method to play the game
fn play_art_attack() {
    // Generate a new board
    let mut board = generate_new_board();

    // Check if the board is cleared
    while !is_board_cleared(&board) {
        // Get input from the user
        println!("Enter the x coordinate of the block to remove: ");
        let mut x = String::new();
        std::io::stdin().read_line(&mut x).expect("Failed to read input!");
        let x: i32 = x.trim().parse().expect("Invalid input!");

        println!("Enter the y coordinate of the block to remove: ");
        let mut y = String::new();
        std::io::stdin().read_line(&mut y).expect("Failed to read input!");
        let y: i32 = y.trim().parse().expect("Invalid input!");

        // Clear the block from the board
        clear_block(&mut board, x, y);
    }

    println!("You won the game!");
}

// The main function which starts the game
fn main() {
    println!("Welcome to Art Attack!");
    play_art_attack();
}