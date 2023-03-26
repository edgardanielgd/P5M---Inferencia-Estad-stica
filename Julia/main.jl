# Neede packages
import Pkg;
Pkg.add("CSV");
Pkg.add("DataFrames");
Pkg.add("Distributions");
Pkg.add("Plots");

# Use packages
using CSV
using DataFrames
using Distributions
using Plots

function prob_distribution()
    # Create a normal distribution
    d = Normal(0, 1)
    # Get the probability of a value
    println("Probability of 0: ", pdf(d, 0))
    # Get the cumulative probability of a value
    println("Cumulative probability of 0: ", cdf(d, 0))
    # Get the quantile of a probability
    println("Quantile of 0.5: ", quantile(d, 0.5))
end

# Read DataFrame
#df = CSV.read("./data/googleplaystore.csv", DataFrame)

#println("Initializing project")

# Describe data
#println(describe(df))

# Show first 5 rows
#println("First 5 rows:")
#println(first(df, 5))

@userplot CirclePlot
@recipe function f(cp::CirclePlot)
    x, y, i = cp.args
    n = length(x)
    inds = circshift(1:n, 1 - i)
    linewidth --> range(0, 10, length=n)
    seriesalpha --> range(0, 1, length=n)
    aspect_ratio --> 1
    label --> false
    x[inds], y[inds]
end

n = 150
t = range(0, 2π, length=n)
x = sin.(t)
y = cos.(t)

@animate for i ∈ 1:n
    circleplot(x, y, i)
end
#gif(anim, "anim_fps15.gif", fps=15)
