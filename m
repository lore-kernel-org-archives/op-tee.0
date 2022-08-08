From: Joakim Bech <joakim.bech@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: Issue related to mempool allocation
Date: Mon, 08 Aug 2022 15:34:46 +0200
Message-ID: 
 <CA+Eyddbk=k8AkFd24s768dsd7FO8DEYkq7p23KQRqafE-JTEoQ@mail.gmail.com>
In-Reply-To: <
 <CAEf7q6OFuC1A9-EkO=8od5KMbTEZ3BonYbgKPqXFoNvuUKfiww@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0601411041153301800=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0601411041153301800==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Hi Ramakanth,

On Mon, 8 Aug 2022 at 15:20, ramakanth varala <ramakanth.varala@gmail.com>
wrote:

> Hi All,
>
> The above issue got closed.
>
You can always re-open a ticket if you want to.


>
> Need some more suggestions as mentioned below.
>
I believe Jerome did give a couple of suggestions in the ticket [1], have
you tried any of those?

[1] https://github.com/OP-TEE/optee_os/issues/5466#issuecomment-1202408119


>
> I am trying to get a CSR using mbedtls.
>
> This CSR needs rsa key as one of it's parameter, as of now using the
> mbedTLS api (mbedtls_rsa_gen_key ) for rsa key generation.
>
> I want rsa to be stored in TEE secure storage. This I guess can be done in
> two ways.
>
> 1. Use TEE_Generatekey for generating rsa key pair. Give this required key
> parameter to mbeldTLS API's to get the CSR workdone . Though I can store
> the rsa key , but as of now I don't know how to pass TEE generated RSA key
> pair to mbedTLS API's.
>
> Else
>
> 2. Use mbedTLS API's to  generate rsa key  and get CSR generation done.. In
> this method also , don't know how mbedTLS rsa key can be stored in the TEE
> secure storage
>
> Any inputs on this would be really appreciated.
>
> Thanks
>
>
> On Tue, Aug 2, 2022 at 12:41 PM ramakanth varala <
> ramakanth.varala(a)gmail.com>
> wrote:
>
> > Hi All,
> >
> >
> > I want to generate a rsa key pair with 4096 bits.
> >
> > Using below mbedTLS api , inside my TEE server side implementation.
> >
> >
> > ret = mbedtls_rsa_gen_key( mbedtls_pk_rsa( key ),
> mbedtls_ctr_drbg_random,
> > &ctr_drbg, 4096, 65537 );
> >
> >
> > This is resulting in the below error.
> > mempool_alloc:197Failed to allocate 288 bytes, please tune the pool
> > size failed
> >
> >
> >
> > Mines is arm64 infrastructure, with kernel 4.19.183 and optee_os 3.7.0
> >
> >
> > We tried doing below change (courtesy:
> > https://github.com/OP-TEE/optee_os/issues/3328) and recompiling tomcrypt
> > library
> >
> >
> > In core/lib/libtomcrypt/mpi_desc.c, we changed MPI_MEMPOOL_SIZE
> >
> >       #define MPI_MEMPOOL_SIZE        (42 * 1024)
> >
> > to    #define MPI_MEMPOOL_SIZE        (82 * 1024)
> >
> >
> > This didn’t help, kindly provide your inputs.
> >
> >
> > Thanks
> >
> >
> >
>


-- 
Regards,
Joakim

--===============0601411041153301800==--

