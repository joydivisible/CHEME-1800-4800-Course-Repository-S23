
"""
_jacobi_iteration_solver(A::Array{Float32,2}, b::Array{Float32,1}, xₒ::Array{Float32,1},
    tolerance::Float32, maxiter::Int32) -> Array{Float32,1}

Internal method that performs Jacobi iteration on the system Ax = b starting from the initial guess xₒ.
The solver runs until maxiter (maximum number of iterations), or the error tolerance is met. 
"""
function _jacobi_iteration_solver(A::Array{Float32,2}, b::Array{Float32,1}, xₒ::Array{Float32,1},
    tolerance::Float32, maxiter::Int32)::Array{Float32,1}

    # initialize
    (number_of_cols) = size(A,1);
    x̂ = xₒ                      # set the current best answer to the initial guess that was passed
    ϵ = Inf;                    # initial error is Inf
 
    # main -
    for _ ∈ 1:maxiter # go until we hit max itertations
        
        # initialize tmp solution
        x′ = zeros(number_of_cols)
        for i ∈ 1:number_of_cols
            
            s = 0;
            for j ∈ 1:number_of_cols
                if (i != j)
                    s += A[i,j]*x̂[j]
                end
            end
            
            # calculate new x value
            x′[i] = (1/A[i,i])*(b[i] - s);
        end

        # update the flag -
        ϵ = norm(x′ - x̂)
        if (ϵ < tolerance)
            # the solution 
            return x′
        else
            x̂ = x′; # update the solution
        end
    end

    # return
    return x̂
end

"""
_gauss_seidel_iteration_solver(A::Array{Float32,2}, b::Array{Float32,1}, xₒ::Array{Float32,1},
    tolerance::Float32, maxiter::Int32) -> Array{Float32,1}

Internal method that performs Gauss Seidel iteration on the system Ax = b.
The solver runs until maxiter (maximum number of iterations). This function wraps a call to the 
`gauss_seidel(A,b; maxiter = maxiter)` function in IterativeSolvers.jl
"""
function _gauss_seidel_iteration_solver(A::Array{Float32,2}, b::Array{Float32,1}, xₒ::Array{Float32,1},
    tolerance::Float32, maxiter::Int32)::Array{Float32,1}

    # Step 4: Check out the documentation for IterativeSolvers.jl
    # see: https://iterativesolvers.julialinearalgebra.org/stable/
    return gauss_seidel(A,b; maxiter = maxiter)
end

"""
solve(type::T, A::Array{Float32,2}, b::Array{Float32,1}, xₒ::Array{Float32,1};
    tolerance::Float32 = 0.001, maxiter::Int32 = 10000) -> Array{Float32,1} where T <: AbstractIterativeSolver
"""
function solve(type::Union{JacobiIterationSolver, GaussSeidelIterationSolver}, A::Array{Float32,2}, b::Array{Float32,1}, xₒ::Array{Float32,1};
    tolerance::Float32 = 0.001, maxiter::Int32 = 10000)::Array{Float32,1}
    
    if (isa(type, JacobiIterationSolver) == true)
        return _jacobi_iteration_solver(A, b, xₒ, tolerance, maxiter);
    elseif (isa(type, GaussSeidelIterationSolver) == true)
        return _gauss_seidel_iteration_solver(A, b, xₒ, tolerance, maxiter);
    else
        throw("Incorrect solver type has been requested!")
    end
end