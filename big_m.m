function x = big_m(A, b, c)
    [m,n] = size(A)
    if A(:, (n-m+1):n) == eye(m)
        N_ind = [1:(n-m)], B_ind = [(n-m+1):n]
    else
        A = [A eye(m)]
        c = [c; Inf*ones(m,1)]
        N_ind = [1:n], B_ind = [(n+1):(n+m)]
    end
    x_ = simplex(A, b, c, N_ind, B_ind)
end
