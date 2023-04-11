bool p; 

active proctype all() {
    do
    :: true -> p = !p; printf("p: %d\n", p);
    :: true -> skip; printf("p: %d\n", p);
    od;
}
