"""Flappy, game inspired by Flappy Bird.

Exercises

1. Keep score.
2. Vary the speed.
3. Vary the size of the balls.
4. Allow the bird to move forward and back.
"""
import turtle
from random import *
#from py_tkinter import func
from turtle import *
import time
from freegames import vector
import sqlite3

# global flappy_score


def f_Flappy():
    
    bird = vector(0, 0)
    balls = []

    #unit='seconds'
    start_time = time.time()
    minutes = 0
    second = 0
    print_score = ""


    def tap(x, y):
        """Move bird up in response to screen tap."""
        up = vector(0, 30)
        bird.move(up)


    def inside(point):
        """Return True if point on screen."""
        return -200 < point.x < 200 and -200 < point.y < 200


    def draw(alive):
        """Draw screen objects."""
        clear()

        goto(bird.x, bird.y)

        if alive:
            dot(10, 'green')
        else:
            dot(10, 'red')
            score = time.time() - start_time
            if score > 60:
                minutes = score//60
                second = round((score - minutes*60),2)
                print_score = f"Score : {minutes} minutes and {second} seconds"
                # flappy_score=print_score
                return print_score
                
            else:
                print_score = f"Score : {round(score,2)} seconds"
                #print(print_score)
                return print_score

        for ball in balls:
            goto(ball.x, ball.y)
            dot(20, 'black')

        update()


    def move():
        """Update object positions."""
        bird.y -= 5

        for ball in balls:
            ball.x -= 3

        if randrange(10) == 0:
            y = randrange(-199, 199)
            ball = vector(199, y)
            balls.append(ball)

        while len(balls) > 0 and not inside(balls[0]):
            balls.pop(0)

        if not inside(bird):
            draw(False)
            return

        for ball in balls:
            if abs(ball - bird) < 15:
                draw(False)
                return

        draw(True)
        ontimer(move, 50)


    setup(420, 420, 370, 0)
    hideturtle()
    up()
    tracer(False)
    onscreenclick(tap)
    move()
    done()

    # turtle.reset()
    # turtle.Terminator()
    # turtle.exitonclick()
# f_Flappy()
#print(turtle.Terminator)

