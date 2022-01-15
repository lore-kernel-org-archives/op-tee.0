From: Randy Dunlap <rdunlap@infradead.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] docs: staging/tee.rst: fix two typos found while reading
Date: Sat, 15 Jan 2022 07:30:14 -0800
Message-ID: <a6b32e17-9aba-4a03-12db-0d707e0f8d26@infradead.org>
In-Reply-To: <20220115125236.34886-1-wanngchenng@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6059922899766421607=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6059922899766421607==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable



On 1/15/22 04:52, Wang Cheng wrote:
> Signed-off-by: Wang Cheng <wanngchenng@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  Documentation/staging/tee.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/staging/tee.rst b/Documentation/staging/tee.rst
> index 3c63d8dcd61e..498343c7ab08 100644
> --- a/Documentation/staging/tee.rst
> +++ b/Documentation/staging/tee.rst
> @@ -255,7 +255,7 @@ The following picture shows a high level overview of AM=
D-TEE::
>   +--------------------------+      +---------+--------------------+
> =20
>  At the lowest level (in x86), the AMD Secure Processor (ASP) driver uses t=
he
> -CPU to PSP mailbox regsister to submit commands to the PSP. The format of =
the
> +CPU to PSP mailbox register to submit commands to the PSP. The format of t=
he
>  command buffer is opaque to the ASP driver. It's role is to submit command=
s to
>  the secure processor and return results to AMD-TEE driver. The interface
>  between AMD-TEE driver and AMD Secure Processor driver can be found in [6].
> @@ -290,7 +290,7 @@ cancel_req driver callback is not supported by AMD-TEE.
> =20
>  The GlobalPlatform TEE Client API [5] can be used by the user space (clien=
t) to
>  talk to AMD's TEE. AMD's TEE provides a secure environment for loading, op=
ening
> -a session, invoking commands and clossing session with TA.
> +a session, invoking commands and closing session with TA.
> =20
>  References
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

--=20
~Randy

--===============6059922899766421607==--

