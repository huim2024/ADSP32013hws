import JuMP
import HiGHS
using DataStructures

function standard_setup(A,b,c, optimizer=()->HiGHS.Optimizer())
    model = JuMP.Model(optimizer)
    JuMP.set_silent(model)
    n = size(c)[1]
    JuMP.@variable(model, x[1:n] >= 0)
    JuMP.@constraint(model, A*x <= b)
    JuMP.@objective(model, Min, c'x)
    JuMP.optimize!(model)
    return model
end

function report(model)
    @debug(model)
    if JuMP.is_solved_and_feasible(model, allow_local=false, dual=true)
        @debug("summary", JuMP.solution_summary(model))
        @info("optimum", JuMP.objective_value(model))
        @info("solution", LittleDict(JuMP.name(var) => JuMP.value(var) for var in JuMP.all_variables(model)))
    else
        @error(JuMP.termination_status(model))
    end
end
