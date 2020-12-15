%Image collection

x = imread('pakistan.png');
x = rgb2gray(x);
x = x>50;

%Border Creation

shape = size(x);
rows = shape(1,1);
columns = shape(1,2);


for i = 1:rows 
    for j = 1:columns 
        for z = 1:16
            x(z,j) = 0;
            x(i,z) = 0;
            x(rows -z,j) = 0;
        end               
    end             
end 
        

% Resizing image

[rows,columns] = size(x);

size_factor = 16;

a = zeros(rows/size_factor, columns/size_factor );

x_val = 1;
y = 1;


for i = 1:size_factor:rows
    for j = 1:size_factor:columns
        a(x_val,y) = x(i,j);
        y = y + 1;
        
    end
    x_val = x_val +1;
    y = 1;
end

a = a';
a = flipdim(a ,2);           %# horizontal flip

imshow(a)
impixelinfo

[rows,columns] = size(a);  %Matrix of resized image


pause(1)


% Motor and Sensor assignment


myev3 = legoev3('usb');
mytouch = touchSensor(myev3);
horizontal_motor = motor(myev3,'A');
pen_motor = motor(myev3,'C');
paper_motor = motor(myev3,'D');


% Printing Loop

press_factor = 0.81; %accounts for difference in rotation when pressed and not
speed_across  = 100;
speed_down = 50;
angle_down = 75;


    
for j =1:rows
    
    %moves pen back to the left
    motor_touch(horizontal_motor,mytouch,-100)
    
    %motor_rotate(horizontal_motor,-50,-520);
    
    pause(1)
    
    
    %moves paper in
    
    motor_rotate(paper_motor,-50,-3.5)
    Length = 1;
    
    
    
    for i =1:columns
        
        if i == columns
            
            if a(j,columns) == 0
                
                %lower pen
                motor_rotate(pen_motor,-speed_down,-angle_down);
                % Draw on black pixels
                motor_rotate(horizontal_motor,speed_across,Length*13);
                %raise pen
                motor_rotate(pen_motor,speed_down,angle_down);
                Length = 1;
            
            else
                
                %Draw on white pixels
                motor_rotate(horizontal_motor,speed_across,Length*13*press_factor);
                
                
            end
           
     
        else 
            
            if a(j,i) == a(j,i+1)
                
                Length = Length +1;
                
            else
                if  a(j,i+1) == 1
                    
                    %lower pen
                    motor_rotate(pen_motor,-speed_down,-angle_down);
                    
                    % Draw on black pixels
                    motor_rotate(horizontal_motor,speed_across,Length*13);
                    
                    %raise pen
                    motor_rotate(pen_motor,speed_down,angle_down);
                    Length = 1;
                    
                else
                    
                    %Draw white pixels
                    motor_rotate(horizontal_motor,speed_across,Length*13*press_factor);
                    Length = 1;
                end
            end
        end
    end
end

return
                    
              
                    
                    
                    
             