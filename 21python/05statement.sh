if : else eli
    if name.endswith('Gumby'):
        if name.startswith('Mr.'):
            print 'Hello, Mr. Gumby'
        elif name.startswith('Mrs.'):
            print 'Hello, Mrs. Gumby'
        else:
            print 'Hello, Gumby'
    else:
        print 'Hello, stranger'

Loops:
    while Loops:
        x = 1
        while x <= 100:
            print x
            x += 1

        name = ''
        while not name:
            name = raw_input('Please enter your name: ')
        print 'Hello, %s!' % name

    for Loops:
        for word in words:
            print word

        for number in range(1,101):
            print number

    Iterating Over Dictionaries:
        d = {'x': 1, 'y': 2, 'z': 3}
        for key in d:
            print key, 'corresponds to', d[key]

        for key, value in d.items():
            print key, 'corresponds to', value

        Some Iteration Utilities:
            Parallel Iteration
                names = ['anne', 'beth', 'george', 'damon']
                ages = [12, 45, 32, 102]
                for i in range(len(names)):
                    print names[i], 'is', ages[i], 'years old'

                >>> zip(names, ages)
                [('anne', 12), ('beth', 45), ('george', 32), ('damon', 102)]
    Breaking Out of Loops:
        break
        continue

exec:
        The statement for executing a string is exec: 
            >>> exec "print 'Hello, world!'"
            Hello, world!










