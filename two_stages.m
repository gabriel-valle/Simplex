function x = two_stages(A, b, c)
    [m,n] = size(A)
    if A(:, (n-m+1):n) == eye(m)
        N_ind = [1:(n-m)], B_ind = [(n-m+1):n]
    else
        for i = 1:m
            if b(i) < 0
                A(i,:) *= -1
                b(i) *= -1
            end
        end
        A_ = [A eye(m)]
        c_ = [zeros(n,1); ones(m,1)]
        N_ind_ = N_ind = [1:n], B_ind_ = [(n+1):(n+m)]
        x_ = simplex(A_, b, c_, N_ind_, B_ind_)
        disp(x_)
        if any(x_((n+1):(n+m)) != 0)
            disp("problema não factível")
            x = NaN
            return
        end
        N_ind = [], B_ind = []
        for i = 1:n
            if length(N_ind) < n-m && x_(i) == 0
                N_ind = [N_ind i]
            else
                B_ind = [B_ind i]
            end
        end
    end
    x = simplex(A,b,c,N_ind,B_ind)
    return
end