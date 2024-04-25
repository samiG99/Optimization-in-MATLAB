function [D,P] = FloydWarshall(D) % argument är en matris D kolumner(till) och rader(från)

P=zeros(length(D)); % noll matris med storlek D
for i=1:length(D) % storlek på matrisen (en rad eller en kolumn)
    for j=1:length(D) % iterera över alla element i N*N matrisen
        if( D(i,j) ~= Inf && i ~= j) % skippa alla inf och diagonalen
            P(i,j) = i; % lägg föregående element i vägen till P matrisen (om start och slut inte är samma)
        end
    end
end

for k = 1:length(D)
    for i = 1:length(D)
        for j = 1:length(D)
            if(D(i,k) + D(k,j) < D(i,j)) % om den hittar en kortare väg som går genom k
                D(i,j) = D(i,k) + D(k,j); % lägg kostnaden i lämplig element i matrisen D
                P(i,j) = P(k,j); % lägg föregående element i vägen till P matrisen
            end
        end
    end
end
end