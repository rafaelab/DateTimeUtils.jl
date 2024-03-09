using DateTimeUtils
using Unitful


# convert `DateTime` to `CompoundPeriod`
t0 = DateTime(2024, 03, 09, 12, 11, 30, 1)
t1 = convert(Dates.CompoundPeriod, t0)
println("t1 = ", t1)
println("t1 date = ", convert(Dates.CompoundPeriod, Date(t0)))
println("t1 time = ", convert(Dates.CompoundPeriod, Time(t0)))


# `CompoundPeriod` to  `Unitful` time
t2 = convert(Unitful.Time, t1)


# convert from `Unitful` to `Dates`/`DateTime`
t2 = 4.2 * u"d"
println("t2 = ", t2) # in Unitful units
println("t2 = ", convert(Dates.CompoundPeriod, t2)) # in DateTime units
