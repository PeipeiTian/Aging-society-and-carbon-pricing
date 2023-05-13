
%%-----------------------------------------------------------------------------------
% calculate the indirect impact of carbon price on age groups (C_q^indir)
clc;
clear;
A=xlsread('A.xlsx',1);
Y=xlsread('Y.xlsx',1);

   L=zeros(9800,9800);
   L=eye(9800)-A;
   X1=L\Y;
   X=sum(X1,2);
  F=xlsread('E.xlsx',1);% E is carbon emission accounts in EXIOBASE, which is constructed in Excel
  i=1;
  E1=zeros(1,9800);
  while i<=9800
    if X(i,1)<0.0001   
       E1(1,i)=0;
    else
       E1(1,i)=(F(1,i)/10^3)/(X(i,1)*10^6);  
    end
       i=i+1;
  end
  
  CT=xlsread('CT.xlsx',1);% CT are carbon prcing scenarios, which is constructed in Excel
  E=zeros(9800,9800);
  E=(40/1.1118)*diag(CT)*diag(E1);
  Y_age=xlsread('Y_2015_age_merge.xlsx',1);% Y_age is constructed through RAS based method 
  Footprint=E*(L\Y_age);
  Footprint_sum=sum(Footprint);
  
  
 i=1;j=1;
  for i=1:124
      Y_c1=Y_age(:,i);
      Y_c=diag(Y_c1);
      Footprint_ind3=E*(L\Y_c);
      Footprint_ind2=sum(Footprint_ind3);
      Footprint_ind1(:,i)=Footprint_ind2';
  end

  
  Footprint_ind=zeros(200,124);
  Y_ind=zeros(200,124);
   i=1;j=1;
  for i=1:200
      Footprint_ind(i,:)=Footprint_ind1(i,:); 
      Y_ind(i,:)=Y_age(i,:);
      for j=1:48
      Footprint_ind(i,:)=Footprint_ind(i,:)+Footprint_ind1(i+200*j,:); 
      Y_ind(i,:)=Y_ind(i,:)+Y_age(i+200*j,:);
      end
  end
  
  %%-----------------------------------------------------------------------------------
  % The calculated of the direct impact of carbon price on age groups is  done in Excel
