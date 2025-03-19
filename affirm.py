import random

affirmations = [
  "You are capable of amazing things.",
  "Believe in yourself and all that you are.",
  "You have the power to create change.",
  "You have the power to build anything.",
  "Every day is a new opportunity to grow.",
  "You are worthy of love and respect.",
  "You deserve success.",
  "You are loveable and worthy to be loved.",
  "You deserve to feel happy.",
  "Embrace the journey, not just the destination.",
  "Your potential is limitless.",
  "Stay positive, take it easy, and it will happen."
]

def get_random_affirmation():
  return random.choice(affirmations)

if __name__ == "__main__":
  print(get_random_affirmation())

