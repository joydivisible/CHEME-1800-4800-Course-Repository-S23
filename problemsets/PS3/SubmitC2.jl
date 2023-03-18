include("include.jl")
N = 200
κ = convert(Float32, 10.0)
h = convert(Float32, 0.1)
Cₒ = convert(Float32, 10.0)

model = build(MyChemicalDecayModel, N = N, κ = κ, h = h, Cₒ = Cₒ)

A = model.A
b = model.b

IG = convert.(Float32, zeros(N))

# Step 5: run JacobiIterationSolver with the test system
x_jacobi = _jacobi_iteration_solver(A, b, IG, convert(Float32, 1e-9), 10000)

x_d = inv(A)*b
err1 = norm(x_jacobi - x_d)

# Step 6: run the GaussSeidelIterationSolver with the test system
x_gs = _gauss_seidel_iteration_solver(A, b, IG, convert(Float32, 1e-9), 10000);
err2 = norm(x_gs - x_d)