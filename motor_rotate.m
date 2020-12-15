function [] = motor_rotate(mymotor,speed, rotation_angle)
%MOTOR_ROTATE Rotates the given motor at a given speed 
%until rotation angle is achieved
%
mymotor.Speed = speed;
resetRotation(mymotor);
start(mymotor);


if speed > 0
    while mymotor.Speed == mymotor.Speed
        if readRotation(mymotor) > rotation_angle
            stop(mymotor) 
            break
        else
            continue
    
        end
        
    end
    
    
elseif speed < 0
    
    
    while mymotor.Speed == mymotor.Speed
        if readRotation(mymotor) < rotation_angle
            stop(mymotor) 
            break
        else
            continue
    
        end
        
    end
    
    
    
    



end



