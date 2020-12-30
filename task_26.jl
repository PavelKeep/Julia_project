#= Задача 26
Дано: Расставить маркеры в "полосочку" (через n пустых "полосок"). Причем "полосочки"
могут быть, в одном случае, "прямыми", а в другом - косыми.
Требуется написать обобщенную функцию, которая бы могла расставлять маркеры как по
"прямым" (горизонтальным или вертикальным), так и по наклонным линиям (наклоны
могут быть или в одну сторону или в другую), в соответствии со следующим описанием
функции:=#
 
function mark_zebra!(robot::Robot, line_side, ortogonal_line_side, num_passes, num_start_passes=0)
    start_side = get_start_side(line_side,ortogonal_line_side)
     

    num_steps = [get_num_steps_movements!(robot,start_side[i]) for i in 1:2]
    

    movements_if_posible!(robot, ortogonal_line_side, num_start_passes) || return
    line_mark!(robot,line_side)
    while movements_if_posible!(robot,ortogonal_line_side, num_passes) == true
        line_side = invers(line_side)
        line_mark!(robot,line_side)
    end

    for s in start_side
        movements!(r,s)
    end
    

    back_side=invers(start_side)
    for (i,num) in enumerate(num_steps)
        side = isodd(i) ? invers(line_side) : invers(ortogonal_line_side)
        movements!(robot,side, num)
    end
    
end

function movements_if_posible!(robot, side, max_num_steps)
    for _ in 1:max_num_steps
        isborder(robot,side) && (return false)
        move!(robot,side)
    end
    return true
end

function line_mark!(robot,side)
    putmarker!(robot)
    putmarkers!(robot,side)
end

get_start_side(line_side::HorizonSide,ortogonal_line_side::HorizonSide) = (line_side,ortogonal_line_side)


get_start_side(line_side::NTuple{2,HorizonSide}, ortogonal_line_side::NTuple{2,HorizonSide}) = ortogonal_line_side
HorizonSideRobots.isborder(r::Robot,side::NTuple{2,HorizonSide}) = isborder(r,side[1]) || isborder(r,side[2])

HorizonSideRobots.move!(r::Robot,side::NTuple{2,HorizonSide}) = for s in side move!(r,s) end

putmarkers!(r::Robot,side::NTuple{2,HorizonSide}) =
    while isborder(r,side)==false
        move!(r,side)
        putmatker!(r)
    end
