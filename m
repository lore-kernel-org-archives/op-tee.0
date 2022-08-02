From: ramakanth varala <ramakanth.varala@gmail.com>
To: op-tee@lists.trustedfirmware.org
Subject: Issue related to mempool allocation
Date: Tue, 02 Aug 2022 07:12:34 +0000
Message-ID: 
 <CAEf7q6MnaJQNE2G1oXzueHMu-EkdM2O7YoNbptTbdXME3As04A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8374830469817473926=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8374830469817473926==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Hi All,


I want to generate a rsa key pair with 4096 bits.

Using below mbedTLS api , inside my TEE server side implementation.


ret = mbedtls_rsa_gen_key( mbedtls_pk_rsa( key ), mbedtls_ctr_drbg_random,
&ctr_drbg, 4096, 65537 );


This is resulting in the below error.
mempool_alloc:197Failed to allocate 288 bytes, please tune the pool
size failed



Mines is arm64 infrastructure, with kernel 4.19.183 and optee_os 3.7.0


We tried doing below change (courtesy:
https://github.com/OP-TEE/optee_os/issues/3328) and recompiling tomcrypt
library


In core/lib/libtomcrypt/mpi_desc.c, we changed MPI_MEMPOOL_SIZE

      #define MPI_MEMPOOL_SIZE        (42 * 1024)

to    #define MPI_MEMPOOL_SIZE        (82 * 1024)


This didn’t help, kindly provide your inputs.


Thanks

--===============8374830469817473926==--

