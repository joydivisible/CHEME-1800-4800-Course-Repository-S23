"""
    build_data_matrix(data::DataFrame) --> Array{Float64,2}

TODO: Fill me in.
"""
function build_data_matrix(data::DataFrame)::Array{Float64,2}
   iterate = 3
    
   (R,C) = size(data)

   matrixarray = Array{Float64,1}()
   for i in 1:R
       value = data[i,:S]
       for j in 1:iterate
           push!(matrixarray,(1/value))
       end
   end

   X = Array{Float64,2}(undef, iterate*R, 2)
   for i in 1:iterate:(iterate*R)
       for j in i:(i+iterate-1)
           
           # get the S level -
           value = matrixarray[j]
           
           # fill in the columns of the data matrix -
           X[j,1] = 1.0
           X[j,2] = value
       end
   end

   # return -
   return X
end

"""
    build_output_vector(data::DataFrame) --> Array{Float64,1}

TODO: Fill me in.
"""
function build_output_vector(data::DataFrame)::Array{Float64,1}
    iterate = 3

    (R,C) = size(data)

    vectorarray = Array{Float64,1}()
    for i ∈ 1:R
        for j ∈ 1:iterate
            value = data[i,j+1];
            push!(vectorarray, (1/value));
        end
    end

    return vectorarray;
end

"""
    build_error_distribution(residuals::Array{Float64,1}) -> Normal

Fill me in.
"""
function build_error_distribution(residuals::Array{Float64,1})::Normal

    μ = 0.0; # default value, replace with your value
    σ = 0.0; # default value, replace with your value

    # initialize -
    μ = mean(residuals);
    σ = std(residuals);

    # return -
    return Normal(μ, σ);
end

