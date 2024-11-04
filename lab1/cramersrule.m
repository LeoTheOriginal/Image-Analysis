A=[1,2,3,4;4,9,16,25;1,7,2,3;2,3,5,7];
b = [1;2;3;4];
w=det(A);
for i =  1:4
    Acpy=A;
    Acpy(:,i)=b;
    x(i) = det(Acpy)/w;
end
x