function x = simplex(A, b, c, N_ind, B_ind)
    [m,n] = size(A)
    x = zeros(n, 1)
    iteration = 0
    while true
        B = [A(:,B_ind(1:m))]
        N = [A(:,N_ind(1:(n-m)))]
        c_B = [c(B_ind(1:m))]
        c_N = [c(N_ind(1:(n-m)))]
        #step 1 - basic solution
        x_b = B\b
        #step 2 - reduced costs
        lambda = B'\c_B
        k = 1, minimum = Inf
        for j = 1:(n-m)
            c_rel(j) = c(N_ind(j)) - lambda'*A(:,N_ind(j))
            if c_rel(j) < minimum       #Dantzig rule
                minimum = c_rel(j)
                k = j
            end
        end
        if c_rel >= 0   #step 3 - optimality test
            cont = false
            disp("optimal point found")
            for i = 1:m
                x(B_ind(i)) = x_b(i)
            end
            return
        end
        y = B\A(:,N_ind(k)) #step 4 - simplex direction

        if y <= 0
            disp("no finite optimal solution")
            for i = 1:m
                x(B_ind(i)) = x_b(i)
            end
            return
        end
        epsilon = Inf   #step 5 - 
        l = 1
        for j = 1:m
            if y(j) > 0
                ratio = x_b(j)/y(j)
                if ratio < epsilon
                    epsilon = ratio
                    l = j
                end
            end
        end
        [N_ind(k), B_ind(l)] = deal(B_ind(l),N_ind(k))
        iteration += 1
    end
end