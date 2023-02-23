
"""
    read_reaction_file(path::String) -> Dict{Int,String}
"""
function read_reaction_file(path::String)::Dict{String, MyKeggReaction}
    
    # check: is path legit?
    # in production we would check this path, assume ok for now

    # initialize -
    reactions = Dict{String, MyKeggReaction}()
    counter = 0; # zero-based index

    # use example pattern from: https://varnerlab.github.io/CHEME-1800-Computing-Book/unit-1-basics/data-file-io.html#program-read-a-csv-file-refactored
    open(path, "r") do io # open a stream to the file
        for line in eachline(io) # read each line from the stream
            
            # Impl me -
            # line is a line from the file  

            # A couple of things to think about: 
            # a) ignore the comments, check out the contains function: https://docs.julialang.org/en/v1/base/strings/#Base.contains
            # b) records are comma delimited. Check out the split functions: https://docs.julialang.org/en/v1/base/strings/#Base.split
            # c) from the data in each reacord, we need to build a MyKeggReaction object. Each reaction object should be stored in the reactions dict with the name as the key
                # ....
            # split the line around the delim -
            fields = split(line, delim);
            if (counter == 1)
                
                # package the hedaer -
                for value in fields
                    push!(header, value)
                end

                # update the counter -
                counter = counter + 1
            else

                # package -
                tmp = Array{Float64,1}()
                reactions = fields[string]
                for (i,value) in enumerate(fields)
                    if (i != keyindex)
                        push!(tmp, parse(Float64,value))
                    end
                end
            end
        end

        # set the path -
        path_to_file = "Treasury-HistoricalData-09-09-22.csv";

        # load file -
        (h,d) = loadcsvfile(path_to_file);



            

        end
    end

    # return -
    return reactions;
end