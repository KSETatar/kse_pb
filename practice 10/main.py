from data_folder.data import get_data, load_data

data_path = "data_folder/cinemahalls.json"

def create_hall(file_path):
    halls = get_data(file_path)
    new_hall_name = input("What is the name for the new hall")
    if new_hall_name in halls:
        print("Already exists")
    else:
        num_rows = int(input("Enter number of rows"))
        num_columns = int(input("Enter number of columns"))
        new_hall_dict = {new_hall_name: []}
        for i in range(1, num_rows+1):
            for j in range(1, num_columns+1):
                seat_dict = {f"{i}-{j}": False}
                new_hall_dict[new_hall_name].append(seat_dict)
        halls.update(new_hall_dict)
    load_data(halls, file_path)

def show_empty_seats(file_path):
    halls = get_data(file_path)
    hall_name = input("Hall name? ")
    if hall_name not in halls:
        print("Hall is not exist")
        return None
    else:
        selected_hall = halls[hall_name]
        print(f"Selected hall = {selected_hall}")
        empty_seats = []
        for seat in selected_hall:
            for key, value in seat.items():
                if value is False:
                    empty_seats.append(key)
        return empty_seats

show_empty_seats(data_path)

while True:
    user_choice = int(input("Enter your action"))
    if user_choice == 0:
        break
    elif user_choice == 1:
        create_hall(file_path)
    elif user_choice == 2:
        print("Show empty seats")
        pass
    elif user_choice == 3:
        print("Book the seat")
        pass
    elif user_choice == 4:
        print("Decline reserve")
        pass


 