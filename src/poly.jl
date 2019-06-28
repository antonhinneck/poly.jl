module poly

using SparseArrays
## Simple Simplex Solver
##----------------------

    function solve(objective, A, rhs)

        num_vars = size(A[1], 1)
        num_cons = size(A, 1)
        vars_match = true

        for i in 1:size(A, 1)
            if !(size(A[i], 1) == num_vars)
                vars_match = false
            end
        end

        @assert vars_match                      "POLY ERROR: Amount of variables does not match."
        @assert size(rhs, 1) == size(A, 1)      "POLY ERROR: Amount of constraints does not match."

        ## Generate initial dictionary
        ##----------------------------
        I = Vector{Int64}()
        J = Vector{Int64}()
        V = Vector{Float64}()

        ## Process A
        ##----------
        for i in 1:num_cons
            for j in 1:num_vars

                push!(I, i)
                push!(J, j + 1)
                push!(V, A[i][j])

            end
        end

        ## Slack Variables
        ##----------------
        for i in 1:num_cons

            push!(I, i)
            push!(J, 1 + num_vars + i)
            push!(V, 1.0)

        end

        ## Objective
        ##----------
        push!(I, num_cons + 1)
        push!(J, 1)
        push!(V, -1.0)

        for j in 2:(num_vars + 1)

            push!(I, num_cons + 1)
            push!(J, j)
            push!(V, objective[j - 1])

        end

        ## Build RHS
        ##----------
        for i in 1:num_cons

            push!(I, i)
            push!(J, 1 + num_vars + num_cons + 1)
            push!(V, rhs[i])

        end

        ## Build SparseArray
        ##------------------
        tab_init = SparseArrays.sparse(I, J, V, num_cons + 1, 1 + num_vars + num_cons + 1)
        tab_d1 = size(tab_init, 1)
        tab_d2 = size(tab_init, 2)

        ## Solve LP
        ##---------
        tab_current = tab_init
        counter = 0
        while maximum(tab_init[tab_d1] > 0) && counter < 4

            # Get idx of maximal improvement in objective
            #--------------------------------------------
            idx = size()
            for i in 2:size(tab_current, 2)
                size(tab_current, 1)
            end
            	
            counter += 1
        end
    end
end

function eliminate_gaussian(matrix::SparseMatrixCSC, r_idx::Integer, c_idx::Integer)



end
