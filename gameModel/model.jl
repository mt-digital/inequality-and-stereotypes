##
# inequality-and-stereotypes/model.jl 
#
# Date: 2020-09-28
# Author: Matthew A. Turner <maturner01@gmail.com>

using StatsBase

using Agents
using Statistics: mean
using Random: shuffle


mutable struct Player <: AbstractAgent
    id::Int
    gender::String
    strategy::String
    next_strategy::String
    total_payoff::Float64
end


struct Payoffs
    Low::Float64
    Medium::Float64
    High::Float64
end


# Define default constructor payoff values.
Payoffs() = Payoffs(3.0, 5.0, 7.0)
# Payoffs() = Payoffs(4.5, 5.0, 5.5)


function assign_payoffs!(woman::Player, man::Player; 
                         payoffs::Payoffs = Payoffs(),
                         woman_threat::Float64=0.0, 
                         man_threat::Float64=0.0,
                         max_payoff::Float64=10.0)
    """
    Implement Nash demand game payoff matrix here. If demands are greater than
    the maximum, each gender agent gets its threat point. 
    """
    f_demand = getproperty(payoffs, Symbol(woman.strategy))
    m_demand = getproperty(payoffs, Symbol(man.strategy))

    # Assign payoffs.
    #
    # Agents get threat point payoffs if their demands exceed the maximum...
    if f_demand + m_demand > max_payoff
        woman.total_payoff += woman_threat
        man.total_payoff += man_threat
    else
    # ...otherwise agents get the payoffs they requested.
        woman.total_payoff += f_demand
        man.total_payoff += m_demand
    end
end


function agent_step!(agent, model)
    """
    Going to try using this for agent learning, even though it will be used
    on the first go before 
    """
    # Will have an option to run gendered and ungendered simulations 
    # where social learning is not gendered, i.e. the population 
    # has no gender awareness.
    agents = collect(allagents(model))  # Have to do this to use filter it seems...
    if model.gendered
        possible_teachers = filter(
            other -> (other.gender == agent.gender) & (other != agent),
            agents
        )
    else
        possible_teachers = filter(other -> other != agent, agents)
    end

    # We will weight the random teacher selection by the potential teachers'
    # total payoffs for the previous round.
    weights = map(pt -> pt.total_payoff, possible_teachers)
    teacher = StatsBase.sample(possible_teachers, Weights(weights))

    # If teacher is doing better adopt their strategy.
    if teacher.total_payoff > agent.total_payoff
        agent.next_strategy = teacher.strategy
    else
        agent.next_strategy = agent.strategy
    end

end


function model_step!(model::ABM)

    function isman(agent::Player)
        return agent.gender == "man"
    end

    agents = collect(allagents(model))
    
    # Reset payoffs for new set of interaction rounds and update 
    # strategy to next_strategy.
    for agent in agents
        agent.total_payoff = 0.0
        agent.strategy = agent.next_strategy
    end

    # Separate into women and men (doesn't need to be done every time 
    # but oh well--works with the model_step! approach as I can manage it).
    women = filter(agent -> !isman(agent), agents)
    men = filter(agent -> isman(agent), agents)

    # n_rounds random pairings and subsequent interactions are performed.
    for round_idx in 1:model.n_rounds
        
        # Create new randomized pairings.
        women = shuffle(women)
        men = shuffle(men)
        pairs = zip(women, men)

        for pair in pairs
            assign_payoffs!(pair[1], pair[2];
                            woman_threat = model.woman_threat,
                            man_threat = model.man_threat)
        end
    end

end


function run_model!(; payoffs::Payoffs = Payoffs(),
                     gendered::Bool = false, nsteps::Int = 100, 
                     collect_every::Int = 1, n_rounds::Int = 10,
                     numagents::Int = 100,
                     woman_threat::Float64 = 0.0,
                     man_threat::Float64 = 0.0)
    
    # Initialize model. Can optionally provide network or spatial structure,
    # but for our simple first model we will exclude these.
    model = ABM(Player; properties=Dict(:n_rounds => n_rounds,
                                        :gendered => gendered,
                                        :woman_threat => woman_threat,
                                        :man_threat => man_threat))

    # Initialize model agents.
    # First need numagents randomly-selected strategies.
    random_strategies = rand(fieldnames(Payoffs), numagents)
    
    # Now populate model with half women, half men.
    for i in 1:numagents

        if i > (numagents / 2)
            gender = "woman"
        else
            gender = "man"
        end
        strategy = String(random_strategies[i])
        add_agent!(model, gender, strategy, strategy, 0.0)

    end

    # Run model and collect specified data.
    data, _ = run!(model, agent_step!, model_step!, nsteps; 
                   adata = [:gender, :strategy, :total_payoff], 
                   when = 1:collect_every:nsteps+1,
                   agents_first = false)

    return data
end
