age = int(input("How old are you?\n"))

decades = age // 100
years = age % 100

print("You are " + str(decades) + 
      " decades And" + str(years) + " Years old." )