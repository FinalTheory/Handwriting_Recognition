function DFS( row, col )

global img num mov;
img(row, col) = 0;
num = num + 1;

for i = 1:8
    new_row = row + mov(i, 1);
    new_col = col + mov(i, 2);
    if ( check(new_row, new_col) == 1 && img(new_row, new_col) == 1 )
        DFS(new_row, new_col);
    end
end

end

function status = check( row, col )
    global img;
    if ( row < 1 || row > size(img, 1) || col < 1 || col > size(img, 2) )
        status = 0;
        return
    end
    status = 1;
end