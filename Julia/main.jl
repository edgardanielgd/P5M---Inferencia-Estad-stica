# Neede packages
import Pkg;
Pkg.add("CSV");
Pkg.add("DataFrames");
Pkg.add("DecisionTree");
Pkg.add("Plots");

# Use packages
using CSV
using DataFrames
using Distributions
using Plots
using DecisionTree

# Read DataFrame
df = CSV.read("./data/googleplaystore.csv", DataFrame)

println("Initializing project")

# Describe data
println(describe(df))

# Show first 5 rows
println("First 5 rows:")
println(first(df, 5))

