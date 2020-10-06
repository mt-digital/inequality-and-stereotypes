##
# inequality-and-stereotypes/gameModel/analysis.jl
# 
# Date: 2020-10-03
# Author: Matthew A. Turner <maturner01@gmail.com>
#

include("experiment.jl")

using StatsBase: countmap

using DataFrames: DataFrame

using CSV

function prevalences(final_step_df::DataFrame)
    prevs = Dict(
        "$gender" => 
            countmap(
                filter(row -> row.gender == gender, final_step_df).strategy
            )
        for gender in ["woman", "man"]
    )
end




function replication(gendered=false, num_agents=100, n_rounds=5, 
                     data_path="replication.csv")
    """
    Replicate data presented in Figure 5.2 of O'Connor (2019; Ch. 5) for
    a low demand of 3. I'm interested in the effect of finite-size population
    and showing how gendering sometimes leads to overall inequality.
    """
    columns = ["Mixed/not converged", "Women high", "Women low", "Both medium",
               "Non-maximizing", "Gendered"]


    # For simplicity for now, each of these becomes a single row in the ret df.
    nongendered = run_basic_experiment(n_replicates=100, n_rounds=3, nsteps=101,
                                       num_agents=20, gendered=false)
    gendered = run_basic_experiment(n_replicates=100, n_rounds=3, nsteps=101,
                                    num_agents=20, gendered=true)

    # There are several types of results that I am seeing, and I will have
    # to list them all. I'll make a helper function below to assign 
    # outcome type. 
    nongen_row = countmap(map(determine_outcome_type, nongendered))
    gen_row = countmap(map(determine_outcome_type, gendered))

    for res in [nongen_row, gen_row]
        for column in columns
            if !(column in keys(res))
                res[column] = 0
            end
        end
    end

    nongen_row["Gendered"] = 0
    gen_row["Gendered"] = 1

    ret = DataFrame(nongen_row)
    push!(ret, gen_row)

    CSV.write(data_path, ret)

    return ret
end


function determine_outcome_type(result)
    """
    Each result is the result of one experimental trial. It has information 
    about what strategies women and men are playing at the end of the 
    simulation. If the entry is a Dict then not all of one gender are 
    playing the same strategy. This seems to only happen in the non-gendered
    case. 
    """

    # Using OR here; one I saw was, e.g., women high, men mixed; let's just
    # call that mixed for now.
    if isa(result[:women], Dict) || isa(result[:men], Dict)
        return "Mixed/not converged" 

    else

        if (result[:women] == "High") && (result[:men] == "Low")
            return "Women high"

        elseif (result[:women] == "Low") && (result[:men] == "High")
            return "Women low" 

        # elseif (result[:women] == "Low") && (result[:men] == "Low")
        #     return "Both low"

        elseif (result[:women] == "Medium") && (result[:men] == "Medium")
            return "Both medium"

        # elseif (result[:women] == "High") && (result[:men] == "High")
        #     return "Both high"

        else
            # These ones have payoffs less than the maximum of 10. 
            # med-high, med-low, low-low.
            return "Non-maximizing"
        end
    end
end
