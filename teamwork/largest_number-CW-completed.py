numbers = []

while len(numbers) < 5:
    num = int(input('Please enter the number: '))
    numbers.append(num)


def findLargestNum(nums):
    # Here you write your code
    # And return the largest number in the array

    # Solution # 1
    # largest = nums[0]
    # for i in nums:
    #     if i > largest:
    #         largest = i
    #
    # return largest

    # Solution # 2
    print(nums.sort(reverse=True))
    return nums.sort(reverse=True)[0]

    # Solution # 3
    #return max(nums)


print('Result: ', findLargestNum(numbers))

# ***************************************
# Don't change anything below this line!
# ***************************************

print('\n*** Testing ***\n')


def test(set):
    result = findLargestNum(set)
    expected = max(set)
    print('Given set: ', set)
    if result == expected:
        print('Passed:  expected ', expected, ' | result: ', result)
    else:
        print('Failed : expected ', expected, ' | result ', result)


import random

print('Test 1:')
list_01 = random.sample(range(5000), 10)
test(list_01)
print('\nTest 2:')
list_01 = random.sample(range(5000), 5)
test(list_01)
print('\nTest 3:')
list_01 = random.sample(range(5000), 8)
test(list_01)
