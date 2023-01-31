struct numbers{
    int a;
};

program SINE_PROG{
version SINE_VERS{
    float sine(numbers)=1;
 }=1;
}=0x4562877;

client.c
#include "sine.h"


void
sine_prog_1(char *host, int x)
{
    CLIENT *clnt;
    float  *result_1;
    numbers  sine_1_arg;

#ifndef    DEBUG
    clnt = clnt_create (host, SINE_PROG, SINE_VERS, "udp");
    if (clnt == NULL) {
   	 clnt_pcreateerror (host);
   	 exit (1);
    }
#endif    /* DEBUG */
    sine_1_arg.a=x;
    result_1 = sine_1(&sine_1_arg, clnt);
    if (result_1 == (float *) NULL) {
   	 clnt_perror (clnt, "call failed");
    }
    else{
   	 printf("Result:%f\n", *result_1);
    }
#ifndef    DEBUG
    clnt_destroy (clnt);
#endif     /* DEBUG */
}


int
main (int argc, char *argv[])
{
    char *host;

    if (argc < 2) {
   	 printf ("usage: %s server_host\n", argv[0]);
   	 exit (1);
    }
    host = argv[1];
    sine_prog_1 (host,atoi(argv[2]));
exit (0);
}

server.c


#include "sine.h"
float poww(float x,int j){
if(j==0)
return 1;
else if(j==1)
return x;
else
return x*poww(x,j-1);
}
int fac(int x)
{
    int i,fac=1;
    for(i=1;i<=x;i++)
   	 fac=fac*i;
    return fac;
}
float *
sine_1_svc(numbers *argp, struct svc_req *rqstp)
{
    static float  result;
    float x,Q,sum=0;
    int i,j,limit=5;
    x=argp->a;
    Q=x;
    x = x*(3.1415/180);
    for(i=1,j=1;i<=limit;i++,j=j+2)
    {
   	 if(i%2!=0)
   	 {
   		 sum=sum+poww((float)x,j)/fac(j);
   	 }
   	 else
   		 sum=sum-poww((float)x,j)/fac(j);
    }
    printf("sine(%0.1f): %f",&Q,&sum);
    result=sum;
    return &result;
}
