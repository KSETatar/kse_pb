import random

def generate_secret_word(word_list):
    return random.choice(word_list)

def get_guess(expected_length):
    while True:
        guess = input(f"Enter your guess ({expected_length} letters): ").lower()
        if len(guess) != expected_length:
            print(f"Invalid length. Expected {expected_length} letters.")
        elif not guess.isalpha():
            print("Only alphabetic characters are allowed.")
        else:
            return guess

def check_guess(secret_word, guess):
    result = []
    for i in range(len(secret_word)):
        if guess[i] == secret_word[i]:
            result.append("correct")
        elif guess[i] in secret_word:
            result.append("present")
        else:
            result.append("absent")
    return result

def format_result(guess, result):
    display = []
    for i in range(len(guess)):
        if result[i] == "correct":
            display.append("[" + guess[i].upper() + "]")
        elif result[i] == "present":
            display.append("(" + guess[i] + ")")
        else:
            display.append(" " + guess[i] + " ")
    return ' '.join(display)

def play_game():
    words = ['apple', 'bread', 'candy', 'dream', 'eagle', 'flame', 'grape', 'house', 'input', 'joker']
    secret_word = generate_secret_word(words)
    tries = 6
    word_length = len(secret_word)

    print(f"Welcome to Wordle!")
    print("Guess the", word_length, "-letter word. You have", tries, "tries.")

    for attempt in range(1, tries + 1):
        print(f"Attempt {attempt}\{tries}")
        guess = get_guess(word_length)

        if guess == secret_word:
            print("You win!!!")
            return

        result = check_guess(secret_word, guess)
        print("Result:", format_result(guess, result))

    print(f"You lose! The word was:", secret_word)

def main():
    while True:
        play_game()
        again = input(f"Want to play again? (press y): ").strip().lower()
        if again != 'y':
            print("Thanks for playing!")
            break

if __name__ == "__main__":
    main()

#Роздуми
# Коли глянув на початковий код, зрозумів що буде весело, бо код хоч й працював, але виглядав він... як виглядав.
# Понатицяно все не зрозуміло де, чудові "функції", змінні стилю "одна літера", функція рандому через x, y, z, коли
# можна було проосто random.choice зробити, деякі речі просто стоятьбо можуть, і навіть нічого не роблять... 
# Коротше кажучи - шик!

# Мій рефакторинг найкращий в світі й після нього все дуже гарно і читабельно.
# Озвучені раніше проблеми вирішив, на defи все розподілив, додав можливость переграти, обробку помилок наче реалізував. 
# ПО ТЗ, наче справився.

# Про додати/змінити/прибрати не знаю, але з очевидного щоб виводилось воно кольоровою табличкою з фоном зеленого та жовтого 
# кольору замість [] та (), можливо якусь статистику, щоб щось зберігалось...

