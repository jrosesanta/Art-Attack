# import libraries
import sys
import os
import time
import random

# GLOBAL CONSTANTS
BACKGROUND_COLOUR = (255, 255, 255)
TEXT_COLOUR = (0, 0, 0)

# game variables 
grid_size = 8
no_of_blocks = 48
bombs = 12

# CLASSES
class Player:
    def __init__(self, name, score):
        self.name = name
        self.score = score

# FUNCTIONS
def draw_background():
    '''Draws the game background with the starting grid size.'''
    background = pygame.Surface(screen.get_size())
    background = background.convert()
    background.fill(BACKGROUND_COLOUR)

    # draw the grid
    block_width = SCREEN_WIDTH / grid_size
    block_height = SCREEN_HEIGHT / grid_size

    for x in range(grid_size):
        for y in range(grid_size):
            rect = pygame.Rect(x * block_width, y * block_height,
                               block_width, block_height)
            pygame.draw.rect(background, TEXT_COLOUR, rect, 1)

    screen.blit(background, (0, 0))
    pygame.display.flip()

# MAIN
def main():
    pygame.init()
    global SCREEN_WIDTH, SCREEN_HEIGHT
    SCREEN_WIDTH, SCREEN_HEIGHT = 800, 600
    global screen
    screen = pygame.display.set_mode((SCREEN_WIDTH, SCREEN_HEIGHT))
    pygame.display.set_caption('Art Attack')
    font_file = './resources/fonts/OratorStd.otf'
    font = pygame.font.Font(font_file, 20)
    pygame.display.set_caption('Art Attack')
    
    # display title screen
    running = True
    draw_background()
    pygame.display.flip()
    while running:
        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                running = False

        screen.fill(BACKGROUND_COLOUR)
        title = font.render('Art Attack', True, TEXT_COLOUR)
        start_button = font.render('Start', True, TEXT_COLOUR)

        # blit the title and image to the screen
        start_rect = pygame.draw.rect(screen, TEXT_COLOUR, (SCREEN_WIDTH/2 - 50, SCREEN_HEIGHT/2 - 50, 100, 50))
        screen.blit(title, (SCREEN_WIDTH / 2 - title.get_width() / 2, SCREEN_HEIGHT / 3))
        screen.blit(start_button, (start_rect.x + start_rect.w/2 - start_button.get_width()/2, start_rect.y + start_rect.h/2 - start_button.get_height()/2))
        pygame.display.flip()

        # check if the start button was clicked
        mouse_pos = pygame.mouse.get_pos()
        if start_rect.collidepoint(mouse_pos):
            if pygame.mouse.get_pressed()[0]:
                running = False
                break

    # generate the game variables
    blocks = []

    # generate random set of blocks
    for _ in range(no_of_blocks):
        # generate a random position
        x = random.randint(0, grid_size-1)
        y = random.randint(0, grid_size-1)
        while [x, y] in blocks:
            x = random.randint(0, grid_size-1)
            y = random.randint(0, grid_size-1)
        blocks.append([x, y])

    # add the bombs
    for _ in range(bombs):
        # generate a random position
        x = random.randint(0, grid_size-1)
        y = random.randint(0, grid_size-1)
        while [x, y] in blocks:
            x = random.randint(0, grid_size-1)
            y = random.randint(0, grid_size-1)
        blocks.append([x, y])
        bombs -= 1

    # generate a list of adjacent blocks
    adjacent_blocks = []
    for block in blocks:
        x, y = block
        # top left
        if x > 0 and y > 0:
            adjacent_blocks.append([x-1, y-1])
        # top
        if y > 0:
            adjacent_blocks.append([x, y-1])
        # top right
        if x < grid_size-1 and y > 0:
            adjacent_blocks.append([x+1, y-1])
        # right
        if x < grid_size-1:
            adjacent_blocks.append([x+1, y])
        # bottom right
        if x < grid_size-1 and y < grid_size-1:
            adjacent_blocks.append([x+1, y+1])
        # bottom
        if y < grid_size-1:
            adjacent_blocks.append([x, y+1])
        # bottom left
        if x > 0 and y < grid_size-1:
            adjacent_blocks.append([x-1, y+1])
        # left
        if x > 0:
            adjacent_blocks.append([x-1, y])

    # draw the blocks and bombs
    draw_background()
    for block in blocks:
        x, y = block
        block_width = SCREEN_WIDTH / grid_size
        block_height = SCREEN_HEIGHT / grid_size

        rect = pygame.Rect(x * block_width, y * block_height,
                            block_width, block_height)

        pygame.draw.rect(background, TEXT_COLOUR, rect)

    for block in adjacent_blocks:
        x, y = block
        block_width = SCREEN_WIDTH / grid_size
        block_height = SCREEN_HEIGHT / grid_size

        rect = pygame.Rect(x * block_width, y * block_height,
                            block_width, block_height)

        pygame.draw.rect(background, TEXT_COLOUR, rect, 1)

    screen.blit(background, (0, 0))
    pygame.display.flip()
    
    # get the player's name
    name = input('Please enter your name: ')
    player = Player(name, 0)

    # display the game
    playing = True
    while playing:
        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                playing = False
            if event.type == pygame.MOUSEBUTTONDOWN and event.button == 1:
                # perform the attack
                x, y = pygame.mouse.get_pos()
                block_width = SCREEN_WIDTH / grid_size
                block_height = SCREEN_HEIGHT / grid_size
                x = int(x / block_width)
                y = int(y / block_height)

                if [x, y] in blocks:
                    blocks.remove([x, y])
                    player.score += 10
                if [x, y] in adjacent_blocks:
                    player.score -= 5

                # redraw the screen
                draw_background()
                for block in blocks:
                    x, y = block
                    block_width = SCREEN_WIDTH / grid_size
                    block_height = SCREEN_HEIGHT / grid_size

                    rect = pygame.Rect(x * block_width, y * block_height,
                                        block_width, block_height)

                    pygame.draw.rect(background, TEXT_COLOUR, rect)

                for block in adjacent_blocks:
                    x, y = block
                    block_width = SCREEN_WIDTH / grid_size
                    block_height = SCREEN_HEIGHT / grid_size

                    rect = pygame.Rect(x * block_width, y * block_height,
                                        block_width, block_height)

                    pygame.draw.rect(background, TEXT_COLOUR, rect, 1)

                screen.blit(background, (0, 0))
                pygame.display.flip()

        # end game when all blocks and bombs have been cleared
        if len(blocks) == 0:
            playing = False

    # display the results
    background = pygame.Surface(screen.get_size())
    background = background.convert()
    background.fill(BACKGROUND_COLOUR)

    screen.blit(background, (0, 0))
    title = font.render('Game Over!', True, TEXT_COLOUR)
    score_text = font.render('Score: ' + str(player.score), True, TEXT_COLOUR)
    screen.blit(title, (SCREEN_WIDTH / 2 - title.get_width() / 2, SCREEN_HEIGHT / 4))
    screen.blit(score_text, (SCREEN_WIDTH / 2 - score_text.get_width() / 2, SCREEN_HEIGHT / 3))
    pygame.display.flip()

    time.sleep(3)

if __name__ == '__main__':
    main()