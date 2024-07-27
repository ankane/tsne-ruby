# t-SNE Ruby

High performance t-SNE for Ruby, powered by [Multicore t-SNE](https://github.com/DmitryUlyanov/Multicore-TSNE)

[![Build Status](https://github.com/ankane/tsne-ruby/actions/workflows/build.yml/badge.svg)](https://github.com/ankane/tsne-ruby/actions)

## Installation

Add this line to your application’s Gemfile:

```ruby
gem "tsne"
```

On Mac, also install OpenMP:

```sh
brew install libomp
```

## Getting Started

Prep your data

```ruby
x = [[0, 0, 0], [0, 1, 1], [1, 0, 1], [1, 1, 1]]
```

Run

```ruby
tsne = TSNE.new
tsne.fit_transform(x)
```

Get Kullback-Leibler divergence

```ruby
tsne.kl_divergence
```

## Full Example

Install the [matplotlib](https://github.com/mrkn/matplotlib.rb) gem and download the [optdigits.tes](https://archive.ics.uci.edu/ml/machine-learning-databases/optdigits/optdigits.tes) from the [Optical Recognition of Handwritten Digits Data Set](https://archive.ics.uci.edu/ml/datasets/Optical+Recognition+of+Handwritten+Digits).

```ruby
require "csv"
require "matplotlib/pyplot"
require "tsne"

data = []
target = []
CSV.foreach("optdigits.tes", converters: :numeric) do |row|
  data << row[0...-1]
  target << row[-1]
end

tsne = TSNE.new(n_jobs: 4)
embeddings = tsne.fit_transform(data)

vis_x = embeddings[true, 0]
vis_y = embeddings[true, 1]

plt = Matplotlib::Pyplot
plt.scatter(vis_x.to_a, vis_y.to_a, c: target, cmap: plt.cm.get_cmap("jet", 10), marker: ".")
plt.colorbar(ticks: 10.times.to_a)
plt.clim(-0.5, 9.5)
plt.show
```

## Parameters

```ruby
TSNE.new(
  n_components: 2,
  perplexity: 30.0,
  early_exaggeration: 12,
  learning_rate: 200,
  n_iter: 1000,
  n_iter_early_exag: 250,
  verbose: 0,
  random_state: -1,
  angle: 0.5,
  n_jobs: 1,
  cheat_metric: true
)
```

## Data

Data can be a Ruby array

```ruby
[[0, 0, 0], [0, 1, 1], [1, 0, 1], [1, 1, 1]]
```

Or a Numo array

```ruby
Numo::DFloat.new(4, 3).rand
```

## History

View the [changelog](https://github.com/ankane/tsne-ruby/blob/master/CHANGELOG.md)

## Contributing

Everyone is encouraged to help improve this project. Here are a few ways you can help:

- [Report bugs](https://github.com/ankane/tsne-ruby/issues)
- Fix bugs and [submit pull requests](https://github.com/ankane/tsne-ruby/pulls)
- Write, clarify, or fix documentation
- Suggest or add new features

To get started with development:

```sh
git clone https://github.com/ankane/tsne-ruby.git
cd tsne-ruby
bundle install
bundle exec rake vendor:all
bundle exec rake test
```
