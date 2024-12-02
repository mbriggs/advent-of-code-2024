#!/usr/bin/env ruby
# https://adventofcode.com/2024/day/2

safe_reports = []

File.foreach("day2_data.txt") do |line|
  levels = line.split.map(&:to_i)

  safe = true

  if levels.length < 2
    safe_reports << levels
    next
  end

  report_inc = levels[0] < levels[1]

  levels.each_cons(2) do |a,b|
    amount_correct = (a - b).abs.between?(1, 3)

    levels_inc = a < b
    variance_correct = (report_inc && levels_inc) || (!report_inc && !levels_inc)

    if !(amount_correct && variance_correct)
      safe = false
      break
    end
  end

  if safe
    safe_reports << levels
  end
end

puts "safe reports: #{safe_reports.length}"

