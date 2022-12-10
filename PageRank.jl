using LinearAlgebra


# PAGERANK

# function takes input and makes adjacency matrix
function adj(input)
    size = length(input)
    A = zeros((size, size))
    for col in 1:size
        tos = input[col][2]
        for i in 1:(length(tos))
            row = tos[i]
            index = (col-1)*size + row
            setindex!(A, [1], [index])
        end
    end
    A
end

# Takes input and makes markov matrix
function tranM(input)
    M = adj(input) 
    size = length(input)
    for col in 1:size
        tos = input[col][2]
        divisor = length(tos)
        for row in 1:size
            curVal = getindex(M, row, col)
            if divisor == 0
                newVal = 0
            else  
                newVal = curVal/divisor
            end
            index = (col-1)*size + row
            setindex!(M, [newVal], [index])
        end
    end
    M
end


# Takes a markov matrix and return rank
function pagerank(input)
    transitionM = tranM(input)
    damp = .85
    N = length(input)
    c = (1-damp)/N * ones(N, 1)
    rank = 1/N * ones(N, 1)
    for iteration in 1:43
        rank = damp*transitionM*rank + c
    end
    rank
end

# HITS!

function hit(input)
    A = adj(input)
    size = length(input)
    h = ones(size, 1)
    a = ones(size, 1)
    for iteration in 1:43
        a = A * h 
        a = (1/sum(a))*a       
        h = A' * a 
        h = (1/sum(h))*h
    end
    print(a, "\n", h, "\n")
    a, h
end

inputExample = [(1, [2, 3]), (2, [3,1]), (3, [5,4]), (4, [5]), (5, [4, 1])]


example2 = [(1, [2]), (2, [1]), (3, []), (4, [2,3]), (5, [1,2]), (6, [3])]
example3 = [
    (1, [4]),
    (2, [3, 5]),
    (3, [1]),
    (4, [2,3]),
    (5, [2,3,6,4]),
    (6, [3, 8]),
    (7, [3,1]),
    (8, [1])
]

pagerank(inputExample)