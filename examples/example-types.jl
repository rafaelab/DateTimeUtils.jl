using DateTimeUtils


# Inherit time type from `Dates.jl`
t1 = Time(10, 25, 01) # 10 hours, 25 minutes, 1 second
println("t1 = ", t1)

# Count number of seconds in t1
println("t1 in seconds = ", secondsIn(t1))
println("t1 in nanoseconds =", nanosecondsIn(t1))

# Note that this is different from `second(t1)`, which will return jut the seconds
println("seconds in t1 = ", second(t1))
println("minutes in t1 = ", minute(t1))
println("hours in t1 = ", hour(t1))

# Try defining a minute type
t2a = Minute(42)
t2b = Second(21)
t2 = t2a + t2b
println("t2 = ", t2)

# using a date
t3 = DateTime(2024, 03, 09, hour(t1), minute(t1), second(t1))
println("t3 = ", t3)
println("t3 day = ", day(t3))
println("t3 year = ", year(t3))

