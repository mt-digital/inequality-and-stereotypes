##
# inequality-and-stereotypes/model.jl 
#


using Agents
using Statistics: mean


numagents = 100


mutable struct Haploid <: AbstractAgent
    id::Int
    trait::Float64
end


function demo_evolution(; neutral::Bool = true, nsteps::Int = 20, 
                        collect_every::Int = 1)
    
    # Create model without spatial or network structure.
    model = ABM(Haploid)

    # Initialize model agents.
    for i in 1:numagents
        add_agent!(model, rand())
    end
    
    # `sample!` chooses random individuals with replacement which will 
    # constitute the population in the next iteration.
    if neutral
        model_step!(model::ABM) = sample!(model, nagents(model))
    else
        model_step!(model::ABM) = sample!(model, nagents(model), :trait)
    end

    # Run model and collect specified data.
    data, _ = run!(model, dummystep, model_step!, nsteps; 
                   adata = [(:trait, mean)], 
                   when = 1:collect_every:nsteps+1)
    return data
end
