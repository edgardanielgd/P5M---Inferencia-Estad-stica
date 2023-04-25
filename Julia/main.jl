# Neede packages
import Pkg;
Pkg.add("CSV");
Pkg.add("DataFrames");
Pkg.add("DecisionTree");
Pkg.add("Plots");
Pkg.add("Statistics");

# Use packages
using CSV
using DataFrames
using Distributions
using Plots
using DecisionTree
using Statistics
using Random
using CategoricalArrays

# Read DataFrame
# df = CSV.read("./data/googleplaystore.csv", DataFrame)

# println("Initializing project")

# # Exploring dataset size
# println("Dataset size: ", size(df))

# # Exploring dataset structure
# println("Dataset columns:")
# show(df, allcols=true)

# # Show first 5 rows
# println("First 5 rows:")
# println(first(df, 5))

##############
## Testing with a well-known dataset
X, y = DecisionTree.load_data("iris")

X = float.(X)
y = string.(y)

# Split into Train and test data
function split_data(y, percent)
    uniq_class = unique(y)
    keep_index = []
    for class in uniq_class
        class_index = findall(y .== class)
        row_index = sample(class_index,
            floor(Int, length(class_index) * percent)
        )
        push!(keep_index, row_index...)
    end
    return keep_index
end

# trainning data indexes
train_index = split_data(y, 0.7)

# Testing data indexes
test_index = setdiff(1:length(y), train_index)

# Finally split data
X_train = X[train_index, :]
X_test = X[test_index, :]

y_train = y[train_index]
y_test = y[test_index]

# trainning model
model = DecisionTree.DecisionTreeClassifier(max_depth=2)
DecisionTree.fit!(model, X_train, y_train)

# Predicting
y_pred = DecisionTree.predict(model, X_test)

# Accuracy
accuracy = mean(y_pred .== y_test)

println("Accuracy: ", accuracy)