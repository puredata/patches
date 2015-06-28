#ifndef absolute_h
#define absolute_h

// simple bithack alternative for abs()

#if PD_FLOAT_PRECISION == 32

static inline t_float fastabs(t_float f)
{
    union
    {
        t_float f;
        unsigned int ui;
    }alias;
    
    alias.f = f;
    alias.ui &= 0x7fffffff;
    return alias.f;
}


#elif PD_FLOAT_PRECISION == 64

static inline t_float fastabs(t_float f)
{
    union
    {
        t_float f;
        unsigned long long ui;
    }alias;
    
    alias.f = f;
    alias.ui[1] &= 0x7fffffff;
    return alias.f;
}

#endif  // end ifdef PD_FLOAT_PRECISION

#endif  // end ifndef absolute_h