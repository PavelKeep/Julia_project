#= Задача 6
Дано: На ограниченном внешней прямоугольной рамкой поле имеется ровно одна внутренняя перегородка в форме прямоугольника. Робот -в произвольной клетке поля между внешней и внутренней перегородками. 
Результат: Робот -в исходном положении и по всему периметру внутренней перегородки поставлены маркеры. 
=#

include("roblib.jl")
    #=
        invers(side::HorizonSide)
        movements!(r::Robot,side::HorizonSide,num_steps::Int)
        get_num_steps_movements!(r::Robot, side::HorizonSide)
        movements!(r::Robot,side::HorizonSide)
        moves!(r::Robot,side::HorizonSide)
        find_border!(r::Robot,direction_to_border::HorizonSide, direction_of_movement::HorizonSide)
    =#

function mark_from_perimetr(r::Robot)
    steps_up = moves!(r,Nord) #Идем вверх
    steps_left = moves!(r,West) #Идем влево
    steps_down = moves!(r,Sud) #Идем в низ 
    #Мы в левом нижнем углу


    #Робот - в юго-западном углу и в num_steps(пройденный путь)
    side = Nord
    snake!(r,side) #Двигаемся змейкой

   moves!(r,West)
   moves!(r,Sud)

   movements!(r,Nord, steps_down)
   movements!(r,Ost,steps_left)
   movements!(r,Sud,steps_up)
   # Робот - в исходном положении
end

function snake!(r::Robot, side::HorizonSide)
    fl = false
    while (isborder(r,side) == false) #Если сверху или снизу нет преграды - идем туда
        if (isborder(r,Ost)==true) #Если справа преграда
            fl = true
            break
        else #Если преграды нет
            move!(r,side)
        end
    end
    if (fl == false)
        move!(r,Ost)
        side = invers(side)
        snake!(r,side)
    else
        side = Ost #Ходим по кругу
        for way in (Nord, Ost, Sud, West)
            while isborder(r, side) == true && ismarker(r) == false
                putmarker!(r)
                move!(r,way)
            end
            putmarker!(r)
            move!(r,side)
            side = HorizonSide(mod(Int(side) - 1,4))
        end
        putmarker!(r)
    end
end