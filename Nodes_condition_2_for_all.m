clear all;

% Index is one of the eigenvectors which is associated to -1-eigenvalue
Index=829; 

for p=1:20

Matrix=fullfile(sprintf('Matrix%g.dat', p));

Nodes_condition_1=fullfile(sprintf('Nodes_condition_1%g.dat', p));

Nodes_condition_2=fullfile(sprintf('Nodes_condition_2%g.dat', p));

M=load(Matrix);

[Eigenvectors,Eigenvalues]=eig(M);

clear Eigenvalues;

Eigenvalues=eig(M);

Nodes_condition_1=load(Nodes_condition_1);

Nodes_condition_1_bis=Nodes_condition_1(:,1);

Nodes_condition_1_bis(size(Nodes_condition_1,1)+1:2*size(Nodes_condition_1,1),1)=Nodes_condition_1(:,2);

clear Nodes_condition_1

Nodes_condition_1=Nodes_condition_1_bis;

clear Nodes_condition_1_bis

k=0;

for i=1:size(Nodes_condition_1,1)
    for j=i+1:size(Nodes_condition_1,1)
    if Nodes_condition_1(i,1)==Nodes_condition_1(j,1)
    k=k+1;
    else
    'FALSE';
    end
    end
Nodes_condition_1(i,2)=k;
k=0;
end

 k=0;
clear i;
clear j;

for i=size(Nodes_condition_1,1):-1:1
    if Nodes_condition_1(i,2)==0
    'FALSE';
    else
    Nodes_condition_1(i,:)=[];
end
end

clear i;

Nodes_condition_1(:,2)=[];

Non_zero_entries=find(round(Eigenvectors(:,Index)*10000)/10000);

for i=1:size(Non_zero_entries,1)
    for j=1:size(Nodes_condition_1,1)
    if Non_zero_entries(i,1)==Nodes_condition_1(j,1)
    k=k+1;
    else
    'FALSE';
    end
    end
Non_zero_entries(i,2)=k;
k=0;
end

clear i;
clear j;
k=0;

for i=size(Non_zero_entries,1):-1:1
    if Non_zero_entries(i,2)==0
    'FALSE';
    else
    Non_zero_entries(i,:)=[];
    end
end

clear i;

Non_zero_entries(:,2)=[];

for i=1:size(Non_zero_entries,1)
    fprintf(fid, '%d\n', Non_zero_entries(i,1));
end

clear i;

fclose('all');

clear all;

end












