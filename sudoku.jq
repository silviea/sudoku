def p:3;
def q:p*p;
def s:[range(q)+1];
def s3:s|[combinations(3)];
def clausify:map([(.|map([.,true])),(combinations(2)|select(.[0]<.[1])|map([.,false]))]);
def cells:s3|group_by([.[0],.[1]])|clausify;
def rows: s3|group_by([.[0],.[2]])|clausify;
def cols: s3|group_by([.[1],.[2]])|clausify;
def sqrs: s3|group_by([((.[0]-1)/p|floor),((.[1]-1)/p|floor),.[2]])|clausify;

def dimacsify_literal:(if .[1]==false then "-" else "" end)+(.[0]|map(tostring)|join(""));
def dimacsify_clause:map(dimacsify_literal)+["0"]|join(" ");

def dimacsify2_atom:((((.[0]-1)*q)+(.[1]-1))*q)+(.[2]-1)|.+1;
def dimacsify2_literal:(if .[1]==false then -1 else 1 end)*(.[0]|dimacsify2_atom);
def dimacsify2_clause:map(dimacsify2_literal)+[0]|map(tostring)|join(" ");

def undimacsify2_atom:(.-1)|[((((./q)|floor)/q)|floor)+1,(((./q)|floor)%q)+1,(.%q)+1];
def undimacsify2_literal:[(if (.<0) then (.*-1) else . end|undimacsify2_atom),(.>0)];
def undimacsify2_output:split(" ")|map(select(.!="")|tonumber|undimacsify2_literal);
#bla
