From: Jérôme Forissier <jerome.forissier@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [EXTERNAL] Re: libtomcrypt, AES-CTR: Missing counter-increment
 for non-crypto-accelerated archs?
Date: Fri, 24 Jan 2025 19:08:59 +0100
Message-ID: 
 <CA+NB=mb=fZ3_e38mb3fyF5jMv-PpmgCUsF_63Wi2XL9J4dFuUQ@mail.gmail.com>
In-Reply-To: <=?utf-8?q?=3CIA1PR21MB4631BAC8A123E995A9F4DC85F1E32=40IA1PR21MB?=
 =?utf-8?q?4631=2Enamprd21=2Eprod=2Eoutlook=2Ecom=3E?=>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2285209170298271096=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2285209170298271096==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

You're welcome. I have created https://github.com/OP-TEE/optee_os/pull/7243.

Regards,
--=20
Jerome

On Fri, 24 Jan 2025 at 18:57, Jork Loeser (he/him) <
Jork.Loeser@microsoft.com> wrote:

> That is quite excellent then, thank you for the tips & details! Appreciate
> the credit ;-)
>
>
>
> Best,
>
> Jork Loeser,
>
> Microsoft
>
>
>
> *From:* J=C3=A9r=C3=B4me Forissier <jerome.forissier@linaro.org>
> *Sent:* Friday, January 24, 2025 02:17
> *To:* Jork Loeser (he/him) <Jork.Loeser@microsoft.com>
> *Cc:* op-tee(a)lists.trustedfirmware.org
> *Subject:* [EXTERNAL] Re: libtomcrypt, AES-CTR: Missing counter-increment
> for non-crypto-accelerated archs?
>
>
>
> Hi Jork,
>
>
>
> On Fri, 24 Jan 2025 at 01:00, Jork Loeser (he/him) via OP-TEE <
> op-tee(a)lists.trustedfirmware.org> wrote:
>
> (Please provide a better way of reporting should this ML not be a good
> forum for bug-reports/fixes)
>
>
>
> The prefered place is on the OP-TEE OS GitHub issues section:
> https://github.com/OP-TEE/optee_os/issues, but this ML is OK too, unless
> the discussion involves a lot of code changes.
>
>
>
> Hello all,
>
> While experimenting with OP-TEE OS on a non-ARM platform (x86, to be
> precise), I noticed xtest regression_4003 and regression_4017 to be
> failing. It appears that for AES-CTR encrypt/decrypt,
> optee_os/core/lib/libtomcrypt/src/modes/ctr/ctr_encrypt.c:s_ctr_encrypt()<
> https://github.com/OP-TEE/optee_os/blob/37de1791d97d0df56db0709b5d001f82159=
8df39/core/lib/libtomcrypt/src/modes/ctr/ctr_encrypt.c#L41>
> fails to increment the counter on block boundaries when passed data covers
> a whole block. I suppose that it is a non-problem for architectures having
> crypto acceleration hooked up, since ctr_encrypt() bypasses s_ctr_encrypt()
> in that case.
>
>
>
> Yes, and even without acceleration the platforms we routinely build for
> (arm, arm64) do not set LTC_FAST and therefore do not use the part of the
> code that has the problem.
>
>
>
> The below fixes the behavior for my setup - xtest regression_4003 and
> regression_4017 pass as a result:
>
> diff --git a/core/lib/libtomcrypt/src/modes/ctr/ctr_encrypt.c
> b/core/lib/libtomcrypt/src/modes/ctr/ctr_encrypt.c
> index a23e33c05..2019de2b6 100644
> --- a/core/lib/libtomcrypt/src/modes/ctr/ctr_encrypt.c
> +++ b/core/lib/libtomcrypt/src/modes/ctr/ctr_encrypt.c
> @@ -61,6 +61,7 @@ static int s_ctr_encrypt(const unsigned char *pt,
> unsigned char *ct, unsigned lo
>         ct         +=3D ctr->blocklen;
>         len        -=3D ctr->blocklen;
>         ctr->padlen =3D ctr->blocklen;
> +       s_ctr_increment_counter(ctr);
>         continue;
>        }
> #endif
>
>
>
> This change looks totally correct to me, both in principle (given how CTR
> is supposed to work) and considering that the non-LTC_FAST part does call
> s_ctr_increment_counter() on a block boundary just a few lines below.
>
>
>
> I understand that you might prefer a full PR instead. Please accept my
> apologies for not providing such at this time; perhaps one of the
> maintainers (Jerome Forissier?) can take the above into consideration
> instead. If in doubt, consider above change as BSD-2-Clause'd.
>
>
>
> That's fine with me. I will create a PR. Let me know if I may credit you
> with a "Reported-by: Your Name <your.email>" tag.
>
>
>
> Many thanks for reporting!
>
>
>
> --
>
> Jerome Forissier
>
> Linaro
>
>
>
>
> Best,
> Jork Loeser,
> Microsoft
>
>

--===============2285209170298271096==--

