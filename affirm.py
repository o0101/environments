import random

affirmations = [
  "You are capable of amazing things.",
  "Believe in yourself and all that you are.",
  "You have the power to create change.",
  "Every day is a new opportunity to grow.",
  "You are worthy of love and respect.",
  "Embrace the journey, not just the destination.",
  "Your potential is limitless.",
  "Stay positive, work hard, make it happen."
]

def get_random_affirmation():
  return random.choice(affirmations)

if __name__ == "__main__":
  print(get_random_affirmation())

