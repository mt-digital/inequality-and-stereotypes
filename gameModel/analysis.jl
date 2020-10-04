##
# inequality-and-stereotypes/gameModel/analysis.jl
# 
# Date: 2020-10-03
# Author: Matthew A. Turner <maturner01@gmail.com>

using StatsBase: countmap

using DataFrames: DataFrame

function prevalences(final_step_df::DataFrame)
    prevs = Dict(
        "$gender" => 
            countmap(
                filter(row -> row.gender == gender, final_step_df).strategy
            )
        for gender in ["woman", "man"]
    )
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
