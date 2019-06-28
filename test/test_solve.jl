include("C:/Users/Anton Hinneck/.julia/packages/poly/src/poly.jl")
using SparseArrays

obj = [5, 4, 3]

A = [[2, 3, 1],
     [4, 1, 2],
     [3, 4, 2]]

rhs = [5, 11, 8]

poly.solve(obj, A, rhs)
