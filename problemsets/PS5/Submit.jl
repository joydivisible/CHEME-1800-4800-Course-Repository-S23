# include the include
include("Include.jl")

# data
path_to_data_file = joinpath(_PATH_TO_DATA, "PS5-dataset-w-repeats.csv")
data = loaddataset(path_to_data_file);

# data matrix -
X = build_data_matrix(data);

# output vector -
Y = build_output_vector(data);

XINV = inv(transpose(X)*X)*transpose(X)
β̂ = XINV*Y;

errors = Y - X*β̂;
ϵ = build_error_distribution(errors);

number_of_samples = 10000;
number_of_parameters = 2;
simulated_parameter_values = Array{Float64,2}(undef,number_of_samples,2)
for s ∈ 1:number_of_samples
    β = β̂ - XINV*rand(ϵ,300);
    for p ∈ 1:number_of_parameters
        simulated_parameter_values[s,p] = β[p];
    end
end

μ_beta_1 = mean(simulated_parameter_values[:,1]);
μ_beta_2 = mean(simulated_parameter_values[:,2]);

σ_beta_1 = std(simulated_parameter_values[:,1]);
σ_beta_2 = std(simulated_parameter_values[:,2]);

result_table_header = ["Parameters","Actual","μ","σ"]
result_table = Array{Any,2}(undef, 2,4);
result_table[1,1] = "β₁"
result_table[2,1] = "β₂"
result_table[1,2] = 0.00289;
result_table[2,2] = 0.3765;
result_table[1,3] = μ_beta_1
result_table[1,4] = σ_beta_1
result_table[2,3] = μ_beta_2
result_table[2,4] = σ_beta_2
pretty_table(result_table; header=result_table_header)
