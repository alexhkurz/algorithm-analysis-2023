bool p; 
bool q; 

active proctype all() {
    do
    :: true -> p = !p; printf("p: %d, q: %d\n", p, q);
    :: true -> q = !q; printf("p: %d, q: %d\n", p, q);
    :: true -> skip; printf("p: %d, q: %d\n", p, q);
    od;
}
