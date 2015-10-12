# This file is a part of Julia. License is MIT: http://julialang.org/license

using Base.Test

function runtests(name)
    @printf("     \033[1m*\033[0m \033[31m%-21s\033[0m", name)
    exename = joinpath(JULIA_HOME, Base.julia_exename())
    testcmd = "using Base.Test; blas_set_num_threads(1); include(\"$name.jl\") " # use space to add single quotes when printed in shell
    tt = @elapsed run(`$exename --check-bounds=yes --depwarn=error -e $testcmd`)
    # tt = @elapsed include("$name.jl")
    @printf(" in %6.2f seconds\n", tt)
    nothing
end

function propagate_errors(a,b)
    if isa(a,Exception)
        rethrow(a)
    end
    if isa(b,Exception)
        rethrow(b)
    end
    nothing
end

# looking in . messes things up badly
filter!(x->x!=".", LOAD_PATH)
