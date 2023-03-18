"""
    _build_right_handside_vector(N::Int32, κ::Float32, h::Float32, Cₒ::Float32) -> Array{Float32,1}

Internal function that constructs the right-hand side vector for the chemical decay problem
"""
function _build_right_handside_vector(N::Int32, κ::Float32, h::Float32, Cₒ::Float32)::Array{Float32,1}

    # Vector syntax
   b = zeros(N)
   b[1] = Cₒ*(1-h*κ)
   return b
end

"""
    _build_system_matrix(N::Int32, κ::Float32, h::Float32) -> Array{Float32,2}

Internal function that constructs the system matrix for the chemical decay problem
"""
function _build_system_matrix(N::Int32, κ::Float32, h::Float32)::Array{Float32,2}

    # Matrix syntax
    # Initialize
    A = Array{Float32, 2}(undef, N, N)
    fill!(A, 0.0)
    A[1,1] = 1 # Solves the first case: element 1,1 of the array is a 1
    for i in 2:N
        for j in 2:N
            if (i == j)
                A[i,j] = 1
                A[i,j-1] = (κ*h-1)
            end
        end
    end
    # return 
    return A

end

"""
    build(type::Type{MyChemicalDecayModel}; 
        κ::Float32 = 0.0, h::Float32 = 0.0, N::Int32 = 0, Cₒ::Float32 = 0.0) -> MyChemicalDecayModel

Build an instance of MyChemicalDecayModel and sets the value of the model parameters. 
Default model parameters are zero
"""
function build(type::Type{MyChemicalDecayModel}; 
    κ::Float32 = 0.0, h::Float32 = 0.0, N::Int32 = 0, Cₒ::Float32 = 0.0)::MyChemicalDecayModel

    # build an empty model -
    model = MyChemicalDecayModel()

    # set parameters on the model
    model.κ = κ
    model.h = h
    model.N = N
    model.Cₒ = Cₒ
    model.A = _build_system_matrix(N, κ, h)
    model.b = _build_right_handside_vector(N, κ, h, Cₒ)

    # return
    return model
end



