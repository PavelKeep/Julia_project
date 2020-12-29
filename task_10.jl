#= Задача 10 
ДАНО:Робот - в юго-западном углу поля, на котором расставлено некоторое количество маркеров
РЕЗУЛЬТАТ: Функция верула значение средней температуры всех замаркированных клеток
=#

function sigma_temper!(r::Robot)::Real
    side = Ost
    count = 0
    total = 0
    res = 0
    total = search_temp(r,side,res,count)
    return total
end

function search_temp(r::Robot,side::HorizonSide, count::Int, res::Int)::Real
    while (isborder(r,side)==false)
        if (ismarker(r) == true)
            res += temperature(r)
            count += 1
        end
        move!(r,side)
    end 
    if (isborder(r,Nord)==false)
        move!(r,Nord)
        if (ismarker(r) == true)
            res += temperature(r)
            count += 1
        end
        side = invers(side)
        search_temp(r,side,count,res)
    end
    return (res/ count)
end