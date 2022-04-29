def binary_search(n , arr):

    start = 0
    stop = len(arr)-1

    while start <= stop:

        mid = (start + stop)//2

        if n == arr[mid]:

            return f"{n} found at index : {mid}"

        elif n > arr[mid]:

            start = mid + 1
        
        else :

            stop = mid -1
    
    return f"{n} is not found in the list"

l = [1,2,3,4,7,9,10]

print(binary_search(2,l))