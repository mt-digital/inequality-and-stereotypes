include("model.jl")
include("analysis.jl")


function run_basic_experiment(; payoffs::Payoffs = Payoffs(),
                                gendered::Bool = false,
                                man_threat::Float64 = 0.0,
                                n_replicates::Int64 = 10,
                                n_rounds = 10,
                               numagents = 100)

    results = [Dict() for _ in 1:n_replicates]

    for run_idx in 1:n_replicates

        data = run_model!(; 
                          payoffs = payoffs, 
                          nsteps=101, collect_every=100, numagents=numagents, 
                          n_rounds = n_rounds, gendered = gendered)

        d = filter(row -> row.step == 101, data); 

        results[run_idx] = final_strategies(prevalences(d), Int(numagents / 2))

    end

    return results
end
