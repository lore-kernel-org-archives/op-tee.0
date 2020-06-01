From: Jerome Forissier <jerome@forissier.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [op-tee] [llvm-dev] Aarch64: unaligned access despite -mstrict-align
Date: Mon, 01 Jun 2020 18:51:43 +0200
Message-ID: <4c149e1a-7326-152c-de39-7008a9be9751@forissier.org>
In-Reply-To: <=?utf-8?q?=3CDB6PR0801MB1990BB7412DEDE94940F42C5FC8A0=40DB6PR08?=
 =?utf-8?q?01MB1990=2Eeurprd08=2Eprod=2Eoutlook=2Ecom=3E?=>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4092464677797792363=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4092464677797792363==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 6/1/20 6:26 PM, Sjoerd Meijer wrote:
> Sorry, quick message to ignore what I wrote before, I got myself confused (=
probably you too),

:)

> With a recent trunk build I get this:
>=20
> f:
>         adrp    x8, g
>         ldr     x8, [x8, :lo12:g]
>         mov     w2, #16
>         mov     x1, x0
>         mov     x0, x8
>         b       memcmp
>=20
> This looks more correct, and I need to look a bit more into this (and how c=
lang 10.0.0 behaves).

Indeed I would be quite happy with that ;-) Good to know that master
generated this. If you would you like me to bisect and identify the
commit that changed the behavior, please let me know.

Thanks,
--=20
Jerome

--===============4092464677797792363==--

