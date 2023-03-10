"""
    _recursive_compound_parser()

TODO: Describe what this function does, the args and what we expect it to return
Creates a compound dictionary, then stores the names as keys to dictionaries themselves
"""
function _recursive_compound_parser(queue::Queue, element::Array{Char, 1}, number::Array{Int, 1})
    # TODO: Implement me
    if (isempty(queue) == true)
        return nothing
    else
        nextchar = dequeue!(queue)
        if (isletter(nextchar) == true)
            push!(element, nextchar)
        elseif(isempty(queue) == false)

            nextnextchar = dequeue!(queue)
            if (isletter(nextnextchar) == true)
                push!(number, parse(Int, nextchar))
                push!(element, nextnextchar)
            else
                num = string(nextchar, nextnextchar)
                push!(number, parse(Int, num))
            end
        else
            push!(number, parse(Int, nextchar))
        end
    end
    _recursive_compound_parser(queue, element, number)

end

"""
    recursive_compound_parser(compounds::Dict{String, MyChemicalCompoundModel}) -> Dict{String, MyChemicalCompoundModel}

TODO: Describe what this function does, the args and what we expect it to return 

HERE: use the catdog strategy to add 1's as needed. Could also edit the datafile to add those.
"""
function recursive_compound_parser(compounds::Dict{String, MyChemicalCompoundModel})::Dict{String, MyChemicalCompoundModel}

    # TODO: Implement a function that computes a composition dictionary of type Dict{Char,Int} for each of the compounds in the compounds dictionary
    #
    # Composition dictionary:
    # The composition dictionary will hold the elements of the compounds as Chars 
    # The number of each element will be the value held in the composition dictionary
    for (name, model) in compounds
        composition = Dict{Char, Int}()
        element = Array{Char, 1}()
        number = Array{Int, 1}()

        queue = Queue{Char}()



        formula = model.compound
        characterarray = collect(formula)
        for char in characterarray
            enqueue!(queue, char)
        end

        _recursive_compound_parser(queue, element, number)
        println(element)
        println(number)

        i = 1
        for e in element
            composition[e] = number[i]
            i += 1
        end
        
        model.composition = composition

    end
    return compounds
end