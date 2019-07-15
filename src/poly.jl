module poly

using SparseArrays
## Simple Simplex Solver
##----------------------

    function eliminate_gaussian(matrix::SparseMatrixCSC, row_idx::Integer)

        t_d1 = size(matrix, 1)
        t_d2 = size(matrix, 2)
        r_current = matrix[row_idx, :]

        ## CONTINUE HERE
        #for

    end

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
        t_init = SparseArrays.sparse(I, J, V, num_cons + 1, 1 + num_vars + num_cons + 1)
        t_d1 = size(t_init, 1)
        t_d2 = size(t_init, 2)

        ## Solve LP
        ##---------
        t_current = t_init
        counter = 0
        while maximum(t_current[t_d1, :]) > 0 && counter < 4

            # Get idx of maximal improvement in objective
            #--------------------------------------------
            idx = t_d1
            max = maximum(t_current[t_d1, :])
            for i in 2:t_d2
                if t_current[t_d1, i] == max
                    idx = i
                    break
                end
            end

            t_current = eliminate_gaussian(t_current, idx)

            counter += 1
        end
    end
end
