From: jorge@foundries.io
To: op-tee@lists.trustedfirmware.org
Subject: Re: Optee + OpenSSH/OpenSSL
Date: Tue, 29 Aug 2023 20:28:02 +0200
Message-ID: <449D8B6D-97A9-4AE3-9FDB-CAB4D7D6F117@foundries.io>
In-Reply-To: <
 <CAFA6WYMSFc153i+r=yV3G0MW3FyfBgwoGsz+ma4Pg9E9190Tvg@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0140661959090752224=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0140661959090752224==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

     On 29 Aug 2023, at 11:56, Sumit Garg <sumit.garg@linaro.org> wrote:

   ﻿Hi Hareesh,
   On Tue, 29 Aug 2023 at 13:35, Hareesh Das Ulleri
   <hareesh.ulleri@ovt.com> wrote:

     Hello all,

       We are started using Op-tee in our project.

       Since we are new to Op-tee, could someone please confirm whether
     anyone has already tried below in their project or is it possible to
     use along with OpenSSH/OpenSSL ?

       What we try to accomplish is:  application/sshd -> openssl
     (libcrypto/provider) -> Optee (client/TA) -> (HW or SW cipher
     algorithm) for data encryption/decryption.

   I would rather suggest you to use the existing OP-TEE based PKCS#11
   engine for openssl. For detailed information, I would suggest you to
   go through [1].
   [1]
   https://optee.readthedocs.io/en/latest/building/userland_integration.ht
   ml#pkcs-11-driver

   check the architecture overview here

   [1]Over the Air Updates — FoundriesFactory 91 documentation
   [2]docs.foundries.io
   [3][4Lv1BGB9IcexDbd4RksnM0HENlhnGRZrCGudkEvjaT4eyY6TVqBjHOG6uD5pxvUcCqr
   418ATq2ZauthinRNayDSZbZ4J4tLIS6JIYj0+4vF2JlyT3yky1pfwfGQWy7GIC6VefTaYL7
   XTPHfsKNnOYBYTckon+D9aD2MnPuBZyagcx0xx1jqJAVp2sqUx5Bt0qsVPcQXiCsQViCsQV
   yCuQFyBuAJxBeIKxBWIKxBXIK5AXAHzCvwH9WAIYRB4imoAAAAASUVORK5CYII=]

   -Sumit

     Thanks,

     Hareesh

References

   Visible links:
   1. https://docs.foundries.io/latest/reference-manual/ota/ota.html
   2. https://docs.foundries.io/latest/reference-manual/ota/ota.html
   3. https://docs.foundries.io/latest/reference-manual/ota/ota.html

   Hidden links:
   5. https://docs.foundries.io/latest/reference-manual/ota/ota.html

--===============0140661959090752224==--

