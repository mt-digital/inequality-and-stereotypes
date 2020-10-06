include("model.jl")
# include("analysis.jl")


function run_basic_experiment(; payoffs::Payoffs = Payoffs(),
                                gendered::Bool = false,
                                man_threat::Float64 = 0.0,
                                n_replicates::Int64 = 10,
                                n_rounds = 10,
                                nsteps = 101,
                               num_agents = 100,
                               collect_every = 100)

    results = [Dict() for _ in 1:n_replicates]

    for run_idx in 1:n_replicates

        data = run_model!(; 
                          payoffs = payoffs, 
                          nsteps=nsteps, collect_every=100, num_agents=num_agents, 
                          n_rounds = n_rounds, gendered = gendered)

        d = filter(row -> row.step == 101, data); 

        results[run_idx] = final_strategies(prevalences(d), Int(num_agents / 2))

    end

    return results
end


function final_strategies(prevalences_result::Dict, n_per_gender::Int)

    strategy(gender) = first(values(prevalences_result[gender]))

    if strategy("woman") == n_per_gender
        women_strategy = first(keys(prevalences_result["woman"]))
    else
        women_strategy = prevalences_result["woman"]
    end

    if strategy("man") == n_per_gender
        men_strategy = first(keys(prevalences_result["man"]))
    else
        men_strategy = prevalences_result["man"]
        # men_strategy = "mixed - not converged"
    end

    return Dict(
                :women => women_strategy,
                :men => men_strategy
               )
end
