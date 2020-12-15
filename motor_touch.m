function [] = motor_touch(mymotor,mytouch,speed)
%MOTOR_TOUCH Rotates a given motor at a given speed until the touch sensor
%detects contact



mymotor.Speed = speed;
start(mymotor);



while mymotor.Speed == mymotor.Speed
    if readTouch(mytouch) == 1
        stop(mymotor)
        break
    else
        continue
    end
end



end

