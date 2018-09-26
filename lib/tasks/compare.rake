require 'benchmark'

desc "benchmarks json stuff"
task benchmark: :environment do
  total_posts = 100_000
  Benchmark.bm do |x|
    x.report { Post.standard_serialize(total_posts) }
    x.report { Post.sql_serialize(total_posts) }
  end
end